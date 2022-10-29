# Jarkom-Modul-2-C01-2022

## **DNS**

#### soal 1-7

## Topologi

Berikut adalah topologi dengan rincian berikut: WISE akan dijadikan sebagai DNS Master, Berlint akan dijadikan DNS Slave, dan Eden akan digunakan sebagai Web Server. Terdapat 2 Client yaitu SSS, dan Garden. Semua node terhubung pada router Ostania, sehingga dapat mengakses internet.

![Topologi](./assets/topologi.png)

### **DNS Master Wise**

![wise config local](./assets/WISE/conf_local.png)

Pada Wise, file bind disambungkan pada /etc/bind/jarkom/c01.com sebagai config c01.com dan /etc/bind/jarkom/2.10.10.in-addr.arpa sebagai reverse domain.
Pada konfigurasi zone c01.com, diberi setup also notify dan allow-transfer ip 10.10.2.2. Hal ini bertujuan supaya ip tersebut menjadi DNS slave ketika DNS master dimatikan.

![wise bind](./assets/WISE/bind_jarkom.png)

Di atas adalah konfigurasi bind c01.com, terdapat beberapa hal antara lain:

1. c01.com merupakan ns dari wise
2. c01.com akan menerjemahkan ke ip 10.10.2.3
3. wise merupakan konfigurasi subdomain yang merujuk pada ip 10.10.2.3 dengan domain wise.c01.com
4. www.wise merupakan alias dari wise.c01.com
5. eden.wise merupakan konfigurasi subdomain yang merujuk pada ip 10.10.2.3 dengan domain eden.wise.c01.com
6. www.eden.wise.c01.com merupakan alias dari eden.wise.c01.com
7. operasion.wise merupakan delegasi subdomain untuk ip 10.10.2.2

![wise reverse](./assets/WISE/bind_reverse.png)

Di atas merupakan konfigurasi reverse domain dari c01.com

![wise option](./assets/WISE/conf_option.png)

di atas adalah konfigurasi option config, perbedaan yang paling nampak adalah dengan mengcomment dnssec-validation auto dan menambahkan allow-query{any} untuk mengaktifkan DNS slave.

## **Script Wise**

```bash
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
```

Pada kode di atas, setiap konfig disimpan pada file txt. Isi dari file txt sama seperti yang telah ditampilkan di atas. Pada script, pertama memasukkan ip nameserver pada konfigutasi supaya terhubung langsung dengan ostania dan dapat mengakses internet. Kemudian menginstal bind9 untuk konfigurasi DNS. setelah itu, memasukkan setiap konfig dari file yang telah disetup ke setiap direktori yang telah ditentukan. Terakhir adalah menstart bind9 dengan command service bind9 start supaya konfigurasi DNS server diterapkan dan DNS dapat berjalan dengan semestinya.


## **DNS Slave dan Delegasi Berlint**

![Berlint local config](./assets/Berlint/conf_local.png)
Pada local konfig, Berlint dikonfigurasi sebagai DNS slave dari c01,com dengan ip master 10.10.3.2. Kemudian Berlint mendapatkan delegasi domain operation.wise.c01.com.

![Berlint option](./assets/Berlint/conf_option.png)
di atas adalah konfigurasi option config, perbedaan yang paling nampak adalah dengan mengcomment dnssec-validation auto dan menambahkan allow-query{any} untuk mengaktifkan DNS slave.

![Berlint delegasi](./assets/Berlint/delegasi_bind.png)

Di atas adalah konfig pendelegasioan operation.wise.c01.com. Domain itu akan merujuk pada IP 10.10.2.3 atau ip dari Berlint. Selain itu, diberikan alias name www pada domain ini.

strix ditambahkan menjadi subdomain dari operation.wise.com kemudian diberi alias dengan www.strix yang merujuk pada strix.operation.wise.c01.com

## **Script Berlint**

```bash
echo nameserver 192.168.122.1 > /etc/resolv.conf

apt-get update
wait

apt-get install bind9 -y
wait

cat /root/conf_domain.txt > /etc/bind/named.conf.local

mkdir /etc/bind/delegasi
cp /etc/bind/db.local /etc/bind/delegasi/operation.wise.c01.com
cat /root/conf_bind_c01.txt > /etc/bind/delegasi/operation.wise.c01.com

cat /root/conf_options.txt > /etc/bind/named.conf.options

service bind9 start
```
Inti dari script Berlint sama dengan Wise. Perbedaannya adalah Berlint sebagai DNS slave dan mendapatkan delegasi sehingga file confignya sediki berbeda denan wise.
