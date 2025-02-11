#!/bin/bash

echo "***************************************"
echo "**    Prerecquis                     **"
echo "**    Enable IPv4 packet forwarding  **"
echo "***************************************"
sudo modprobe overlay
sudo modprobe br_netfilter
sudo cp /tmp/k8s.conf /etc/sysctl.d/k8s.conf
sudo sysctl --system
sudo swapoff -a
sudo apt install -y socat

echo "***************************************"
echo "**    Prerecquis/container           **"
echo "**    Install docker                 **"
echo "***************************************"
# Mise à jour et installation des prérequis
sudo apt-get -y update
sudo apt-get -y install ca-certificates curl

# Ajout de la clé GPG officielle de Docker
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Ajout du dépôt Docker dans les sources de APT
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Installation de Docker
sudo apt-get -y update
sudo apt-get -y install docker-ce docker-ce-cli docker-buildx-plugin docker-compose-plugin

echo "***************************************"
echo "**    Prerecquis/container           **"
echo "**    Install cri-docker             **"
echo "***************************************"
sudo dpkg-reconfigure debconf -f noninteractive -p critical
wget https://github.com/Mirantis/cri-dockerd/releases/download/v0.3.16/cri-dockerd_0.3.16.3-0.debian-bookworm_amd64.deb
sudo dpkg -i cri-dockerd_0.3.16.3-0.debian-bookworm_amd64.deb

echo "***************************************"
echo "**    Production                     **"
echo "**    Install kubeadm                **"
echo "***************************************"
sudo apt-get install -y apt-transport-https ca-certificates curl gpg
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.32/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

# Installation de kubelet, kubeadm et kubectl
sudo apt-get -y update
sudo apt-get -y install kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

# Activer l'IPv4 packet forwarding
sudo sysctl -w net.ipv4.ip_forward=1

echo "**************************************"
echo "**   config node                    **"
echo "**************************************" 
sudo kubeadm config images pull --cri-socket unix:///var/run/cri-dockerd.sock
# Lire la première ligne du fichier tok.tok et la stocker dans une variable
commande=$(head -n 1 tok.tok)

# Exécuter la commande lue
echo "Exécution de la commande : $commande"
sudo $commande  --cri-socket unix:///var/run/cri-dockerd.sock
