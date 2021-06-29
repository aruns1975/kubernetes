@echo off
kubectl apply -f jenkins.yaml
echo "The jenkins can be access fromhte following url(s)"
kubectl get services jenkins -o jsonpath="{range .status.loadBalancer.ingress[*]}{.ip}{end}" 