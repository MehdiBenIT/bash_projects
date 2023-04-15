#!/bin/bash
#nextcloud_install.sh
#Crée par : Mehdi B.
#Version : v1.0
#Date : 02/06/2022

#Mise à jour des paquets disponibles
apt update -y
apt install sudo htop net-tools wget

#Installation du serveur web
apt install apache2 -y

#Activation et configuration Firewall
ufw enable
sudo ufw allow 'Apache Full'
sufo ufw reload

#Installation MySQL 
sudo apt install mysql-server -y
mysql_secure_installation

#Configuration MySQL
mysql -u root -p -e "CREATE DATABASE nextcloud";
mysql -u root -p -e "CREATE USER 'nextcloud_user'@'localhost' IDENTIFIED BY 'azerty123!$'";
mysql -u root -p -e "GRANT ALL PRIVILEGES ON nexcloud.* TO 'nextcloud_user'@'localhost'";
mysql -u root -p -e "FLUSH PRIVILEGES";
mysql -u root -p -e "EXIT";

#Installation PHP
sudo apt install php libapache2-mod-php php-mysql php-mbstring php-gd php-json php-curl php-mbstring
php-intl php-mcrypt php-imagick php-xml php-zip php-bz2 php-zip php-dom

#Affichage version php
php -v

#Téléchargement et ajout du code source de nextcloud
wget https://download.nextcloud.com/server/releases/latest.zip -O nextcloud.zip
unzip nextcloud.zip
mv nextcloud /var/www/nextcloud
chmod -R www-data:www-data /var/www/nextcloud

touch /etc/apache2/sites-available/nextcloud.conf
cat << EOF > /etc/apache2/sites-available/nextcloud.conf
<VirtualHost *:80>
  DocumentRoot /var/www/nextcloud/
  ServerName  files.turtletech.fr

  <Directory /var/www/nextcloud/>
    Require all granted
    AllowOverride All
    Options FollowSymLinks MultiViews

    <IfModule mod_dav.c>
      Dav off
    </IfModule>
  </Directory>
</VirtualHost>
EOF

#Activation du site
sudo a2ensite nextcloud.conf
sudo a2dissite 000-default
sudo apache2ctl configtest

sed -e "s/ServerName*/ServerName 127.0.0.1/" > /etc/apache2/apache2.conf

systemctl reload apache2
sudo apache2ctl configtest



