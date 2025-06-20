
INFO: Setup Kubernetes Official Repository
Reading package lists...
Building dependency tree...
Reading state information...
apt-transport-https is already the newest version (2.6.1).
ca-certificates is already the newest version (20230311).
curl is already the newest version (7.88.1-10+deb12u4).
gpg is already the newest version (2.2.40-1.1).
0 upgraded, 0 newly installed, 0 to remove and 0 not upgraded.
deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main
Hit:1 http://deb.debian.org/debian bookworm InRelease
Get:2 http://deb.debian.org/debian bookworm-updates InRelease [52.1 kB]
Get:3 http://security.debian.org/debian-security bookworm-security InRelease [48.0 kB]
Get:5 http://security.debian.org/debian-security bookworm-security/main amd64 Packages [88.9 kB]
Get:6 http://security.debian.org/debian-security bookworm-security/main Translation-en [50.8 kB]
Get:4 https://packages.cloud.google.com/apt kubernetes-xenial InRelease [8,993 B]
Get:7 https://packages.cloud.google.com/apt kubernetes-xenial/main amd64 Packages [69.9 kB]
Fetched 319 kB in 1s (573 kB/s)
Reading package lists...
1) Kubernetes-1.24
2) Kubernetes-1.25
3) Kubernetes-1.26
4) Kubernetes-1.27
5) Kubernetes-1.28 (latest) (requested version)
Install (5):5

INFO: Installing kubernetes 1.28.2-00

INFO: Need to replace kubernetes packages
kubelet was already not on hold.
kubeadm was already not on hold.
kubectl was already not on hold.

WARNING: apt does not have a stable CLI interface. Use with caution in scripts.

Reading package lists...
Building dependency tree...
Reading state information...
Package 'kubelet' is not installed, so not removed
Package 'kubeadm' is not installed, so not removed
Package 'kubectl' is not installed, so not removed
0 upgraded, 0 newly installed, 0 to remove and 2 not upgraded.

WARNING: apt does not have a stable CLI interface. Use with caution in scripts.

Reading package lists...
Building dependency tree...
Reading state information...
The following additional packages will be installed:
  conntrack cri-tools ebtables iptables kubernetes-cni libip6tc2
  libnetfilter-conntrack3 libnfnetlink0 socat
Suggested packages:
  firewalld
The following NEW packages will be installed:
  conntrack cri-tools ebtables iptables kubeadm kubectl kubelet kubernetes-cni
  libip6tc2 libnetfilter-conntrack3 libnfnetlink0 socat
