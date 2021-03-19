#!/bin/bash

tmux


docker exec -it k8s-master /bin/bash
docker exec -it k8s-master /bin/bash
docker exec -it k8s-master /bin/bash
docker exec -it k8s-master /bin/bash


apt-get -y update && apt-get -y install wget
cd /tmp

wget https://dl.k8s.io/v1.20.5/kubernetes-client-linux-amd64.tar.gz
wget https://dl.k8s.io/v1.20.5/kubernetes-server-linux-amd64.tar.gz
wget https://github.com/etcd-io/etcd/releases/download/v3.4.15/etcd-v3.4.15-linux-amd64.tar

tar xzvf kubernetes-client-linux-amd64.tar.gz 
tar xzvf kubernetes-server-linux-amd64.tar.gz
tar xzvf /tmp/etcd-v3.4.15-linux-amd64.tar

cp /tmp/kubernetes/client/bin/kubectl /usr/local/bin/kubectl
cp /tmp/kubernetes/server/bin/kube-apiserver /usr/local/bin/kube-apiserver
cp /tmp/etcd-v3.4.15-linux-amd64/etcd /usr/local/bin/etcd
cp /tmp/etcd-v3.4.15-linux-amd64/etcdctl /usr/local/bin/etcdctl

kubectl create deployment web --image=nginx

kube-apiserver  --etcd-servers localhost
kube-apiserver  --etcd-servers localhost --help|grep service-account

apt-get -y install openssh-client

ssh-keygen
cp /root/.ssh/id_rsa /tmp/key.pem

etcd &

cd /tmp
openssl req -new -newkey rsa:2048 -days 365 -nodes -x509 -keyout /tmp/api-server.key -out /tmp/api-server.crt

# Service account token volume projection

kube-apiserver --etcd-servers http://localhost:2379 --service-cluster-ip-range=10.1.0.0/24 \
               --service-account-issuer local \
               --service-account-key-file=/tmp/key.pem \
               --service-account-signing-key-file=/tmp/key.pem -v=5

 lsof -p `pidof kube-apiserver`|grep "LISTEN"

kubectl -v=5 -s https://localhost:6443 create deployment test --image=nginx:latest
Please enter Username: sad
Please enter Password: error: failed to create deployment: 
Post "https://localhost:6443/apis/apps/v1/namespaces/default/deployments?fieldManager=kubectl-create": 
x509: certificate signed by unknown authority


kubectl -s localhost:

cd /tmp
openssl req \
-x509 \
-newkey rsa:4096 \
-sha256 \
-days 3560 \
-nodes \
-keyout kube-apiserver.key \
-out kube-apiserver.crt \
-subj '/CN=1-node-cluster' \
-extensions san \
-config <( \
  echo '[req]'; \
  echo 'distinguished_name=req'; \
  echo '[san]'; \
  echo 'subjectAltName=DNS:localhost')

openssl x509 -in /tmp/kube-apiserver.crt -text -noout

kube-apiserver --etcd-servers http://localhost:2379 --service-cluster-ip-range=10.1.0.0/24 \
               --service-account-issuer local \
               --service-account-key-file=/tmp/key.pem \
               --service-account-signing-key-file=/tmp/key.pem \
               --tls-cert-file=/tmp/kube-apiserver.crt  \
               --tls-private-key-file=/tmp/kube-apiserver.key \
               --v=5

apt-get -y install ca-certificates
cp /tmp/kube-apiserver.crt /usr/share/ca-certificates
dpkg-reconfigure ca-certificates

 curl -v -k https://localhost:6443

kubectl -v=5 -s https://localhost:6443 create deployment test --image=nginx:latest
# Login, Password

kube-apiserver --etcd-servers http://localhost:2379 --service-cluster-ip-range=10.1.0.0/24 \
               --service-account-issuer local \
               --service-account-key-file=/tmp/key.pem \
               --service-account-signing-key-file=/tmp/key.pem \
               --tls-cert-file=/tmp/kube-apiserver.crt  \
               --tls-private-key-file=/tmp/kube-apiserver.key \
               --enable-bootstrap-token-auth \
               --v=5
