echo nameserver 192.168.122.1 > /etc/resolv.conf

apt-get update
wait

apt-get install apache2 -y
wait

apt-get install wget -y
apt-get install zip -y

wget --no-check-certificate 'https://drive.google.com/uc?export=download&id=1S0XhL9ViYN7TyCj2W66BNEXQD2AAAw2e' -O wise.c01.com.zip
unzip wise.c01.com.zip -d /var/www/

service apache2 start