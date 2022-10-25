echo nameserver 192.168.122.1 > /etc/resolv.conf

apt-get update
wait

apt-get install apache2
wait

service apache2 start