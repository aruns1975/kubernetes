! /bin/bash

echo '[METALLB] Creating the name space for the metallb'
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.10.2/manifests/namespace.yaml

echo '[METALLB] Installating metallb'
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.10.2/manifests/metallb.yaml
