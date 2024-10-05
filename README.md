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
git clone https://github.com/MinhSpaceX/MagentoDocker.git
cd MagentoDocker
```

## Run these commands to install Magento:
```
cd MagentoDocker
cd MagentoDocker-main
chmod -R +x command
command/all_in_one
```

# List of all commands
```
# Import database into container (change sql file name if needed)
command/mysql_import dump.sql
```
```
# Export database (change sql file name if needed)
command/mysqldump dump.sql
```
```
# Export database (change sql file name if needed)
command/mysqldump dump.sql
```
```
# Copy file, folder to container (at /var/www/html/magento)
command/copy_to_container    # Default arg1 = --all, arg2 = source
command/copy_to_container --all source   # Same as command 1
command/copy_to_container folder_or_file_name # A folder or file in source to copy into container
```
```
# Use to load config after copy file
command/import_config
```
```
# Use to set all permissions and ownerships, automatically used after copy file
command/set_privilege
```
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
