# Kubernets 安裝指南

> source : https://blog.jks.coffee/on-premise-self-host-kubernetes-k8s-setup-ubuntu/
> 
> 只安裝 SSH Server 就好，其他都先不要。
> 
> 然後選項裡面有個 docker 實測發現在後續的步驟會有一些問題，請不要偷懶勾上。

## Install Script
```Bash
sudo apt upgrade && apt pudate
chmod +x setup-k8s-24.04.sh
sudo ./setup-k8s-24.04.sh
sudo kubeadm init --pod-network-cidr=172.31.0.0/16
```
