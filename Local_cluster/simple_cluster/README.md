# **Simple kubernetes cluster** 

> Check out the code from teh bitbucket

```batch
git clone https://github.com/aruns1975/kubernetes.git    

cd Local_cluster\simple_cluster
```
> Configure the number of worker nodes by configuring the **[WORKER_COUNT]** in the Vagrantfile.

> Build the image and bring it on 

```shell
vagrant up
```

> Vagrant Environment


|VM Name|Host Name|IP Address|Role|
|-|-|-|-|
|master-node-1|master-node-1|10.0.0.100|Master, Control plane |
|worker-node-1|worker-node-1|10.0.0.101|Worker|
|

> The above step create the following folder and file

|File Name|Purpose|Remarks|
|-|-|-|
|configs/config|Holds the configuration for kubectl|Copy the file to the ~/.kube/config|
|configs/token|Holds the token for the Dash board|Copy the content when asked for the token in the Dashboard|
|configs/token.sh|Holds the command for the worker node to join the cluster|None|
|

> Configure the kubectl on local to point to tbe vagrant cluster

>##### Option1
```shell
cd configs
export KUBECONFIG=$(PWD)/config
```
>##### Option2
```shell
cp configs/config ~/.kube/config
```

>Checking the all the nodes
```shell
kubectl get nodes
```

>Dash Board

- https://10.0.0.100:30001

>Sample NGINX Deployment

>To login to any VMs

```shell
vagrant ssh master-node-1
```

- http://10.0.0.100/30002

To create new worker 

```shell
Create the new VMs (Just increase the WORKER_COUNT and run vagrant up)

Enter the command [kubeadm join ...] on the generated VMs
```
>To Generate the token for join a new node, run the below command on the master node

```shell
kubeadm token create --print-join-command
```

> To shutdown the cluster, 

```shell
vagrant halt
```

> To restart the cluster,

```shell
vagrant up
```

> To destroy the cluster, 

```shell
vagrant destroy -f
```



