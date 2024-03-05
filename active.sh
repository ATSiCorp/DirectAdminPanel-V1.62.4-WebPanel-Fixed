firewall-cmd --zone=external --add-port=2222/tcp --permanent
firewall-cmd --zone=external --add-port=21/tcp --permanent
firewall-cmd --zone=external --add-port=80/tcp --permanent
firewall-cmd --zone=external --add-port=443/tcp --permanent
firewall-cmd --zone=external --add-port=53/tcp --permanent
firewall-cmd --zone=external --add-port=23/tcp --permanent
firewall-cmd --zone=external --add-port=110/tcp --permanent
firewall-cmd --zone=external --add-port=143/tcp --permanent
firewall-cmd --zone=external --add-port=587/tcp --permanent
firewall-cmd --zone=external --add-port=993/tcp --permanent
firewall-cmd --zone=external --add-port=995/tcp --permanent
sudo firewall-cmd --zone=external --change-interface=eth0 --permanent
firewall-cmd --reload
systemctl restart directadmin
cd /usr/local/directadmin/conf/
service directadmin stop
rm -rf /usr/local/directadmin/conf/license.key
wget -O /usr/local/directadmin/conf/license.key 'http://license.vsicloud.com/getLic.php'
chmod 600 /usr/local/directadmin/conf/license.key
chown diradmin:diradmin /usr/local/directadmin/conf/license.key
ifconfig eth0:100 10.48.114.194 netmask 255.255.255.252 up
echo 'DEVICE=eth0:100' >> /etc/sysconfig/network-scripts/ifcfg-eth0:100
echo 'IPADDR=10.48.114.194' >> /etc/sysconfig/network-scripts/ifcfg-eth0:100
echo 'NETMASK=255.255.255.252' >> /etc/sysconfig/network-scripts/ifcfg-eth0:100
service network restart
/usr/bin/perl -pi -e 's/^ethernet_dev=.*/ethernet_dev=eth0:100/' /usr/local/directadmin/conf/directadmin.conf
service directadmin start
