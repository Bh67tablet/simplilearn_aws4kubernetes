#!/bin/bash
kubeadm config images pull
echo ‘{"exec-opts": ["native.cgroupdriver=systemd"]}’ | tee /etc/docker/daemon.json
systemctl daemon-reload
systemctl restart docker
systemctl restart kubelet
kubeadm init
mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config
kubectl apply -f https://github.com/coreos/flannel/raw/master/Documentation/kube-flannel.yml
kubectl get nodes
