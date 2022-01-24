#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- ipinfo.io/ip);
echo "Checking VPS"
IZIN=$( curl https://raw.githubusercontent.com/xkjdox/rijrekeksdpdolwoqkqkakodix/main/Nxbdjekkwso.txt | grep $MYIP )
if [ $MYIP = $IZIN ]; then
echo -e "${green}Permission Accepted${NC}"
else
echo -e "${red}Permission Denied!${NC}";
echo "Only For Premium Users"
exit 0
fi
IP=$(wget -qO- ipinfo.io/ip);
date=$(date +"%Y-%m-%d")
clear
echo " Enter Your Email To Receive Message"
read -rp " Email: " -e email
sleep 1
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

