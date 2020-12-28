<LINK href="jb1.css" rel="stylesheet" type="text/css">

#### [Back to index](index.html)

# Docker

## Concepts

Bit like a VM, but independent of operating system. instances transferrable between linux and windows.

VMs virtualize hardware. Containers virtualize the operating system.

covers Code, runtime env, libraries, config.

Advantages:

- consistent environment
- cross platform
- dependencies managed
- scale
- reuse of images

## Terms

**Docker image**  
is the read only template which defines the container. Image contains the code that will run, including libraries and dependencies. Read only binary template, plus metadata describing abilities and dependencies. Images shared via repository. 

**Docker container**
encapsulated running environment. it's a running docker image.

**Docker Daemon**
is a persistent background process managing images, containers, networks, storage volumes. Listens for API requests and processes.

**Docker Engine Rest API**
Http client can access this to interact with daemon

**Docker CLI**
command line for Daemon to manage instances.

**Docker client**
local or remote.
gives a CLI to give build, pull, run, stop commands to Docker daemon.

**Docker Host**
Comprises daemon, images, containers, storage, networks. 
Daemon processes commands from the client and pulls, builds, etc.

**Build file**
Goes with image

## Networking

Some abstraction. either default Docker network, or user defined. Each has 3 flavours:

- None
- bridge: no need for port forwarding. for containers to communicate with each other
- host

## AWS

**Amazon ECR: Amazon Elastic container registry**  
is an image registry for storing docker images.

**Amazon ECS: Amazon elastic container services**
When you're running lots of containers, need an orchestration tool. (e.g. Kubernetes, ECS, docker swarm). Start stop monitor thousands of containers.
Kubernetes is popular free open source.
Amazon EKS is Kubernetes on AWS with integration.

supports both

- Community edition (open source, free)
- Enterprise edition (subscription)

install on EC2 instance.

## Docker installation

Needs windows pro
installed the linux version from <https://docs.docker.com/install/linux/docker-ce/ubuntu/>
installed via Docker repositories

Update the apt package index:
>`$ sudo apt-get update`

Install packages to allow apt to use a repository over HTTPS:

>`$ sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent \ software-properties-common`

Add Docker’s official GPG key:
>`$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -`

Verify that you now have the key with the fingerprint 9DC8 5822 9FC7 DD38 854A E2D8 8D81 803C 0EBF CD88, by searching for the last 8 characters of the fingerprint.
>`$ sudo apt-key fingerprint 0EBFCD88`

```bash
pub   rsa4096 2017-02-22 [SCEA]
      9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88
uid           [ unknown] Docker Release (CE deb) <docker@docker.com>
sub   rsa4096 2017-02-22 [S]

# get stable release
$ sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# install
$ sudo apt-get install docker-ce docker-ce-cli containerd.io

#Verify that Docker Engine - Community is installed correctly by running the hello-world image.
$ sudo docker run hello-world
```

Docker Engine - Community is installed and running. The docker group is created but no users are added to it. You need to use sudo to run Docker commands. Continue to Linux postinstall to allow non-privileged users to run Docker commands and for other optional configuration steps.

linux post install
<https://docs.docker.com/install/linux/linux-postinstall/>

This looks like a better docker on windows / linux setup guide: <https://nickjanetakis.com/blog/setting-up-docker-for-windows-and-wsl-to-work-flawlessly>

Actually installed the windows version after all this.

## Docker Commands

start a container:

```Bash

docker run -d -p 80:80 docker/getting-started

-d - run the container in detached mode (in the background)
-p 80:80 - map port 80 of the host to port 80 in the container
docker/getting-started - the image to use

Dashboard shows the containers running on your machine.
```
