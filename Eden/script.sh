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

cat conf_apache.txt > /etc/apache2/sites-available/000-default.conf

# touch /var/www/wise.c01.com/.htaccess

# cat htaccess.txt > /var/www/wise.c01.com/.htaccess


a2enmod rewrite

service apache2 start