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

## Command to pull files:
```
mkdir Sites
cd Sites
curl -L -o MagentoDocker.zip https://github.com/MinhSpaceX/MagentoDocker/archive/refs/heads/main.zip
```

## Extract files
```
apt-get update && apt-get install -y unzip
unzip MagentoDocker.zip -d MagentoDocker
```

## Run these commands to install Magento:
```
cd MagentoDocker
cd MagentoDocker-main
chmod -R +x command
command/all_in_one
```
### Command list
```
# Set up all magento in 1 command
command/all_in_one
```
```
# Build image and Start all containers
command/start
```
```
# Download magento into container (change keys in command/download file)
command/download
```
```
# Install magento (change variables in env/magento file)
command/install
```
```
# Flush cache
command/flush_cache
```
```
# Reindex
command/reindex
```
```
# Disable authentication 2FA
command/disable_2fa
```
