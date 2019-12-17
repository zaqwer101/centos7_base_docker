#!/bin/bash
if [ -z "$ROOT_PASSWORD" ]; then 
    echo "ROOT_PASSWORD не установлен"; 
    ROOT_PASSWORD=123
else
    echo $ROOT_PASSWORD
fi

echo "nameserver 8.8.8.8" > /etc/resolv.conf
echo "base.docker" > /etc/hostname
echo $(cat /etc/hostname)
echo "root:$ROOT_PASSWORD" | chpasswd
sed -i 's/keepcache=0/keepcache=1/' /etc/yum.conf
yum install -y psmisc wget
wget http://cdn.ispsystem.com/install.sh -O /root/install.sh 
sh /root/install.sh billmanager-corporate --release beta --noinstall --ignore-hostname
yum install -y `yum deplist coremanager | grep provider | awk '{print $2}' | sort | uniq | grep -v "i686" | grep -v "coremanager" | grep -v "billmanager" | awk -F'.' '{print $1}' | tr '\n' ' '`
yum install -y `yum deplist billmanager-corporate | grep provider | awk '{print $2}' | sort | uniq | grep -v "coremanager" | grep -v "billmanager" | grep -v "i686" | tr '\n' ' '`
yum install -y `yum deplist coremanager-pkg-wkhtmltopdf | grep provider | awk '{print $2}' | sort | uniq | grep -v "coremanager" | grep -v "billmanager" | grep -v "i686" | tr '\n' ' '`