0 upgraded, 12 newly installed, 0 to remove and 2 not upgraded.
Need to get 87.6 MB of archives.
After this operation, 339 MB of additional disk space will be used.
Get:1 http://deb.debian.org/debian bookworm/main amd64 libnfnetlink0 amd64 1.0.2-2 [15.1 kB]
Get:2 http://deb.debian.org/debian bookworm/main amd64 libnetfilter-conntrack3 amd64 1.0.9-3 [40.7 kB]
Get:3 http://deb.debian.org/debian bookworm/main amd64 conntrack amd64 1:1.4.7-1+b2 [35.2 kB]
Get:4 http://deb.debian.org/debian bookworm/main amd64 ebtables amd64 2.0.11-5 [86.5 kB]
Get:5 http://deb.debian.org/debian bookworm/main amd64 libip6tc2 amd64 1.8.9-2 [19.4 kB]
Get:6 http://deb.debian.org/debian bookworm/main amd64 iptables amd64 1.8.9-2 [360 kB]
Get:7 http://deb.debian.org/debian bookworm/main amd64 socat amd64 1.7.4.4-2 [375 kB]
Get:8 https://packages.cloud.google.com/apt kubernetes-xenial/main amd64 cri-tools amd64 1.26.0-00 [18.9 MB]
Get:9 https://packages.cloud.google.com/apt kubernetes-xenial/main amd64 kubernetes-cni amd64 1.2.0-00 [27.6 MB]
Get:10 https://packages.cloud.google.com/apt kubernetes-xenial/main amd64 kubelet amd64 1.28.2-00 [19.5 MB]
Get:11 https://packages.cloud.google.com/apt kubernetes-xenial/main amd64 kubectl amd64 1.28.2-00 [10.3 MB]
Get:12 https://packages.cloud.google.com/apt kubernetes-xenial/main amd64 kubeadm amd64 1.28.2-00 [10.3 MB]
Fetched 87.6 MB in 4s (21.2 MB/s)
Selecting previously unselected package libnfnetlink0:amd64.
(Reading database ... 
(Reading database ... 5%
(Reading database ... 10%
(Reading database ... 15%
(Reading database ... 20%
(Reading database ... 25%
(Reading database ... 30%
(Reading database ... 35%
(Reading database ... 40%
(Reading database ... 45%
(Reading database ... 50%
(Reading database ... 55%
(Reading database ... 60%
(Reading database ... 65%
(Reading database ... 70%
(Reading database ... 75%
(Reading database ... 80%
(Reading database ... 85%
(Reading database ... 90%
(Reading database ... 95%
(Reading database ... 100%
(Reading database ... 29396 files and directories currently installed.)
Preparing to unpack .../00-libnfnetlink0_1.0.2-2_amd64.deb ...
Unpacking libnfnetlink0:amd64 (1.0.2-2) ...
Selecting previously unselected package libnetfilter-conntrack3:amd64.
Preparing to unpack .../01-libnetfilter-conntrack3_1.0.9-3_amd64.deb ...
Unpacking libnetfilter-conntrack3:amd64 (1.0.9-3) ...
Selecting previously unselected package conntrack.
Preparing to unpack .../02-conntrack_1%3a1.4.7-1+b2_amd64.deb ...
Unpacking conntrack (1:1.4.7-1+b2) ...
Selecting previously unselected package cri-tools.
Preparing to unpack .../03-cri-tools_1.26.0-00_amd64.deb ...
Unpacking cri-tools (1.26.0-00) ...
Selecting previously unselected package ebtables.
Preparing to unpack .../04-ebtables_2.0.11-5_amd64.deb ...
Unpacking ebtables (2.0.11-5) ...
Selecting previously unselected package libip6tc2:amd64.
Preparing to unpack .../05-libip6tc2_1.8.9-2_amd64.deb ...
Unpacking libip6tc2:amd64 (1.8.9-2) ...
Selecting previously unselected package iptables.
Preparing to unpack .../06-iptables_1.8.9-2_amd64.deb ...
Unpacking iptables (1.8.9-2) ...
Selecting previously unselected package kubernetes-cni.
Preparing to unpack .../07-kubernetes-cni_1.2.0-00_amd64.deb ...
Unpacking kubernetes-cni (1.2.0-00) ...
Selecting previously unselected package socat.
Preparing to unpack .../08-socat_1.7.4.4-2_amd64.deb ...
Unpacking socat (1.7.4.4-2) ...
Selecting previously unselected package kubelet.
Preparing to unpack .../09-kubelet_1.28.2-00_amd64.deb ...
Unpacking kubelet (1.28.2-00) ...
Selecting previously unselected package kubectl.
Preparing to unpack .../10-kubectl_1.28.2-00_amd64.deb ...
Unpacking kubectl (1.28.2-00) ...
Selecting previously unselected package kubeadm.
Preparing to unpack .../11-kubeadm_1.28.2-00_amd64.deb ...
Unpacking kubeadm (1.28.2-00) ...
Setting up libip6tc2:amd64 (1.8.9-2) ...
Setting up kubectl (1.28.2-00) ...
Setting up ebtables (2.0.11-5) ...
update-alternatives: using /usr/sbin/ebtables-legacy to provide /usr/sbin/ebtables (ebtables) in auto mode
Setting up socat (1.7.4.4-2) ...
Setting up libnfnetlink0:amd64 (1.0.2-2) ...
Setting up cri-tools (1.26.0-00) ...
Setting up kubernetes-cni (1.2.0-00) ...
Setting up libnetfilter-conntrack3:amd64 (1.0.9-3) ...
Setting up iptables (1.8.9-2) ...
update-alternatives: using /usr/sbin/iptables-legacy to provide /usr/sbin/iptables (iptables) in auto mode
update-alternatives: using /usr/sbin/ip6tables-legacy to provide /usr/sbin/ip6tables (ip6tables) in auto mode
update-alternatives: using /usr/sbin/iptables-nft to provide /usr/sbin/iptables (iptables) in auto mode
update-alternatives: using /usr/sbin/ip6tables-nft to provide /usr/sbin/ip6tables (ip6tables) in auto mode
update-alternatives: using /usr/sbin/arptables-nft to provide /usr/sbin/arptables (arptables) in auto mode
update-alternatives: using /usr/sbin/ebtables-nft to provide /usr/sbin/ebtables (ebtables) in auto mode
Setting up conntrack (1:1.4.7-1+b2) ...
Setting up kubelet (1.28.2-00) ...
Created symlink /etc/systemd/system/multi-user.target.wants/kubelet.service → /lib/systemd/system/kubelet.service.
Setting up kubeadm (1.28.2-00) ...
Processing triggers for man-db (2.11.2-2) ...
Processing triggers for libc-bin (2.36-9+deb12u3) ...
kubelet set on hold.
kubeadm set on hold.
kubectl set on hold.

INFO: Linking Kubernetes-cni to Containerd
'/var/lib/containerd/opt/bin/bandwidth' -> '/opt/cni/bin/bandwidth'
'/var/lib/containerd/opt/bin/bridge' -> '/opt/cni/bin/bridge'
'/var/lib/containerd/opt/bin/dhcp' -> '/opt/cni/bin/dhcp'
'/var/lib/containerd/opt/bin/dummy' -> '/opt/cni/bin/dummy'
'/var/lib/containerd/opt/bin/firewall' -> '/opt/cni/bin/firewall'
'/var/lib/containerd/opt/bin/host-device' -> '/opt/cni/bin/host-device'
'/var/lib/containerd/opt/bin/host-local' -> '/opt/cni/bin/host-local'
'/var/lib/containerd/opt/bin/ipvlan' -> '/opt/cni/bin/ipvlan'
'/var/lib/containerd/opt/bin/loopback' -> '/opt/cni/bin/loopback'
'/var/lib/containerd/opt/bin/macvlan' -> '/opt/cni/bin/macvlan'
'/var/lib/containerd/opt/bin/portmap' -> '/opt/cni/bin/portmap'
'/var/lib/containerd/opt/bin/ptp' -> '/opt/cni/bin/ptp'
'/var/lib/containerd/opt/bin/sbr' -> '/opt/cni/bin/sbr'
'/var/lib/containerd/opt/bin/static' -> '/opt/cni/bin/static'
'/var/lib/containerd/opt/bin/tuning' -> '/opt/cni/bin/tuning'
'/var/lib/containerd/opt/bin/vlan' -> '/opt/cni/bin/vlan'
'/var/lib/containerd/opt/bin/vrf' -> '/opt/cni/bin/vrf'

INFO: Checking Kubernetes prerequisites for CPUs

INFO: Found 2 CPUs

INFO: Checking Kubernetes prerequisites for Memory

INFO: Found 2013552 KB of Memory

INFO: Setup Kubernetes prerequisites for Swap

INFO: Disabling swap
Created symlink /etc/systemd/system/dev-disk-by\x2duuid-67483b33\x2de413\x2d4f28\x2dbf7b\x2ded7b8edce17c.swap → /dev/null.
Unit loaded.service does not exist, proceeding anyway.
Created symlink /etc/systemd/system/loaded.service → /dev/null.
Unit inactive.service does not exist, proceeding anyway.
Created symlink /etc/systemd/system/inactive.service → /dev/null.
Unit dead.service does not exist, proceeding anyway.
Created symlink /etc/systemd/system/dead.service → /dev/null.
Failed to get properties: Unit name /dev/disk/by-uuid/67483b33-e413-4f28-bf7b-ed7b8edce17c is neither a valid invocation ID nor unit name.

INFO: Swap devices need to be masked with systemctl
  UNIT          LOAD   ACTIVE   SUB  DESCRIPTION
  dev-sda3.swap loaded inactive dead Swap Partition

LOAD   = Reflects whether the unit definition was properly loaded.
ACTIVE = The high-level unit activation state, i.e. generalization of SUB.
SUB    = The low-level unit activation state, values depend on unit type.
1 loaded units listed.
To show all installed unit files use 'systemctl list-unit-files'.

INFO: Checking CRI (Container Runtime Interface) for Kubernetes

INFO: Installing Containerd
Reading package lists...
Building dependency tree...
Reading state information...
The following additional packages will be installed:
  criu libnet1 libnl-3-200 libprotobuf32 python3-protobuf runc sgml-base
Suggested packages:
  containernetworking-plugins sgml-base-doc
The following NEW packages will be installed:
  containerd criu libnet1 libnl-3-200 libprotobuf32 python3-protobuf runc
  sgml-base
0 upgraded, 8 newly installed, 0 to remove and 2 not upgraded.
Need to get 30.6 MB of archives.
After this operation, 117 MB of additional disk space will be used.
Get:1 http://deb.debian.org/debian bookworm/main amd64 sgml-base all 1.31 [15.4 kB]
Get:2 http://deb.debian.org/debian bookworm/main amd64 runc amd64 1.1.5+ds1-1+b1 [2,708 kB]
Get:3 http://deb.debian.org/debian bookworm/main amd64 containerd amd64 1.6.20~ds1-1+b1 [25.9 MB]
Get:4 http://deb.debian.org/debian bookworm/main amd64 libprotobuf32 amd64 3.21.12-3 [932 kB]
Get:5 http://deb.debian.org/debian bookworm/main amd64 python3-protobuf amd64 3.21.12-3 [245 kB]
Get:6 http://deb.debian.org/debian bookworm/main amd64 libnet1 amd64 1.1.6+dfsg-3.2 [60.3 kB]
Get:7 http://deb.debian.org/debian bookworm/main amd64 libnl-3-200 amd64 3.7.0-0.2+b1 [63.1 kB]
Get:8 http://deb.debian.org/debian bookworm/main amd64 criu amd64 3.17.1-2 [665 kB]
Fetched 30.6 MB in 0s (130 MB/s)
Selecting previously unselected package sgml-base.
(Reading database ... 
(Reading database ... 5%
(Reading database ... 10%
(Reading database ... 15%
(Reading database ... 20%
(Reading database ... 25%
(Reading database ... 30%
(Reading database ... 35%
(Reading database ... 40%
(Reading database ... 45%
(Reading database ... 50%
(Reading database ... 55%
(Reading database ... 60%
(Reading database ... 65%
(Reading database ... 70%
(Reading database ... 75%
(Reading database ... 80%
(Reading database ... 85%
(Reading database ... 90%
(Reading database ... 95%
(Reading database ... 100%
(Reading database ... 29709 files and directories currently installed.)
Preparing to unpack .../0-sgml-base_1.31_all.deb ...
Unpacking sgml-base (1.31) ...
Selecting previously unselected package runc.
Preparing to unpack .../1-runc_1.1.5+ds1-1+b1_amd64.deb ...
Unpacking runc (1.1.5+ds1-1+b1) ...
Selecting previously unselected package containerd.
Preparing to unpack .../2-containerd_1.6.20~ds1-1+b1_amd64.deb ...
Unpacking containerd (1.6.20~ds1-1+b1) ...
Selecting previously unselected package libprotobuf32:amd64.
Preparing to unpack .../3-libprotobuf32_3.21.12-3_amd64.deb ...
Unpacking libprotobuf32:amd64 (3.21.12-3) ...
Selecting previously unselected package python3-protobuf.
Preparing to unpack .../4-python3-protobuf_3.21.12-3_amd64.deb ...
Unpacking python3-protobuf (3.21.12-3) ...
Selecting previously unselected package libnet1:amd64.
Preparing to unpack .../5-libnet1_1.1.6+dfsg-3.2_amd64.deb ...
Unpacking libnet1:amd64 (1.1.6+dfsg-3.2) ...
Selecting previously unselected package libnl-3-200:amd64.
Preparing to unpack .../6-libnl-3-200_3.7.0-0.2+b1_amd64.deb ...
Unpacking libnl-3-200:amd64 (3.7.0-0.2+b1) ...
Selecting previously unselected package criu.
Preparing to unpack .../7-criu_3.17.1-2_amd64.deb ...
Unpacking criu (3.17.1-2) ...
Setting up runc (1.1.5+ds1-1+b1) ...
Setting up libprotobuf32:amd64 (3.21.12-3) ...
Setting up libnl-3-200:amd64 (3.7.0-0.2+b1) ...
Setting up sgml-base (1.31) ...
Setting up python3-protobuf (3.21.12-3) ...
Setting up containerd (1.6.20~ds1-1+b1) ...
Created symlink /etc/systemd/system/multi-user.target.wants/containerd.service → /lib/systemd/system/containerd.service.
Setting up libnet1:amd64 (1.1.6+dfsg-3.2) ...
Setting up criu (3.17.1-2) ...
Processing triggers for man-db (2.11.2-2) ...
Processing triggers for libc-bin (2.36-9+deb12u3) ...
containerd set on hold.

INFO: Save debian config file. /etc/containerd/config.toml

INFO: Containerd config - Load default configuration attributes

INFO: Containerd config - Don't comply with Debian, bin_dir = "/usr/lib/cni" because CNI are going to the default /opt/cni/bin 

INFO: Containerd config - Comply Debian, io.containerd.internal.v1.opt : path = /var/lib/containerd/opt

INFO: Containerd config - Enable Systemd cgroup driver

INFO: You can use contaired as CRI (Container Runtime Interface) for Kubernetes

INFO: Set runtine endpoint of crictl to containerd socket

INFO: Container Runtimes Prerequisites

INFO: Enable Forwarding IPv4 and letting iptables see bridged traffic

INFO: Load kernel modules
overlay
br_netfilter
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1

INFO: Apply kernel settings
net.bridge.bridge-nf-call-iptables 	: Enabled
net.bridge.bridge-nf-call-ip6tables 	: Enabled
net.ipv4.ip_forward 	: Enabled

INFO: Installing Heml
deb [arch=amd64 signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main
Hit:1 http://security.debian.org/debian-security bookworm-security InRelease
Hit:2 http://deb.debian.org/debian bookworm InRelease
Hit:3 http://deb.debian.org/debian bookworm-updates InRelease
Get:4 https://baltocdn.com/helm/stable/debian all InRelease [7,652 B]
Get:5 https://packages.cloud.google.com/apt kubernetes-xenial InRelease [8,993 B]
Get:6 https://baltocdn.com/helm/stable/debian all/main amd64 Packages [3,784 B]
Fetched 20.4 kB in 0s (47.6 kB/s)
Reading package lists...
Reading package lists...
Building dependency tree...
Reading state information...
The following NEW packages will be installed:
  helm
0 upgraded, 1 newly installed, 0 to remove and 2 not upgraded.
Need to get 16.2 MB of archives.
After this operation, 51.2 MB of additional disk space will be used.
Get:1 https://baltocdn.com/helm/stable/debian all/main amd64 helm amd64 3.13.1-1 [16.2 MB]
Fetched 16.2 MB in 0s (74.3 MB/s)
Selecting previously unselected package helm.
(Reading database ... 
(Reading database ... 5%
(Reading database ... 10%
(Reading database ... 15%
(Reading database ... 20%
(Reading database ... 25%
(Reading database ... 30%
(Reading database ... 35%
(Reading database ... 40%
(Reading database ... 45%
(Reading database ... 50%
(Reading database ... 55%
(Reading database ... 60%
(Reading database ... 65%
(Reading database ... 70%
(Reading database ... 75%
(Reading database ... 80%
(Reading database ... 85%
(Reading database ... 90%
(Reading database ... 95%
(Reading database ... 100%
(Reading database ... 30055 files and directories currently installed.)
Preparing to unpack .../helm_3.13.1-1_amd64.deb ...
Unpacking helm (3.13.1-1) ...
Setting up helm (3.13.1-1) ...
Processing triggers for man-db (2.11.2-2) ...

INFO: Heml - Adding some repository
"prometheus-community" has been added to your repositories
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "prometheus-community" chart repository
Update Complete. ⎈Happy Helming!⎈

INFO: Helm - You can find other repo here:  https://artifacthub.io

INFO: Installed Kubernetes packages
Desired=Unknown/Install/Remove/Purge/Hold
| Status=Not/Inst/Conf-files/Unpacked/halF-conf/Half-inst/trig-aWait/Trig-pend
|/ Err?=(none)/Reinst-required (Status,Err: uppercase=bad)
||/ Name           Version      Architecture Description
+++-==============-============-============-=====================================
hi  kubeadm        1.28.2-00    amd64        Kubernetes Cluster Bootstrapping Tool
hi  kubectl        1.28.2-00    amd64        Kubernetes Command Line Tool
hi  kubelet        1.28.2-00    amd64        Kubernetes Node Agent

INFO: To be able to run 'kubectl' as root, we add this in /root/.profile  'export KUBECONFIG=/etc/kubernetes/admin.conf'

INFO: You are ready to go with : kubeadm
INFO: Initializing Kubernetes cluster..
[init] Using Kubernetes version: v1.28.3
[preflight] Running pre-flight checks
[preflight] Pulling images required for setting up a Kubernetes cluster
[preflight] This might take a minute or two, depending on the speed of your internet connection
[preflight] You can also perform this action in beforehand using 'kubeadm config images pull'
[certs] Using certificateDir folder "/etc/kubernetes/pki"
[certs] Generating "ca" certificate and key
[certs] Generating "apiserver" certificate and key
[certs] apiserver serving cert is signed for DNS names [control-01 kubernetes kubernetes.default kubernetes.default.svc kubernetes.default.svc.cluster.local] and IPs [10.96.0.1 192.168.10.11]
[certs] Generating "apiserver-kubelet-client" certificate and key
[certs] Generating "front-proxy-ca" certificate and key
[certs] Generating "front-proxy-client" certificate and key
[certs] Generating "etcd/ca" certificate and key
[certs] Generating "etcd/server" certificate and key
[certs] etcd/server serving cert is signed for DNS names [control-01 localhost] and IPs [192.168.10.11 127.0.0.1 ::1]
[certs] Generating "etcd/peer" certificate and key
[certs] etcd/peer serving cert is signed for DNS names [control-01 localhost] and IPs [192.168.10.11 127.0.0.1 ::1]
[certs] Generating "etcd/healthcheck-client" certificate and key
[certs] Generating "apiserver-etcd-client" certificate and key
[certs] Generating "sa" key and public key
[kubeconfig] Using kubeconfig folder "/etc/kubernetes"
[kubeconfig] Writing "admin.conf" kubeconfig file
[kubeconfig] Writing "kubelet.conf" kubeconfig file
[kubeconfig] Writing "controller-manager.conf" kubeconfig file
[kubeconfig] Writing "scheduler.conf" kubeconfig file
[etcd] Creating static Pod manifest for local etcd in "/etc/kubernetes/manifests"
[control-plane] Using manifest folder "/etc/kubernetes/manifests"
[control-plane] Creating static Pod manifest for "kube-apiserver"
[control-plane] Creating static Pod manifest for "kube-controller-manager"
[control-plane] Creating static Pod manifest for "kube-scheduler"
[kubelet-start] Writing kubelet environment file with flags to file "/var/lib/kubelet/kubeadm-flags.env"
[kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
[kubelet-start] Starting the kubelet
[wait-control-plane] Waiting for the kubelet to boot up the control plane as static Pods from directory "/etc/kubernetes/manifests". This can take up to 4m0s
[apiclient] All control plane components are healthy after 8.502489 seconds
[upload-config] Storing the configuration used in ConfigMap "kubeadm-config" in the "kube-system" Namespace
[kubelet] Creating a ConfigMap "kubelet-config" in namespace kube-system with the configuration for the kubelets in the cluster
[upload-certs] Skipping phase. Please see --upload-certs
[mark-control-plane] Marking the node control-01 as control-plane by adding the labels: [node-role.kubernetes.io/control-plane node.kubernetes.io/exclude-from-external-load-balancers]
[mark-control-plane] Marking the node control-01 as control-plane by adding the taints [node-role.kubernetes.io/control-plane:NoSchedule]
[bootstrap-token] Using token: 9z443d.syeuzddbr8sjen5a
[bootstrap-token] Configuring bootstrap tokens, cluster-info ConfigMap, RBAC Roles
[bootstrap-token] Configured RBAC rules to allow Node Bootstrap tokens to get nodes
[bootstrap-token] Configured RBAC rules to allow Node Bootstrap tokens to post CSRs in order for nodes to get long term certificate credentials
[bootstrap-token] Configured RBAC rules to allow the csrapprover controller automatically approve CSRs from a Node Bootstrap Token
[bootstrap-token] Configured RBAC rules to allow certificate rotation for all node client certificates in the cluster
[bootstrap-token] Creating the "cluster-info" ConfigMap in the "kube-public" namespace
[kubelet-finalize] Updating "/etc/kubernetes/kubelet.conf" to point to a rotatable kubelet client certificate and key
[addons] Applied essential addon: CoreDNS
[addons] Applied essential addon: kube-proxy

Your Kubernetes control-plane has initialized successfully!

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

Alternatively, if you are the root user, you can run:

  export KUBECONFIG=/etc/kubernetes/admin.conf

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join 192.168.10.11:6443 --token 9z443d.syeuzddbr8sjen5a \
	--discovery-token-ca-cert-hash sha256:84c23a53d8c3d6e22ac18a46db6ca5d714f76a051fb03467f6ed9c4c9a2e5fc3 

INFO: Installing CNI - Calico
poddisruptionbudget.policy/calico-kube-controllers created
serviceaccount/calico-kube-controllers created
serviceaccount/calico-node created
serviceaccount/calico-cni-plugin created
configmap/calico-config created
customresourcedefinition.apiextensions.k8s.io/bgpconfigurations.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/bgpfilters.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/bgppeers.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/blockaffinities.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/caliconodestatuses.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/clusterinformations.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/felixconfigurations.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/globalnetworkpolicies.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/globalnetworksets.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/hostendpoints.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/ipamblocks.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/ipamconfigs.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/ipamhandles.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/ippools.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/ipreservations.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/kubecontrollersconfigurations.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/networkpolicies.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/networksets.crd.projectcalico.org created
clusterrole.rbac.authorization.k8s.io/calico-kube-controllers created
clusterrole.rbac.authorization.k8s.io/calico-node created
clusterrole.rbac.authorization.k8s.io/calico-cni-plugin created
clusterrolebinding.rbac.authorization.k8s.io/calico-kube-controllers created
clusterrolebinding.rbac.authorization.k8s.io/calico-node created
clusterrolebinding.rbac.authorization.k8s.io/calico-cni-plugin created
daemonset.apps/calico-node created
deployment.apps/calico-kube-controllers created

WARNING: To start using your cluster as  <root>          You to need to re-connect or run:  export KUBECONFIG=/etc/kubernetes/admin.conf

   To start using your cluster, please scroll-up (Ctrl+Shit Arrow-up) to see what to do.

   Notice: For root user we have already added the export in /root/.profile

   To join other nodes in the cluster you must install the same version of kubernetes.
   To do that you can run this on them :
      1. bash install_kubernetes.sh --cni calico 1.28
      2. kubeadm --join <args>
      Please scroll-up (Ctrl+Shit Arrow-up) to see args to use.

   Have good time with Kubernetes.
