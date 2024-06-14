# Update
We have fully migrated the application and all of its interfaces, underlying models, etc. to Gitlab. Please see https://gitlab.com/mlpds_mit/askcosv2/askcos2_core for instructions on deployment; components in their own repositories will be automatically pulled during setup based on the provided config file in the askcos2_core repo.

# chemoenzymatic-askcos

[![askcos-base](https://img.shields.io/badge/-askcos--base-blue?style=flat-square)](https://github.com/itai-levin/chemoenzymatic-askcos)
[![askcos-data](https://img.shields.io/badge/-askcos--data-lightgray?style=flat-square)](https://github.com/ASKCOS/askcos-data)
[![askcos-core](https://img.shields.io/badge/-askcos--core-lightgray?style=flat-square)](https://github.com/itai-levin/askcos-core/tree/hybrid)
[![askcos-site](https://img.shields.io/badge/-askcos--site-lightgray?style=flat-square)](https://github.com/itai-levin/askcos-site/tree/hybrid)
[![askcos-deploy](https://img.shields.io/badge/-askcos--deploy-lightgray?style=flat-square)](https://github.com/itai-levin/askcos-deploy/tree/hybrid)
[![bkms-data](https://img.shields.io/badge/-askcos--deploy-lightgray?style=flat-square)](https://github.com/itai-levin/bkms-data/tree/master)

Base repository for all of the code that runs a modified version of ASKCOS that enables hybrid synthesis planning.

This version of ASKCOS was used for the work described in the manuscript ["Merging enzymatic and synthetic chemistry with computational synthesis planning"](https://www.nature.com/articles/s41467-022-35422-y)

The code for reproducing the results and figures from the paper are available [here](https://github.com/itai-levin/hybmind)

# Install
To install and deploy an instance of this version of ASKCOS that can be accessed through the GUI or API calls:
1. Clone this repository and all of its submodules using `git clone --recurse-submodules https://github.com/itai-levin/chemoenzymatic-askcos.git`
2. From the base folder call `bash deploy.sh`. This script:
* Adds the submodules as trusted repositories
* Pulls the model, template, and reactions for the BKMS template set
* Builds Docker images from for the `askcos-core` and `askcos-site` and pulls data from `askcos-data`
3. Access the GUI through the IP address of your server

# Quick start using Google Cloud Platform

```
# (0) Create a Google Cloud instance
#     - recommended specs: at least 4 vCPUs, 26 GB memory 
#     - select Ubuntu 18.04 LTS Minimal
#     - upgrade to a 100 GB disk
#     - allow HTTP and HTTPS traffic

# (1) Install basic utilities
sudo apt update
sudo apt search vim
sudo apt-get install vim
sudo apt-get install build-essential

# (2) Install docker
#     - https://docs.docker.com/engine/install/ubuntu/
sudo apt-get update
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io -y
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

# (3) Install docker-compose
#     - https://docs.docker.com/compose/install/
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# (4) Install git lfs
#     - https://github.com/git-lfs/git-lfs/wiki/Installation
sudo apt-get install software-properties-common -y
sudo add-apt-repository ppa:git-core/ppa -y
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
sudo apt-get install git-lfs -y
git lfs install
```
