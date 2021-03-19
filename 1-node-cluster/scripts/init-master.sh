#!/bin/bash

swapoff -a

systemctl stop docker
cat > /etc/docker/daemon.json <<EOF
{ "storage-driver": "overlay2" }
EOF
systemctl start docker
curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main"|tee /etc/apt/sources.list.d/kubernetes.list
apt -y install iputils-ping

