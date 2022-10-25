echo nameserver 192.168.122.1 > /etc/resolv.conf

apt-get update
wait

apt-get install bind9 -y
wait

cat /root/conf_domain.txt > /etc/bind/named.conf.local

service bind9 start