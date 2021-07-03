@echo off
kubectl apply -f ../yamls/jenkins.yaml
echo "The jenkins can be access fromhte following url(s)"
kubectl get services jenkins -o jsonpath="{range .status.loadBalancer.ingress[*]}{.ip}{end}" 