# MagentoDocker

## Command to pull files:
```
mkdir Sites
cd Sites
curl -L -o MagentoDocker.zip https://github.com/MinhSpaceX/MagentoDocker/archive/refs/heads/main.zip
```

## Extract files
```
# apt-get update && apt-get install -y unzip          # Uncomment this line if unzip is not present
unzip MagentoDocker.zip -d MagentoDocker
```

## Run these commands to install Magento:
```
cd MagentoDocker
chmod -R +x command
command/start
command/download
command/install
command/start
```
