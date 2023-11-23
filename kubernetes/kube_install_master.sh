hostnamectl set-hostname master
apt-get -y update
apt-get -y install apt-transport-https gnupg2
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list
apt-get -y update
apt-get -y install kubectl kubeadm kubelet kubernetes-cni docker.io
systemctl start docker
systemctl enable docker
newgrp docker
usermod -aG docker ansiuser
cat << EOF | tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sysctl --system