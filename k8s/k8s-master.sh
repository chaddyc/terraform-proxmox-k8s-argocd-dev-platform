#! /bin/bash

#add firewall rules
# sudo ufw allow 179/tcp
# sudo ufw allow 4789/tcp
# sudo ufw allow 5473/tcp
# sudo ufw allow 443/tcp
# sudo ufw allow 4149/tcp
# sudo ufw allow 10256/tcp
# sudo ufw allow 9099/tcp
# sudo ufw allow 6443/tcp
# sudo ufw allow 2379/tcp
# sudo ufw allow 2380/tcp
# sudo ufw allow 10250/tcp
# sudo ufw allow 10251/tcp
# sudo ufw allow 10252/tcp
# sudo ufw allow 10255/tcp
# sudo ufw allow 80/tcp
# sudo ufw allow 22/tcp
# yes | sudo ufw enable
# sudo ufw reload 
sudo systemctl stop ufw
sudo systemctl disable ufw

#initialize
sudo kubeadm init --pod-network-cidr=$1
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

#install pod network - calico
kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v$2/manifests/calico.yaml

#export token to join worker nodes to k8s cluster - kube join command
echo "sudo" $(kubeadm token create  --print-join-command) >> /tmp/kube_join.txt