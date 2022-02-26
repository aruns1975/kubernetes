! /bin/bash

echo '[METALLB] Creating the name space for the metallb'
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.10.2/manifests/namespace.yaml

echo '[METALLB] Installating metallb'
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.10.2/manifests/metallb.yaml


echo '[METALLB] Creating Configuration'
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: ConfigMap
metadata:
  namespace: metallb-system
  name: config
data:
  config: |
    address-pools:
    - name: default
      protocol: layer2
      addresses:
      - 10.0.0.50-10.0.0.90
    - name: production-pool
      protocol: layer2
      addresses:
      - 10.0.0.110-10.0.0.150
EOF

