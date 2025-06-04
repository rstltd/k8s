#!/usr/bin/env bash
# -----------------------------------------------------------------------------
# setup-k8s.sh – One‑shot Kubernetes bootstrap for **Debian 12 (Bookworm)**
# -----------------------------------------------------------------------------
# * Disables swap (kubelet requirement)
# * Installs & configures Docker Engine
# * Installs kubelet / kubeadm / kubectl (specified version)
# * Installs cri‑dockerd from **pre‑built release tarball** (no Go toolchain)
# * NEW: waits gracefully for any existing apt/dpkg operations to finish
# -----------------------------------------------------------------------------
set -euo pipefail

# ────────────── TUNABLES ─────────────────────────────────────────────────────
K8S_VERSION="1.28.0"                 # Kubernetes version X.Y.Z you want
CRI_DOCKERD_VERSION="v0.3.1"        # Tested, stable tag that works w/ Docker 24+
DOCKER_BASE_POOL="172.31.0.0/16"    # Base for Docker address‑pools
DOCKER_POOL_SIZE="24"               # Each subnet size within the pool
DOCKER_BIP="172.7.0.1/16"           # Fixed bridge IP for docker0
APT_LOCK_TIMEOUT=180                 # Seconds to wait for dpkg lock (3 min)
# ──────────────────────────────────────────────────────────────────────────────

K8S_MINOR="v$(echo "$K8S_VERSION" | awk -F. '{print $1"."$2}')"  # e.g. v1.28

# Determine CPU architecture mapping for cri‑dockerd tarball names
case "$(uname -m)" in
  x86_64) CRI_ARCH="amd64" ;;
  aarch64|arm64) CRI_ARCH="arm64" ;;
  armv7l|armhf)  CRI_ARCH="arm"   ;;
  *) echo "Unsupported architecture $(uname -m) for cri-dockerd"; exit 1 ;;
esac

#───────────────────────────────────────────────────────────────────────────────
# Utility: wait until dpkg/apt locks are free, up to APT_LOCK_TIMEOUT seconds
#───────────────────────────────────────────────────────────────────────────────
wait_for_dpkg_lock() {
  local start=$(date +%s)
  while fuser /var/lib/dpkg/lock >/dev/null 2>&1 \
        || fuser /var/lib/dpkg/lock-frontend >/dev/null 2>&1 \
        || fuser /var/lib/apt/lists/lock >/dev/null 2>&1 \
        || fuser /var/cache/apt/archives/lock >/dev/null 2>&1; do
    local now=$(date +%s)
    if (( now - start > APT_LOCK_TIMEOUT )); then
      echo "[✗] Timeout waiting for dpkg lock (>${APT_LOCK_TIMEOUT}s). Exiting." >&2
      exit 1
    fi
    echo "[!] Another apt/dpkg process is running – waiting…" >&2
    sleep 5
  done
}

# Wrap apt‑get to always wait for the lock first
apt_safe() {
  wait_for_dpkg_lock
  DEBIAN_FRONTEND=noninteractive apt-get "$@"
}

#───────────────────────────────────────────────────────────────────────────────
# 1 ─ Disable swap                                                            
#───────────────────────────────────────────────────────────────────────────────
disable_swap() {
  echo "[*] Disabling swap…"
  sysctl -w vm.swappiness=0 > /dev/null
  swapoff -a || true
  grep -qE "\\sswap\\s" /etc/fstab && sed -i.bak '/ swap / s/^/#/' /etc/fstab || true
  echo "[*] Swap disabled."
}

#───────────────────────────────────────────────────────────────────────────────
# 2 ─ Install Docker Engine                                                   
#───────────────────────────────────────────────────────────────────────────────
install_docker() {
  echo "[*] Installing Docker Engine…"
  apt_safe update -y
  apt_safe install -y ca-certificates curl gnupg lsb-release

  install -d -m 0755 /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor --yes -o /etc/apt/keyrings/docker.gpg
  chmod a+r /etc/apt/keyrings/docker.gpg

  echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
    https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
    | tee /etc/apt/sources.list.d/docker.list >/dev/null

  apt_safe update -y
  apt_safe install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

  cat >/etc/docker/daemon.json <<EOF
{
  "log-driver": "json-file",
  "log-opts": {"tag": "{{.Name}}", "max-size": "2m", "max-file": "2"},
  "default-address-pools": [ {"base": "${DOCKER_BASE_POOL}", "size": ${DOCKER_POOL_SIZE}} ],
  "bip": "${DOCKER_BIP}"
}
EOF

  systemctl enable --now docker
  echo "[*] Docker installed and configured."
}

#───────────────────────────────────────────────────────────────────────────────
# 3 ─ Install kubelet / kubeadm / kubectl                                     
#───────────────────────────────────────────────────────────────────────────────
install_k8s_tools() {
  echo "[*] Installing Kubernetes tools (target ${K8S_VERSION})…"
  apt_safe update -y
  apt_safe install -y apt-transport-https ca-certificates curl gpg

  install -d -m 0755 /etc/apt/keyrings

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

  apt_safe update -y
  if ! apt_safe install -y kubelet="${K8S_VERSION}-1.1" kubeadm="${K8S_VERSION}-1.1" kubectl="${K8S_VERSION}-1.1"; then
    echo "[!] Exact patch not found; installing repo default for ${K8S_MINOR}."
    apt_safe install -y kubelet kubeadm kubectl
  fi
  apt-mark hold kubelet kubeadm kubectl
  echo "[*] kubelet, kubeadm, kubectl installed."
}

#───────────────────────────────────────────────────────────────────────────────
# 4 ─ Install cri‑dockerd from pre‑built tarball                              
#───────────────────────────────────────────────────────────────────────────────
install_cri_dockerd() {
  echo "[*] Installing cri-dockerd ${CRI_DOCKERD_VERSION} (${CRI_ARCH}) …"

  TMP_DIR=$(mktemp -d)
  TAR_NAME="cri-dockerd-${CRI_DOCKERD_VERSION#v}.${CRI_ARCH}.tgz"
  DOWNLOAD_URL="https://github.com/Mirantis/cri-dockerd/releases/download/${CRI_DOCKERD_VERSION}/${TAR_NAME}"

  curl -L "${DOWNLOAD_URL}" -o "${TMP_DIR}/${TAR_NAME}"
  tar -xzf "${TMP_DIR}/${TAR_NAME}" -C "${TMP_DIR}"
  install -o root -g root -m 0755 "${TMP_DIR}/cri-dockerd" /usr/local/bin/

  for UNIT in cri-docker.service cri-docker.socket; do
    curl -fsSL -o "/etc/systemd/system/${UNIT}" \
      "https://raw.githubusercontent.com/Mirantis/cri-dockerd/${CRI_DOCKERD_VERSION}/packaging/systemd/${UNIT}"
  done
  sed -i 's|/usr/bin/cri-dockerd|/usr/local/bin/cri-dockerd|' /etc/systemd/system/cri-docker.service

  systemctl daemon-reload
  systemctl enable --now cri-docker.service

  systemctl is-active --quiet cri-docker.service && echo "[*] cri-dockerd active." \
    || { echo "[✗] cri-dockerd failed to start"; exit 1; }
}

#───────────────────────────────────────────────────────────────────────────────
main() {
  disable_swap
  install_docker
  install_k8s_tools
  install_cri_dockerd
  echo -e "\n[+] All set! Initialise control‑plane with:\n   sudo kubeadm init --pod-network-cidr=${DOCKER_BASE_POOL}\nThen run the generated join command on worker nodes."
}

main "$@"
