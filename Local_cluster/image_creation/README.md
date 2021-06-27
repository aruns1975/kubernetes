# Vagrant Image creation

>## **Steps for the image file creation**

> Check out the code from teh bitbucket

```batch
git clone https://github.com/aruns1975/kubernetes.git    

cd image_creation
```

> Build the image and bring it on 

```shell
vagrant up
```

> Package the vagrant image

```shell
vgrant package --output ubuntu-k8s-package.box
```

> Upload the Vagrant at the vagrant cloud

- https://app.vagrantup.com/

