# Kubernets 安裝指南

> source : https://blog.jks.coffee/on-premise-self-host-kubernetes-k8s-setup-ubuntu/

## Install Script
```Bash
sudo apt upgrade && apt pudate
chmod +x setup-k8s-24.04.sh
sudo ./setup-k8s-24.04.sh
sudo kubeadm init --pod-network-cidr=172.31.0.0/16
```
