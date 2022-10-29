echo nameserver 192.168.122.1 > /etc/resolv.conf

apt-get update
wait

apt-get install apache2 -y
wait

apt-get install libapache2-mod-php7.0 -y

apt-get install wget -y
apt-get install php -y
apt-get install zip -y

if [ ! -d "/var/www/wise.c01.com/" ]
then
    wget --no-check-certificate 'https://drive.google.com/uc?export=download&id=1S0XhL9ViYN7TyCj2W66BNEXQD2AAAw2e' -O wise.c01.com.zip
    unzip wise.c01.com.zip -d /var/www/
    mv /var/www/wise /var/www/wise.c01.com
fi

if [ ! -d "/var/www/eden.wise.c01.com/" ]
then
    wget --no-check-certificate 'https://drive.google.com/uc?export=download&id=1q9g6nM85bW5T9f5yoyXtDqonUKKCHOTV' -O eden.wise.c01.com.zip
    unzip eden.wise.c01.com.zip -d /var/www/
    mv /var/www/eden.wise /var/www/eden.wise.c01.com
fi


if [ ! -d "/var/www/strix.operation.wise.c01.com/" ]
then
    wget --no-check-certificate 'https://drive.google.com/uc?export=download&id=1bgd3B6VtDtVv2ouqyM8wLyZGzK5C9maT' -O www.strix.operation.wise.c01.com.zip
    unzip www.strix.operation.wise.c01.com.zip -d /var/www/
    mv /var/www/strix.operation.wise /var/www/strix.operation.wise.c01.com
fi


touch /etc/apache2/sites-available/wise.c01.com.conf
touch /etc/apache2/sites-available/eden.wise.c01.com.conf
touch /etc/apache2/sites-available/strix.operation..wise.c01.com.conf

cat conf_wise.txt > /etc/apache2/sites-available/wise.c01.com.conf

cat conf_eden.wise.txt > /etc/apache2/sites-available/eden.wise.c01.com.conf

cat conf_strix.wise.txt > /etc/apache2/sites-available/strix.operation.wise.c01.com.conf

cat conf_default.txt > /etc/apache2/sites-available/000-default.conf

cat conf_ports.txt > /etc/apache2/ports.conf

# touch /var/www/wise.c01.com/.htaccess

# cat htaccess.txt > /var/www/wise.c01.com/.htaccess


a2enmod rewrite
a2enmod proxy
a2enmod proxy_http

echo 'Twilight:$apr1$3/xfxIfk$lBhxFHYIej9Nbisg2UyLB/' > /etc/apache2/.htpasswd

echo 'AuthType Basic
AuthName "Restricted Content"
AuthUserFile /etc/apache2/.htpasswd
Require valid-user' > /var/www/strix.operation.wise.c01.com/.htaccess

echo 'RewriteEngine On
RewriteBase /
RewriteCond %{HTTP_HOST} ^10\.10\.2\.3$
RewriteRule ^(.*)$ http://www.wise.c01.com [L,R=301]' > /var/www/html/.htaccess


echo 'RewriteEngine On
RewriteRule ^(.*)eden(.*)(jpg|gif|png)$ http://eden.wise.c01.com/public/images/eden.png [L,R]' > /var/www/eden.wise.c01.com/.htaccess
 

a2ensite wise.c01.com
a2ensite eden.wise.c01.com
a2ensite strix.operation.wise.c01.com

service apache2 start
service apache2 restart
