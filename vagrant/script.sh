#!/bin/bash

yum update -y
yum install -y httpd php gcc glibc glibc-common make gettext automake autoconf wget openssl-devel net-tools unzip

cd /tmp
wget https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.4.6.tar.gz
tar xzf nagios-4.4.6.tar.gz
cd nagios-4.4.6
./configure --with-httpd-conf=/etc/httpd/conf.d
make all
make install-groups-users
make install
make install-init
make install-config
make install-commandmode
make install-exfoliation

cd /tmp
wget https://nagios-plugins.org/download/nagios-plugins-2.3.3.tar.gz
tar xzf nagios-plugins-2.3.3.tar.gz
cd nagios-plugins-2.3.3
./configure --with-nagios-user=nagios --with-nagios-group=nagios
make
make install

htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin

systemctl enable httpd
systemctl enable nagios
systemctl start httpd
systemctl start nagios

firewall-cmd --zone=public --add-port=80/tcp --permanent
firewall-cmd --reload