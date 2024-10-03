# MagentoDocker

## Install Docker
```
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

## Command to pull files:
```
mkdir Sites
cd Sites
curl -L -o MagentoDocker.zip https://github.com/MinhSpaceX/MagentoDocker/archive/refs/heads/main.zip
```

## Extract files
```
apt-get update && apt-get install -y unzip          # Uncomment this line if unzip is not present
unzip MagentoDocker.zip -d MagentoDocker
```

## Run these commands to install Magento:
```
cd MagentoDocker
cd MagentoDocker-main
chmod -R +x command
command/start
command/download
command/install
command/start
```
