#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
echo "Checking VPS"
	if ! which wget > /dev/null; then
         clear
  	   echo -e "${red}Wah Mau Belajar Nakal Yah !${NC}"
         sleep 2
     	   exit 0
	   clear
	else
	   echo "Wget is already installed"
	fi

	if ! which curl > /dev/null; then
         clear
  	   echo -e "${red}Wah Mau Belajar Nakal Yah !${NC}"
         sleep 2
     	   exit 0
	   clear
	else
	   echo "curl is already installed"
	fi
fileee=/usr/bin/wget
minimumsize=400000
actualsize=$(wc -c <"$fileee")
if [ $actualsize -ge $minimumsize ]; then
    clear
    echo -e "${green}Checking...${NC}"
else
    clear
    echo -e "${red}Permission Denied!${NC}";
    echo "Reason : Modified Package To Bypass Sc"
    exit 0
fi
fileeex=/usr/bin/curl
minimumsizex=15000
clear
actualsizex=$(wc -c <"$fileeex")
if [ $actualsizex -ge $minimumsizex ]; then
    clear
    echo -e "${green}Checking...${NC}"
else
    clear
    echo -e "${red}Permission Denied!${NC}";
    echo "Reason : Modified Package To Bypass Sc"
    exit 0
fi

dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`

TYTYD () {
    curl -sS -H 'Cache-Control: no-cache, no-store' https://raw.githubusercontent.com/xkjdox/rijrekeksdpdolwoqkqkakodix/main/Nxbdjekkwso.txt > /root/tmp
    data=( `cat /root/tmp | grep -E "^### " | awk '{print $2}'` )
    for user in "${data[@]}"
    do
    exp=( `grep -E "^### $ClientName" "/root/tmp" | awk '{print $3}' | sort | uniq` )
    d1=(`date -d "$exp" +%s`)
    d2=(`date -d "$biji" +%s`)
    exp2=$(( (d1 - d2) / 86400 ))
    if [[ "$exp2" -le "0" ]]; then
    echo $user > /etc/.$user.ini
    else
    rm -rf /etc/.$user.ini > /dev/null 2>&1
    rm -rf /usr/local/etc/.$Name.ini > /dev/null 2>&1
    fi
    done
    rm -rf /root/tmp
}

MYIP=$(curl -sS ipinfo.io/ip)
Name=$(curl -sS -H 'Cache-Control: no-cache, no-store' https://raw.githubusercontent.com/xkjdox/rijrekeksdpdolwoqkqkakodix/main/Nxbdjekkwso.txt | grep $MYIP | awk '{print $2}')
echo $Name > /usr/local/etc/.$Name.ini
CekOne=$(cat /usr/local/etc/.$Name.ini)

KNTL () {
if [ -f "/etc/.$Name.ini" ]; then
CekTwo=$(cat /etc/.$Name.ini)
fi
    if [ "$CekOne" = "$CekTwo" ]; then
        clear
        echo -e "$red Permission Denied : Expired ! ${NC}"
        echo -e "Please Contact t.me/user_legend"
        exit 0
else
clear
echo -e "${green}Permission Accepted : Checking Expired Accepted...${NC}"
fi
}

MMK () {
    MYIP=$(curl -sS ipinfo.io/ip)
    IZIN=$(curl -sS -H 'Cache-Control: no-cache, no-store' https://raw.githubusercontent.com/xkjdox/rijrekeksdpdolwoqkqkakodix/main/Nxbdjekkwso.txt | awk '{print $4}' | grep $MYIP)
    if [ "$MYIP" = "$IZIN" ]; then
    TYTYD
    else
    clear
    echo -e "${red}Permission Denied : IP Addres Not Found In Database !${NC}"
    echo -e "Please Contact t.me/user_legend"
    exit 0
    fi
    KNTL
}

JMBD () {
    ClientName=$(cat /usr/local/etc/clientname)
    IZIN=$(curl -sS -H 'Cache-Control: no-cache, no-store' https://raw.githubusercontent.com/xkjdox/rijrekeksdpdolwoqkqkakodix/main/Nxbdjekkwso.txt | grep $ClientName | awk '{print $2}' | uniq)
    if [ "$ClientName" = "$IZIN" ]; then
    echo -e "${green}Permission Accepted : Checking ClientName Accepted${red}"
    clear
    else
    clear
    echo -e "${red}Permission Denied : ClientName Not Compatible !${NC}"
    echo -e "Please Contact t.me/user_legend"
    exit 0
    fi
}
ClientNameX=/usr/local/etc/clientname
if [[ -z $(grep '[^[:space:]]' $ClientNameX) ]] ; then
echo -e "${red}Permission Denied : ClientName Not Found !${NC}"
exit 0
fi
JMBD
MMK
clear

echo " "
echo " "

if [ -e "/var/log/auth.log" ]; then
        LOG="/var/log/auth.log";
fi
if [ -e "/var/log/secure" ]; then
        LOG="/var/log/secure";
fi
                
data=( `ps aux | grep -i dropbear | awk '{print $2}'`);
echo "-----=[ Dropbear User Login ]=-----";
echo "ID  |  Username  |  IP Address";
echo "-------------------------------------";
cat $LOG | grep -i dropbear | grep -i "Password auth succeeded" > /tmp/login-db.txt;
for PID in "${data[@]}"
do
        cat /tmp/login-db.txt | grep "dropbear\[$PID\]" > /tmp/login-db-pid.txt;
        NUM=`cat /tmp/login-db-pid.txt | wc -l`;
        USER=`cat /tmp/login-db-pid.txt | awk '{print $10}'`;
        IP=`cat /tmp/login-db-pid.txt | awk '{print $12}'`;
        if [ $NUM -eq 1 ]; then
                echo "$PID - $USER - $IP";
                fi
done
echo " "
echo "-----=[ OpenSSH User Login ]=-----";
echo "ID  |  Username  |  IP Address";
echo "-------------------------------------";
cat $LOG | grep -i sshd | grep -i "Accepted password for" > /tmp/login-db.txt
data=( `ps aux | grep "\[priv\]" | sort -k 72 | awk '{print $2}'`);

for PID in "${data[@]}"
do
        cat /tmp/login-db.txt | grep "sshd\[$PID\]" > /tmp/login-db-pid.txt;
        NUM=`cat /tmp/login-db-pid.txt | wc -l`;
        USER=`cat /tmp/login-db-pid.txt | awk '{print $9}'`;
        IP=`cat /tmp/login-db-pid.txt | awk '{print $11}'`;
        if [ $NUM -eq 1 ]; then
                echo "$PID - $USER - $IP";
        fi
done
if [ -f "/etc/openvpn/server/openvpn-tcp.log" ]; then
        echo " "
        echo "-----=[ OpenVPN TCP User Login ]=-----";
        echo "Username  |  IP Address  |  Connected Since";
        echo "-------------------------------------";
        cat /etc/openvpn/server/openvpn-tcp.log | grep -w "^CLIENT_LIST" | cut -d ',' -f 2,3,8 | sed -e 's/,/      /g' > /tmp/vpn-login-tcp.txt
        cat /tmp/vpn-login-tcp.txt
fi
echo "-------------------------------------"

if [ -f "/etc/openvpn/server/openvpn-udp.log" ]; then
        echo " "
        echo "-----=[ OpenVPN UDP User Login ]=-----";
        echo "Username  |  IP Address  |  Connected Since";
        echo "-------------------------------------";
        cat /etc/openvpn/server/openvpn-udp.log | grep -w "^CLIENT_LIST" | cut -d ',' -f 2,3,8 | sed -e 's/,/      /g' > /tmp/vpn-login-udp.txt
        cat /tmp/vpn-login-udp.txt
fi
echo "-------------------------------------"
echo "";

