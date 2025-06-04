#!/usr/bin/env bash
# -----------------------------------------------------------------------------
# setup-k8s.sh – Provision a Debian 12 (Bookworm) host for Kubernetes
# -----------------------------------------------------------------------------
# * Disables swap (required by kubelet)
# * Installs & configures Docker Engine + cri-dockerd runtime shim (pinned)
# * Installs kubeadm / kubelet / kubectl (specific version or latest minor)
# -----------------------------------------------------------------------------
# Tested on: Debian 12 (kernel 6.1+) with systemd 252; Go 1.19 (default repo)
# -----------------------------------------------------------------------------
set -euo pipefail

# ----------------------------- TUNABLES --------------------------------------
K8S_VERSION="1.28.0"                 # Desired Kubernetes version X.Y.Z
CRI_DOCKERD_VERSION="v0.3.1"        # Stable tag that builds under Go 1.19+
DOCKER_BASE_POOL="172.31.0.0/16"    # Docker address‑pool base
DOCKER_POOL_SIZE="24"               # Size of each docker subnet
DOCKER_BIP="172.7.0.1/16"           # Fixed bridge IP for docker0
# -----------------------------------------------------------------------------

# Helper – Kubernetes minor string (e.g. v1.28) for pkgs.k8s.io
K8S_MINOR="v$(echo "$K8S_VERSION" | awk -F. '{print $1"."$2}')"

# 1 ─ Disable swap (required by kubelet)
disable_swap() {
  echo "[*] Disabling swap…"
  sysctl -w vm.swappiness=0 > /dev/null
  swapoff -a || true
  grep -qE "\\sswap\\s" /etc/fstab && sed -i.bak '/ swap / s/^/#/' /etc/fstab || true
  echo "[*] Swap disabled."
}

# 2 ─ Install Docker Engine
install_docker() {
  echo "[*] Installing Docker Engine…"
  apt-get update -y
  apt-get install -y ca-certificates curl gnupg lsb-release

  install -d -m 0755 /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor --yes -o /etc/apt/keyrings/docker.gpg
  chmod a+r /etc/apt/keyrings/docker.gpg

  echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
    https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
    | tee /etc/apt/sources.list.d/docker.list >/dev/null

  apt-get update -y
  apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

  cat >/etc/docker/daemon.json <<EOF
{
  "log-driver": "json-file",
  "log-opts": {"tag": "{{.Name}}", "max-size": "2m", "max-file": "2"},
  "default-address-pools": [ {"base": "${DOCKER_BASE_POOL}", "size": ${DOCKER_POOL_SIZE}} ],
  "bip": "${DOCKER_BIP}"
}
EOF

  systemctl enable --now docker
  echo "[*] Docker installed."
}

# 3 ─ Install Kubernetes tools
install_k8s_tools() {
  echo "[*] Installing Kubernetes tools (target ${K8S_VERSION})…"
  apt-get update -y
  apt-get install -y apt-transport-https ca-certificates curl gpg

  install -d -m 0755 /etc/apt/keyrings

  # Try minor‑specific repo first; fallback to generic stable if inaccessible.
  for REPO_BASE in \
    "https://pkgs.k8s.io/core:/stable:/${K8S_MINOR}/deb/" \
    "https://pkgs.k8s.io/core:/stable:/deb/"; do
    if curl -fsSL "${REPO_BASE}Release.key" | gpg --dearmor --yes -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg; then
      echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] ${REPO_BASE} /" \
        | tee /etc/apt/sources.list.d/kubernetes.list >/dev/null
      echo "[*] Using Kubernetes repo: ${REPO_BASE}"
      break
    fi
  done

  apt-get update -y
  if ! apt-get install -y kubelet="${K8S_VERSION}-1.1" kubeadm="${K8S_VERSION}-1.1" kubectl="${K8S_VERSION}-1.1"; then
    echo "[!] Exact patch not found; installing repo default for ${K8S_MINOR}."
    apt-get install -y kubelet kubeadm kubectl
  fi
  apt-mark hold kubelet kubeadm kubectl
  echo "[*] kubelet/kubeadm/kubectl installed."
}

# 4 ─ Build & install cri-dockerd (handles Docker↔CRI)
install_cri_dockerd() {
  echo "[*] Installing cri-dockerd ${CRI_DOCKERD_VERSION}…"
  apt-get update -y
  apt-get install -y git make golang-go

  # Clean previous build dir if present to avoid git clone errors
  rm -rf /tmp/cri-dockerd

  git clone --depth 1 --branch "${CRI_DOCKERD_VERSION}" https://github.com/Mirantis/cri-dockerd.git /tmp/cri-dockerd
  pushd /tmp/cri-dockerd >/dev/null

    # Ensure go.mod directive matches installed Go toolchain (avoid version mismatch)
    GO_MAJ_MIN=$(go version | awk '{print $3}' | sed 's/go//;s/\.[0-9]*$//')
    sed -i -E "s/^go .*/go ${GO_MAJ_MIN}/" go.mod

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
  echo "[+] Setup finished! Initialise control‑plane with:\n    kubeadm init --pod-network-cidr=${DOCKER_BASE_POOL}\nThen run the join command on workers."
}

main "$@"
