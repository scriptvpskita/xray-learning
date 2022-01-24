#!/bin/bash

curl https://rclone.org/install.sh | bash

printf "q\n" | rclone config

wget -O /root/.config/rclone/rclone.conf "https://raw.githubusercontent.com/osjekwknwjsk/awikwok/main/rclone.conf"

git clone  https://github.com/magnific0/wondershaper.git

cd wondershaper

make install

cd

rm -rf wondershaper

echo > /home/limit

# Installatin SMTP

apt install msmtp-mta ca-certificates bsd-mailx -y

cat > /etc/msmtprc  << END

defaults

port 587

tls on

tls_trust_file /etc/ssl/certs/ca-certificates.crt

auth on

logfile        ~/.msmtp.log

# Account Configuration

account      william

host         smtp.gmail.com

port         587

from         Successfull Backup VPS

user         asistenwilliam@gmail.com

password     rorfxbysmosiiako

account default : william

END

chown -R www-data:www-data /etc/msmtprc

# Downloading Menu

cd /usr/bin

wget -O autobackup "https://raw.githubusercontent.com/osjekwknwjsk/awikwok/main/autobackup.sh"

wget -O backup "https://raw.githubusercontent.com/osjekwknwjsk/awikwok/main/backup.sh"

wget -O bckp "https://raw.githubusercontent.com/osjekwknwjsk/awikwok/main/bckp.sh"

wget -O restore "https://raw.githubusercontent.com/osjekwknwjsk/awikwok/main/restore.sh"

wget -O strt "https://raw.githubusercontent.com/osjekwknwjsk/awikwok/main/strt.sh"

wget -O limit-speed "https://raw.githubusercontent.com/osjekwknwjsk/awikwok/main/limit-speed.sh"

chmod +x autobackup

chmod +x backup

chmod +x bckp

chmod +x restore

chmod +x strt

chmod +x limit-speed

chmod +x /root/.config/rclone/rclone.conf

cd

rm -f /root/set-br.sh

