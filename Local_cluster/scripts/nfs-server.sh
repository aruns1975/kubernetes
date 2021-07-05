RED='\033[0;31m'
GREEN='\032[0;31m'
NC='\033[0m'
echo "${GREEN}Updating the apt repository${NC}"
sudo apt-get update -y

echo "${GREEN}Installing the nfs-kernel-server${NC}"
sudo apt-get install nfs-kernel-server -y

echo "${GREEN}Fetching the status of nfs-server${NC}"
sudo systemctl status nfs-server

sudo mkdir /mnt/my_shares
sudo chown nobody:nogroup /mnt/my_shares
sudo chmod -R 777 /mnt/my_shares

sudo echo "/mnt/my_shares 10.0.0.5/24(rw,sync,no_subtree_check)" >>  /etc/exports

sudo exportfs -a
