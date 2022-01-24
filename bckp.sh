#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- ipinfo.io/ip);
echo "Checking VPS"
IP=$(wget -qO- ipinfo.io/ip);
date=$(date +"%Y-%m-%d")
email=$(cat /home/email)
echo Membuat Directory
mkdir /root/backup
sleep 1
echo Start Backup
clear
cp -r /etc/xray/ backup/xray/
cp /etc/passwd backup/
cp /etc/group backup/
cp /etc/shadow backup/
cp /etc/gshadow backup/
cp /usr/local/etc/xray/config.json backup/
cd /root
zip -r $IP-$date.zip backup > /dev/null 2>&1
rclone copy /root/$IP-$date.zip william:backup/
url=$(rclone link william:backup/$IP-$date.zip)
id=(`echo $url | grep '^https' | cut -d'=' -f2`)
link="https://drive.google.com/u/4/uc?id=${id}&export=download"
echo -e "The following is a link to your vps data backup file.

Your VPS IP $IP

$link

If you want to restore data, please enter the link above.

Thank You For Using Our Services" | mail -s "Backup Data" $email
rm -rf /root/backup
rm -r /root/$IP-$date.zip
echo "Done"
echo "Please Check Your Email"
