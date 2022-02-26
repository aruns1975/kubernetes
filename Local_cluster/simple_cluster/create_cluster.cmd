@echo off
vagrant up
copy .\configs\config ~\.kube
kubectl get nodes
