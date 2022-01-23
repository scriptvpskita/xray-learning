#!/bin/bash
clear
red="\e[1;31m"
green="\e[0;32m"
NC="\e[0m"

figlet -f small -t "      WILLIAM" | lolcat
echo -e "              TELEGRAM : t.me/user_legend"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[41;1;37m                 ⇱ SYSTEM INFORMATION ⇲                 \E[0m"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10 )
CITY=$(curl -s ipinfo.io/city )
WKT=$(curl -s ipinfo.io/timezone )
IPVPS=$(curl -s ipinfo.io/ip )
domain=$( cat /etc/v2ray/domain )
scversion=$( cat /home/ver )
cname=$( awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo )
cores=$( awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo )
freq=$( awk -F: ' /cpu MHz/ {freq=$2} END {print freq}' /proc/cpuinfo )
tram=$( free -m | awk 'NR==2 {print $2}' )
swap=$( free -m | awk 'NR==4 {print $2}' )
up=$(uptime|awk '{ $1=$2=$(NF-6)=$(NF-5)=$(NF-4)=$(NF-3)=$(NF-2)=$(NF-1)=$NF=""; print }')
cpusage0=$( awk '$1~/cpu[0]/{usage=($2+$4)*100/($2+$4+$5); print $1": "usage"%"}' /proc/stat )
cpusage1=$( awk '$1~/cpu[1]/{usage=($2+$4)*100/($2+$4+$5); print $1": "usage"%"}' /proc/stat )
cpusage2=$( awk '$1~/cpu[2]/{usage=($2+$4)*100/($2+$4+$5); print $1": "usage"%"}' /proc/stat )
cpusage3=$( awk '$1~/cpu[3]/{usage=($2+$4)*100/($2+$4+$5); print $1": "usage"%"}' /proc/stat )
cpusage4=$( awk '$1~/cpu[4]/{usage=($2+$4)*100/($2+$4+$5); print $1": "usage"%"}' /proc/stat )
cpusage5=$( awk '$1~/cpu[5]/{usage=($2+$4)*100/($2+$4+$5); print $1": "usage"%"}' /proc/stat )
cpusage6=$( awk '$1~/cpu[6]/{usage=($2+$4)*100/($2+$4+$5); print $1": "usage"%"}' /proc/stat )
cpusage7=$( awk '$1~/cpu[7]/{usage=($2+$4)*100/($2+$4+$5); print $1": "usage"%"}' /proc/stat )
cpusage8=$( awk '$1~/cpu[8]/{usage=($2+$4)*100/($2+$4+$5); print $1": "usage"%"}' /proc/stat )
cpusage9=$( awk '$1~/cpu[9]/{usage=($2+$4)*100/($2+$4+$5); print $1": "usage"%"}' /proc/stat )
echo -e "\e[032;1mCPU MODEL:\e[0m $cname"
echo -e "\e[032;1mNUMBER OF CORE:\e[0m $cores"
echo -e "\e[032;1mCPU FREQUENSI:\e[0m $freq MHz"
echo -e "\e[032;1mCPU USAGE:\e[0m $cpusage0 $cpusage1 $cpusage2 $cpusage3 $cpusage4 $cpusage5 $cpusage6 $cpusage7 $cpusage8 $cpusage9"
echo -e "\e[032;1mTOTAL RAM:\e[0m $tram MB"
echo -e "\e[032;1mSYSTEM UPTIME:\e[0m $up"
echo -e "\e[032;1mISP NAME:\e[0m $ISP"
echo -e "\e[032;1mCITY:\e[0m $CITY"
echo -e "\e[032;1mTIME:\e[0m $WKT"
echo -e "\e[032;1mIPVPS:\e[0m $IPVPS"
echo -e "\e[032;1mDOMAIN:\e[0m $domain"
echo -e "\e[032;1mVERSION SCRIPT:\e[0m $scversion"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"

echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[41;1;37m                 ⇱ SERVICE INFORMATION ⇲                \E[0m"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
status="$(systemctl show ssh.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " SSH               : SSH Service is "$green"running"$NC""
else
echo -e " SSH               : SSH Service is "$red"not running (Error)"$NC""
fi
status="$(systemctl show cdn.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " SSH WEBSOCKET     : SSH Websocket Service is "$green"running"$NC""
else
echo -e " SSH WEBSOCKET     : SSH Websocket Service is "$red"not running (Error)"$NC""
fi
status="$(systemctl show stunnel4.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " STUNNEL           : Stunnel Service is "$green"running"$NC""
else
echo -e " STUNNEL           : Stunnel Service is "$red"not running (Error)"$NC""
fi
status="$(systemctl show squid.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " SQUID             : Squid Service is "$green"running"$NC""
else
echo -e " SQUID             : Squid Service is "$red"not running (Error)"$NC""
fi
status="$(systemctl show dropbear.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " DROPBEAR          : DropBear Service is "$green"running"$NC""
else
echo -e " DROPBEAR          : DropBear Service is "$red"not running (Error)"$NC""
fi
status="$(systemctl show xray.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " XRAY              : XRAY Service is "$green"running"$NC""
else
echo -e " XRAY              : XRAY Service is "$red"not running (Error)"$NC""
fi
status="$(systemctl show nginx.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " NGINX             : Nginx Service is "$green"running"$NC""
else
echo -e " NGINX             : Nginx Service is "$red"not running (Error)"$NC""
fi
status="$(systemctl show cron.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " CRON              : Cron Service is "$green"running"$NC""
else
echo -e " CRON              : Cron Service is "$red"not running (Error)"$NC""
fi
status="$(systemctl show cron.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " FAIL2BAN          : Fail2ban Service is "$green"running"$NC""
else
echo -e " FAIL2BAN          : Fail2ban Service is "$red"not running (Error)"$NC""
fi
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"

echo -e  ""
echo -e  "type \033[1;91mmenu\e[0m to continue"
