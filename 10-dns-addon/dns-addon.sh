#!/bin/bash

#kube-dns.yaml downloaded from https://storage.googleapis.com/kubernetes-the-hard-way/kube-dns.yaml
kubectl create -f kube-dns.yaml
kubectl get pods -l k8s-app=kube-dns -n kube-system
