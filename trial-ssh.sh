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
clear
IP=$(wget -qO- ipinfo.io/ip);
ssl="$(cat ~/log-install.txt | grep -w "Stunnel4" | cut -d: -f2)"
ssl2="$(cat ~/log-install.txt | grep -w "Stunnel4" | cut -d " " -f 22)"
Login=trial`</dev/urandom tr -dc X-Z0-9 | head -c4`
hari="1"
Pass=1
echo Ping Host
echo Cek Hak Akses...
sleep 0.5
echo Permission Accepted
clear
sleep 0.5
echo Membuat Akun: $Login
sleep 0.5
echo Setting Password: $Pass
sleep 0.5
clear
useradd -e `date -d "$masaaktif days" +"%Y-%m-%d"` -s /bin/false -M $Login
exp="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
echo -e ""
echo -e "=========================="
echo -e "INFORMASI TRIAL"
echo -e "SSH  ACCOUNT"
echo -e "==========================="
echo -e "IP-Addres : $IP"
echo -e "Hostname : $DOMAIN"
echo -e "Username : $Login "
echo -e "Password : $Pass"
echo -e "=========================="
echo -e "Port openssh : 22"
echo -e "Port dropbear : 109, 143"
echo -e "Port stunnel : $ssl"
echo -e "Port ssh websocket http : 2052"
echo -e "Port ssh websocket https : $ssl2"
echo -e "Port squid : 8080, 3128"
echo -e "Port badvpn/udpgw : 7100-7300"
echo -e "=========================="
echo -e "Payload Websocket HTTP : GET / HTTP/1.1[crlf]Host: $DOMAIN[crlf]Upgrade: websocket[crlf][crlf]"
echo -e "=========================="
echo -e "Payload Websocket HTTPS : GET wss://isi_bug_disini/ HTTP/1.1[crlf]Host: $DOMAIN[crlf]Upgrade: Websocket[crlf]Connection: Keep-Alive[crlf][crlf]"
echo -e "==========================="
echo -e "Expired on : $exp"

