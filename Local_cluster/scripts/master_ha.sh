#! /bin/bash

MASTER_IP="10.1.0.101"
CONTROL_PLANE_IP="10.1.0.100"
NODENAME=$(hostname -s)
POD_CIDR="192.168.0.0/16"

sudo kubeadm config images pull

echo "Preflight Check Passed: Downloaded All Required Images"


sudo kubeadm init --control-plane-endpoint=$CONTROL_PLANE_IP:6443 --upload-certs --apiserver-advertise-address=$MASTER_IP  --apiserver-cert-extra-sans=$MASTER_IP --pod-network-cidr=$POD_CIDR --node-name $NODENAME --ignore-preflight-errors Swap

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Save Configs to shared /Vagrant location

# For Vagrant re-runs, check if there is existing configs in the location and delete it for saving new configuration.

config_path="/vagrant/configs"

if [ -d $config_path ]; then
   rm -f $config_path/*
else
   mkdir -p /vagrant/configs
fi

cp -i /etc/kubernetes/admin.conf /vagrant/configs/config
touch /vagrant/configs/join.sh
chmod +x /vagrant/configs/join.sh       

touch /vagrant/configs/join-master.sh
chmod +x /vagrant/configs/join-master.sh

export key=`sudo kubeadm init phase upload-certs --upload-certs |tail -1`
kubeadm token create --print-join-command --certificate-key $key > /vagrant/configs/join-master.sh
kubeadm token create --print-join-command > /vagrant/configs/join.sh

# Install Calico Network Plugin

curl https://docs.projectcalico.org/manifests/calico.yaml -O

kubectl apply -f calico.yaml

# Install Metrics Server

kubectl apply -f https://raw.githubusercontent.com/scriptcamp/kubeadm-scripts/main/manifests/metrics-server.yaml

# Install Kubernetes Dashboard

kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0/aio/deploy/recommended.yaml

# Create Dashboard User

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: ServiceAccount
metadata:
  name: admin-user
  namespace: kubernetes-dashboard
EOF

cat <<EOF | kubectl apply -f -
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: admin-user
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: admin-user
  namespace: kubernetes-dashboard
EOF

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Service
metadata:
  namespace: kubernetes-dashboard
  name: kubernetes-dashboard-service-np
  labels:
    k8s-app: kubernetes-dashboard
spec:
  type: NodePort
  ports:
  - port: 8443
    nodePort: 30001
    targetPort: 8443
    protocol: TCP
  selector:
    k8s-app: kubernetes-dashboard
EOF

kubectl -n kubernetes-dashboard get secret $(kubectl -n kubernetes-dashboard get sa/admin-user -o jsonpath="{.secrets[0].name}") -o go-template="{{.data.token | base64decode}}" >> /vagrant/configs/token

sudo -i -u vagrant bash << EOF
mkdir -p /home/vagrant/.kube
sudo cp -i /vagrant/configs/config /home/vagrant/.kube/
sudo chown 1000:1000 /home/vagrant/.kube/config
EOF

cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  selector:
    matchLabels:
      app: nginx
  replicas: 2 # tells deployment to run 2 pods matching the template
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.14.2
        ports:
        - containerPort: 80
EOF


cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Service
metadata:
  name: nginx-deployment
  labels:
    app: nginx
spec:
  type: NodePort
  ports:
  - port: 8080
    nodePort: 30002
    targetPort: 80
    protocol: TCP
  selector:
    app: nginx
EOF
echo '[METALLB] Creating the name space for the metallb'
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.10.2/manifests/namespace.yaml

echo '[METALLB] Installating metallb'
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.10.2/manifests/metallb.yaml

echo '[METALLB] Configuring metallb pools'
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