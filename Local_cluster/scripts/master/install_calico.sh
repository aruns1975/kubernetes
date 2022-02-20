! /bin/bash
#
# Install Calico Network Plugin

curl https://docs.projectcalico.org/manifests/calico.yaml -O

kubectl apply -f calico.yaml