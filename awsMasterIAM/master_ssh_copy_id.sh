#for ip in $(cat /home/ansiuser/ips); do sshpass -p ansiuser ssh-copy-id -i $HOME/.ssh/id_rsa.pub ansiuser@$ip; done
for ip in $(cat /home/ansiuser/ips); do echo "ssh-copy-id -i $HOME/.ssh/id_rsa.pub ansiuser@$ip"; done
for ip in $(cat /home/ansiuser/ips); do echo "ssh -i $HOME/.ssh/id_rsa.pub ansiuser@$ip"; done
echo "run above commands"
echo "for ip in $(cat /home/ansiuser/ips); do ssh ansiuser@$ip ls -la $HOME/.ssh; done"
echo "for ip in $(cat /home/ansiuser/ips); do ssh ansiuser@$ip cat $HOME/.ssh/authorized_keys; done"
