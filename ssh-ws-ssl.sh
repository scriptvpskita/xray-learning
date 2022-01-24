#!/bin/bash
##autoscript_install_sshws+ssl443
#Author : william
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
clear

# step one : install package
mkdir -p /etc/william/
apt install nodejs
apt install npm
cd /etc/william/
wget -O PDirect.js "https://raw.githubusercontent.com/xkjdox/sojsiws/main/ndjdjdjdi.js"
chmod +x PDirect.js

# step two : configurasi sshws+ssl443
cat > /etc/systemd/system/cdn.service << END 
[Unit]
Description=P7COM-nodews1-WILLIAM
Documentation=https://p7com.net/
Documentation=https://t.me/user_legend
After=network.target nss-lookup.target

[Service]
User=nobody
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=node --expose-gc /etc/william/PDirect.js -dhost 127.0.0.1 -dport 109 -mport 2052
Restart=on-failure
RestartSec=3s

[Install]
WantedBy=multi-user.target
END

# step three : enable service and reboot
systemctl enable cdn.service
systemctl start cdn.service
clear
echo "INSTALL COMPLETED ! AUTOREBOOT ON 3 SEC."
sleep 1
echo "1"
sleep 1
echo "2"
sleep
echo "3"
echo "eh tapi boong"
rm -rf ssh-ws-ssl.sh
clear
