
echo "[apt-get] -> Updating"
sudo apt-get update -y

echo "[apt-get] -> Installing the haproxy"
sudo apt-get install -y haproxy

echo "[edit /etc/haproxy/haproxy.cfg] -> Adding kubernetes-frontend"
cat <<EOF | sudo tee -a /etc/haproxy/haproxy.cfg
frontend kubernetes-frontend
    bind 10.0.0.100:6443
    mode tcp
    option tcplog
    default_backend kubernetes-backend
EOF

echo "[edit /etc/haproxy/haproxy.cfg] -> Adding kubernetes-backend"
cat <<EOF | sudo tee -a /etc/haproxy/haproxy.cfg

backend kubernetes-backend
    mode tcp
    option tcp-check
    balance roundrobin
    server master-node-1 10.0.0.101:6443 check fall 3 rise 2
    server master-node-2 10.0.0.102:6443 check fall 3 rise 2
EOF

systemctl restart haproxy