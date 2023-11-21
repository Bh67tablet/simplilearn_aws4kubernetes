sudo su
usermod -aG sudo labsuser
sudo usermod -aG sudo labsuser
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl docker
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get install     apt-transport-https     ca-certificates     curl     gnupg     lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo   "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker labsuser
whoami
docker
kubeadm
https://github.com/tsl0922/ttyd/releases/download/1.6.3/ttyd.x86_64
wget https://github.com/tsl0922/ttyd/releases/download/1.6.3/ttyd.x86_64
chmod +x ./ttyd.x86_64 
./ttyd.x86_64 --version
sudo ./ttyd.x86_64 /usr/local/bin/ttyd
sudo mv ./ttyd.x86_64 /usr/local/bin/ttyd
ttyd --version
ttyd
ttyd /bin/bash
/opt/scripts/voc_start_dcv_and_ttyd_and_monitor.sh
/opt/scripts/voc_start_ttyd.sh 
sudo vi /etc/dcv/dcv.conf 
sudo reboot
