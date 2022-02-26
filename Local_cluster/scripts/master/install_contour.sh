! /bin/bash
# Using manifest
#  kubectl apply -f https://projectcontour.io/quickstart/contour.yaml
helm repo add bitnami https://charts.bitnami.com/bitnami
#helm repo update
#helm install my-release bitnami/contour --namespace projectcontour --create-namespace