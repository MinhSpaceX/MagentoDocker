# MagentoDocker

## Install Docker
```
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install -y ca-certificates curl
sudo install -y -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

## Command to clone repo and prepare neccessaries:
```
export CURRENT_DIR=$(pwd)
echo "Current directory: $CURRENT_DIR"
mkdir $CURRENT_DIR/MagentoDocker
cd ./MagentoDocker
git clone https://github.com/MinhSpaceX/MagentoDocker.git .
chmod -R +x command
```

## Run this command to install fresh instance of Magento:
```
command/all_in_one
```

## Run these commands to copy existing project of Magento:
```
command/build_project
```
