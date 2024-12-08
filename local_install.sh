#!/bin/bash
DOMAIN_NAME="domain_name"
PUBLIC_KEY=public_key
PRIVATE_KEY=private_key
# Install neccessaries
sudo apt-get -y update
sudo apt-get install -y composer
sudo apt-get install -y software-properties-common

##
sudo apt-get -y update
sudo add-apt-repository -y ppa:ondrej/php
sudo apt-get -y update
sudo apt-get install -y curl wget gnupg

##
sudo apt install -y nginx
sudo ufw allow 'Nginx HTTP'
sudo ufw allow 'Nginx HTTPS'
sudo ufw allow OpenSSH
sudo ufw enable

####################### Install MySQL
sudo apt install -y mysql-server
sudo mysql_secure_installation --use-default
##
sudo mysql<<EOF
set global validate_password.policy = LOW;
set global validate_password.length = 0;
set global validate_password.mixed_case_count = 0;
set global validate_password.number_count = 0;
set global validate_password.special_char_count = 0;
DROP DATABASE IF EXISTS magento;
CREATE DATABASE magento;
CREATE USER 'magento'@'%' IDENTIFIED WITH mysql_native_password BY '12345678';
GRANT ALL ON magento.* TO 'magento'@'%';
exit
EOF

#==================================================================Install php==========================================#######################################
sudo apt install -y php8.3-fpm php8.3-mysql
sudo apt-get install -y php8.3-common php8.3-xml php8.3-curl php8.3-bcmath php8.3-intl php8.3-gd php8.3-zip php8.3-mysql php8.3-soap

#Install ElasticSearch8#####################################################################################==========================================#########################
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor --yes -o /usr/share/keyrings/elasticsearch-keyring.gpg

sudo apt-get install -y apt-transport-https

echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-7.x.list

sudo apt-get update && sudo apt-get install elasticsearch=7.17.0

sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable elasticsearch.service
sudo systemctl start elasticsearch.service

### Install magento ##################################################################################==========================================################
sudo chown -R $USER:$USER /var/www/
rm -rf /var/www/$DOMAIN_NAME 
mkdir /var/www/$DOMAIN_NAME
composer config -g http-basic.repo.magento.com $PUBLIC_KEY $PRIVATE_KEY
cd /var/www/$DOMAIN_NAME || { echo "Failed to change directory to /var/www/$DOMAIN_NAME"; exit 1; }
composer create-project --repository-url=https://repo.magento.com/ magento/project-community-edition=2.4.7-p2 magento

cd /var/www/$DOMAIN_NAME/magento
sudo find var generated vendor pub/static pub/media app/etc -type f -exec chmod g+w {} +
sudo find var generated vendor pub/static pub/media app/etc -type d -exec chmod g+ws {} +
sudo chown -R :www-data .
sudo chmod u+x bin/magento
#=======================================
sudo tee /etc/nginx/sites-available/$DOMAIN_NAME << EOF
upstream fastcgi_backend {
   server   unix:/var/run/php/php8.3-fpm.sock;
}
server {
   listen 80;
   server_name $DOMAIN_NAME;
   set \$MAGE_ROOT /var/www/$DOMAIN_NAME/magento;
   set \$MAGE_DEBUG_SHOW_ARGS 0;
   include /var/www/$DOMAIN_NAME/magento/nginx.conf.sample;
}
EOF

HOST_ENTRY="127.0.0.1 $DOMAIN_NAME"
HOSTS_FILE="/etc/hosts"

if grep -q "^[^#]*$HOST_ENTRY" "$HOSTS_FILE"; then
    echo "$HOST_ENTRY existed"
else
    echo "127.0.0.1 $DOMAIN_NAME" | sudo tee -a /etc/hosts > /dev/null
    echo "Enabled $HOST_ENTRY"
fi

#=======================================
sudo unlink /etc/nginx/sites-enabled/default
sudo unlink /etc/nginx/sites-enabled/"$DOMAIN_NAME"
sudo ln -s /etc/nginx/sites-available/"$DOMAIN_NAME" /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx

#####/
php bin/magento setup:install \
--backend-frontname super_admin \
--base-url=http://"$DOMAIN_NAME" \
--db-host=localhost \
--db-name=magento \
--db-user=magento \
--db-password=12345678 \
--admin-firstname=Admin \
--admin-lastname=Admin \
--admin-email=admin@admin.com \
--admin-user=admin \
--admin-password=admin123 \
--language=en_US \
--currency=USD \
--timezone=America/Chicago \
--use-rewrites=1 \
--search-engine=elasticsearch7 \
--elasticsearch-host=localhost \
--elasticsearch-port=9200

bin/magento module:disable Magento_AdminAdobeImsTwoFactorAuth Magento_TwoFactorAuth
bin/magento cache:flush 
php bin/magento indexer:reindex
