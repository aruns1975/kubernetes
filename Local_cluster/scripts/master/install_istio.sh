! /bin/bash

cd ~
curl -L https://istio.io/downloadIstio | sh -
echo export PATH=~/istio-1.13.1/bin:$PATH > ~/.bashrc
source ~/.bashrc
istioctl install --set profile=demo -y

#####
#####   heml installation
#####
#helm repo add istio https://istio-release.storage.googleapis.com/chart
#kubectl create namespace istio-systems
#kubectl create namespace istio-ingress
#kubectl label namespace istio-ingress istio-injection=enabled
#helm repo update

#helm install istio-base istio/base -n istio-system
#helm install istiod istio/istiod -n istio-system --wait


#helm install istio-ingress istio/gateway -n istio-ingress --wait