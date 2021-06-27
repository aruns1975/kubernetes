# kubernetes

>## **The kubernates cluster creation contains the following steps**

- Creation of the Bare metal Virtual machine with ubuntu 20.04 LTS.
- Install the required softwares
    - docker-ce 
    - docker-ce-cli 
    - containerd.io 
    - kubelet=1.21.0-00
    - kubectl=1.21.0-00
    - kubeadm=1.21.0-00
    - net-tools
- Install the load balancer using haproxy (required for multi master cluster only)
- Configure the cluster using 'kubeadm'
- Install the pod cluster network (calico)
- Join the second master node (in the multi master cluster only)
- Join the second worker node 

>## **Folder structure**

- image_creation
    - This contains the steps to create the vagrant image with the basic sofftware installation.
- simple_cluster
    - This contains the steps to create the single master and multi worker kubernetes cluster
- cluster_with_multi_master
    - This contains the steps to create the kubernetes cluster with multiple master and worker
