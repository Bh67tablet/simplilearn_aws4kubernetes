kubectl delete -f https://raw.githubusercontent.com/projectcalico/calico/v3.24.1/manifests/calico.yaml
kubeadm reset --force
rm -rf /var/lib/kubelet /etc/kubernetes /var/lib/etcd $HOME/.kube
