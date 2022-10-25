echo nameserver 10.10.3.2 > /etc/resolv.conf
echo nameserver 10.10.2.2 >> /etc/resolv.conf
echo nameserver 192.168.122.1 >> /etc/resolv.conf

apt-get install lynx -y
wait
