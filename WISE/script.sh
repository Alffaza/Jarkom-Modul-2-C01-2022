echo nameserver 192.168.122.1 > /etc/resolv.conf

apt-get update
wait

apt-get install bind9 -y
wait

cat /root/conf_domain.txt > /etc/bind/named.conf.local

mkdir /etc/bind/jarkom
cp /etc/bind/db.local /etc/bind/jarkom/c01.com
cat /root/conf_bind_c01.txt > /etc/bind/jarkom/c01.com

cp /etc/bind/db.local /etc/bind/jarkom/2.10.10.in-addr.arpa
cat /root/conf_reverse_domain.txt > /etc/bind/jarkom/2.10.10.in-addr.arpa

cat /root/conf_options.txt > /etc/bind/named.conf.options

service bind9 start
