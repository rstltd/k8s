#!/usr/bin/env bash
# -----------------------------------------------------------------------------
# setup-k8s.sh – Provision a single Debian 12 (Bookworm) host for Kubernetes
# -----------------------------------------------------------------------------
# * Disables swap (required by kubelet)
# * Installs & configures Docker Engine + cri‑dockerd runtime shim
# * Installs kubeadm / kubelet / kubectl (pinned to the chosen version)
# -----------------------------------------------------------------------------
# Tested on: Debian 12 (Bookworm) – kernel 6.1+ – systemd 252+
# -----------------------------------------------------------------------------
set -euo pipefail

# --- Adjustable variables ----------------------------------------------------
K8S_VERSION="1.28.0"                # Kubernetes version (x.y.z)
DOCKER_BASE_POOL="172.31.0.0/16"   # Default docker bridge address pool base
DOCKER_POOL_SIZE="24"              # Size of each address pool subnet
DOCKER_BIP="172.7.0.1/16"          # Fixed bridge IP for docker0
# -----------------------------------------------------------------------------

# 1. Disable and remove swap (kubelet requirement)
disable_swap() {
  echo "[*] Disabling swap..."
  sysctl -w vm.swappiness=0
  swapoff -a
  if grep -qE "\\sswap\\s" /etc/fstab; then
    sed -i.bak '/ swap / s/^/#/' /etc/fstab
  fi
  echo "[*] Swap disabled."
}

# 2. Install and configure Docker Engine
install_docker() {
  echo "[*] Installing Docker Engine..."
  apt-get update -y
  apt-get install -y ca-certificates curl gnupg lsb-release

  # Add Docker’s official GPG key & repository for Debian 12
  install -m 0755 -d /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  chmod a+r /etc/apt/keyrings/docker.gpg

  echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
    https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
    | tee /etc/apt/sources.list.d/docker.list > /dev/null

  apt-get update -y
  apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

  # Configure docker daemon
  cat > /etc/docker/daemon.json <<EOF
{
  "log-driver": "json-file",
  "log-opts": {
    "tag": "{{.Name}}",
    "max-size": "2m",
    "max-file": "2"
  },
  "default-address-pools": [
    {
      "base": "${DOCKER_BASE_POOL}",
      "size": ${DOCKER_POOL_SIZE}
    }
  ],
  "bip": "${DOCKER_BIP}"
}
EOF

  systemctl enable --now docker
  echo "[*] Docker installed and configured."
}

# 3. Install kubelet / kubeadm / kubectl
install_k8s_tools() {
  echo "[*] Installing Kubernetes tools (v${K8S_VERSION})..."
  apt-get update -y
  apt-get install -y apt-transport-https ca-certificates curl gpg

  # Add Kubernetes signing key & repository (Debian)
  install -m 0755 -d /etc/apt/keyrings
  curl -fsSL https://pkgs.k8s.io/core:/stable:/v${K8S_VERSION}/deb/Release.key | \
    gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

  echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] \
    https://pkgs.k8s.io/core:/stable:/v${K8S_VERSION}/deb/ /" \
    | tee /etc/apt/sources.list.d/kubernetes.list > /dev/null

  apt-get update -y
  apt-get install -y kubelet kubeadm kubectl
  apt-mark hold kubelet kubeadm kubectl
  echo "[*] kubelet, kubeadm, kubectl installed and held."
}

# 4. Build & install cri‑dockerd from source (for Docker as CRI)
install_cri_dockerd() {
  echo "[*] Installing cri-dockerd runtime shim..."
  apt-get update -y
  apt-get install -y git make golang-go
  git clone https://github.com/Mirantis/cri-dockerd.git /tmp/cri-dockerd
  pushd /tmp/cri-dockerd >/dev/null
    make cri-dockerd
    install -o root -g root -m 0755 cri-dockerd /usr/local/bin/
    install -o root -g root -m 0644 packaging/systemd/cri-docker.service /etc/systemd/system/
    install -o root -g root -m 0644 packaging/systemd/cri-docker.socket  /etc/systemd/system/
    sed -i 's|/usr/bin/cri-dockerd|/usr/local/bin/cri-dockerd|' /etc/systemd/system/cri-docker.service
    systemctl daemon-reload
    systemctl enable --now cri-docker.service
  popd >/dev/null
  echo "[*] cri-dockerd installed and running."
}

main() {
  disable_swap
  install_docker
  install_k8s_tools
  install_cri_dockerd
  echo "[+] All prerequisites completed! Now, on the control‑plane node, run:\n    sudo kubeadm init --pod-network-cidr=${DOCKER_BASE_POOL}\n  Then follow the output to join worker nodes with \"kubeadm join ...\""
}

main "$@"
