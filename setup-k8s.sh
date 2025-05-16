#!/usr/bin/env bash
set -euo pipefail

# 針對 Ubuntu 24.04 LTS (Noble Numbat)
# Variables (可依需求調整 K8S 版本與 Docker 網段)
K8S_VERSION="1.28.0"
DOCKER_BASE_POOL="172.31.0.0/16"
DOCKER_POOL_SIZE="24"
DOCKER_BIP="172.7.0.1/16"

# 1. 關閉並移除 swap
disable_swap() {
  echo "[*] Disabling swap..."
  sysctl -w vm.swappiness=0
  swapoff -a
  sed -i.bak '/ swap / s/^/#/' /etc/fstab
  echo "[*] Swap disabled."
}

# 2. 安裝並設定 Docker
install_docker() {
  echo "[*] Installing Docker..."
  apt update -y
  apt install -y ca-certificates curl gnupg lsb-release
  mkdir -p /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
    | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  chmod a+r /etc/apt/keyrings/docker.gpg
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
    https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" \
    | tee /etc/apt/sources.list.d/docker.list > /dev/null
  apt update -y
  apt install -y docker-ce docker-ce-cli containerd.io \
                 docker-buildx-plugin docker-compose-plugin

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

# 3. 安裝 kubelet / kubeadm / kubectl
install_k8s_tools() {
  echo "[*] Installing Kubernetes tools..."
  apt update -y
  apt install -y apt-transport-https ca-certificates curl
  curl -fsSL https://pkgs.k8s.io/core:/stable:/v${K8S_VERSION}/deb/Release.key \
    | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
  echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] \
    https://pkgs.k8s.io/core:/stable:/v${K8S_VERSION}/deb/ /" \
    | tee /etc/apt/sources.list.d/kubernetes.list > /dev/null
  apt update -y
  apt install -y kubelet kubeadm kubectl
  apt-mark hold kubelet kubeadm kubectl
  echo "[*] kubelet, kubeadm, kubectl installed (v${K8S_VERSION})."
}

# 4. 從原始碼編譯並安裝 cri-dockerd
install_cri_dockerd() {
  echo "[*] Installing cri-dockerd from source..."
  apt update -y
  apt install -y git make golang-go
  git clone https://github.com/Mirantis/cri-dockerd.git /tmp/cri-dockerd
  pushd /tmp/cri-dockerd > /dev/null
    make cri-dockerd
    install -o root -g root -m 0755 cri-dockerd /usr/local/bin/cri-dockerd
    install -o root -g root -m 0644 packaging/systemd/cri-docker.service /etc/systemd/system/
    install -o root -g root -m 0644 packaging/systemd/cri-docker.socket  /etc/systemd/system/
    sed -i 's|/usr/bin/cri-dockerd|/usr/local/bin/cri-dockerd|' /etc/systemd/system/cri-docker.service
    systemctl daemon-reload
    systemctl enable --now cri-docker.service
  popd > /dev/null
  echo "[*] cri-dockerd installed and running."
}

main() {
  disable_swap
  install_docker
  install_k8s_tools
  install_cri_dockerd
  echo "[+] 所有準備工作完成！接下來可在 Control Node 執行："
  echo "    sudo kubeadm init --pod-network-cidr=172.31.0.0/16"
  echo "並依輸出在 Worker Node 執行 kubeadm join ..."
}

main "$@"
