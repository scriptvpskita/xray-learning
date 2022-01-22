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

# update tools
apt update -y
apt upgrade -y

# added directory
mkdir -p /etc/xray/
touch /etc/xray/domain
touch /etc/v2ray/domain
mkdir -p /var/lib/premium-script/
touch /var/lib/premium-script/ipvps.conf
domain=$( cat /etc/xray/domain )
uuid=$(cat /proc/sys/kernel/random/uuid)

# added domain
read -rp "Domain/Host: " -e host
echo "start"
apt install -y socat
curl https://get.acme.sh | sh
alias acme.sh=~/.acme.sh/acme.sh
acme.sh --upgrade --auto-upgrade
acme.sh --set-default-ca --server letsencrypt
systemctl stop nginx
acme.sh --issue -d $host --standalone --keylength ec-384
acme.sh --install-cert -d $host --ecc
--fullchain-file /etc/ssl/private/fullchain.pem
--key-file /etc/ssl/private/privkey.pem
chown -R nobody:nogroup /etc/ssl/private/
echo $host > /etc/xray/domain
echo $host > /etc/v2ray/domain
echo "IP=$host" >> /var/lib/premium-script/ipvps.conf
sleep 0.5 
echo "Berhasil Added Domain"
sleep 2

# install nginx for debian 10/11 or ubuntu 18/20.04
clear
source /etc/os-release
OS=$ID
if [[ $OS == 'debian' ]]; then
apt install -y gnupg2 ca-certificates lsb-release debian-archive-keyring && curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor > /usr/share/keyrings/nginx-archive-keyring.gpg && printf "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] https://nginx.org/packages/mainline/debian `lsb_release -cs` nginx\n" > /etc/apt/sources.list.d/nginx.list && printf "Package: *\nPin: origin nginx.org\nPin: release o=nginx\nPin-Priority: 900\n" > /etc/apt/preferences.d/99nginx && apt update -y && apt install -y nginx && mkdir -p /etc/systemd/system/nginx.service.d && printf "[Service]\nExecStartPost=/bin/sleep 0.1\n" > /etc/systemd/system/nginx.service.d/override.conf
fi
if [[ $OS == 'ubuntu' ]]; then
apt install -y gnupg2 ca-certificates lsb-release ubuntu-keyring && curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor > /usr/share/keyrings/nginx-archive-keyring.gpg && printf "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] https://nginx.org/packages/mainline/ubuntu `lsb_release -cs` nginx\n" > /etc/apt/sources.list.d/nginx.list && printf "Package: *\nPin: origin nginx.org\nPin: release o=nginx\nPin-Priority: 900\n" > /etc/apt/preferences.d/99nginx && apt update -y && apt install -y nginx && mkdir -p /etc/systemd/system/nginx.service.d && printf "[Service]\nExecStartPost=/bin/sleep 0.1\n" > /etc/systemd/system/nginx.service.d/override.conf
fi

# install xray
bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install --version 1.5.2

# configurasi xray
cat > /usr/local/etc/xray/config.json << END 
{
    "log": {
        "loglevel": "warning"
    },
    "inbounds": [
        {
            "port": 443,
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "id": "$uuid", // fill in your UUID
                        "flow": "xtls-rprx-direct",
                        "level": 0,
                        "email": "user"
                    }
#vlessxtls
                ],
                "decryption": "none",
                "fallbacks": [
                    {
                        "dest": 1310, // fallback to Xray's Trojan protocol by default
                        "xver": 1
                    },
                    {
                        "path": "/websocket", // must be replaced with a custom PATH
                        "dest": 1234,
                        "xver": 1
                    },
                    {
                        "path": "/vmesstcp", // must be replaced with a custom PATH
                        "dest": 2345,
                        "xver": 1
                    },
                    {
                        "path": "/vmessws", // must be replaced with a custom PATH
                        "dest": 3456,
                        "xver": 1
                    }
                ]
            },
            "streamSettings": {
                "network": "tcp",
                "security": "xtls",
                "xtlsSettings": {
                    "alpn": [
                        "http/1.1"
                    ],
                    "certificates": [
                        {
                            "certificateFile": "/etc/ssl/private/fullchain.pem", // replace with your certificate, absolute path
                            "keyFile": "/etc/ssl/private/privkey.pem" // Replace with your private key, absolute path
                        }
                    ]
                }
            }
        },
        {
            "port": 1310,
            "listen": "127.0.0.1",
            "protocol": "trojan",
            "settings": {
                "clients": [
                    {
                        "password": "$uuid", // 填写你的密码
                        "level": 0,
                        "email": "user"
                    }
#trojantcp
                ],
                "fallbacks": [
                    {
                        "dest": 80 // or fall back to other proxies that are also anti-probe
                    }
                ]
            },
            "streamSettings": {
                "network": "tcp",
                "security": "none",
                "tcpSettings": {
                    "acceptProxyProtocol": true
                }
            }
        },
        {
            "port": 1234,
            "listen": "127.0.0.1",
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "id": "$uuid", // 填写你的 UUID
                        "level": 0,
                        "email": "user"
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "ws",
                "security": "none",
                "wsSettings": {
                    "acceptProxyProtocol": true, // Reminder: If you use Nginx/Caddy to reverse WS, you need to delete this line
                    "path": "/websocket" // Must be replaced with a custom PATH, which needs to be consistent with the shunting
                }
            }
        },
        {
            "port": 2345,
            "listen": "127.0.0.1",
            "protocol": "vmess",
            "settings": {
                "clients": [
                    {
                        "id": "$uuid", // 填写你的 UUID
                        "level": 0,
                        "email": "love@example.com"
                    }
                ]
            },
            "streamSettings": {
                "network": "tcp",
                "security": "none",
                "tcpSettings": {
                    "acceptProxyProtocol": true,
                    "header": {
                        "type": "http",
                        "request": {
                            "path": [
                                "/vmesstcp" // Must be replaced with a custom PATH, which needs to be consistent with the shunting
                            ]
                        }
                    }
                }
            }
        },
        {
            "port": 3456,
            "listen": "127.0.0.1",
            "protocol": "vmess",
            "settings": {
                "clients": [
                    {
                        "id": "$uuid", // 填写你的 UUID
                        "level": 0,
                        "email": "user"
                     }
#vmessws
                ]
            },
            "streamSettings": {
                "network": "ws",
                "security": "none",
                "wsSettings": {
                    "acceptProxyProtocol": true, // Reminder: If you use Nginx/Caddy to reverse WS, you need to delete this line
                    "path": "/vmessws" // Must be replaced with a custom PATH, which needs to be consistent with the diversion
                }
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom"
        }
    ]
}
END

systemctl restart xray


cd /usr/bin
wget -O add-vlessxtls "https://raw.githubusercontent.com/scriptvpskita/xray-learning/main/add-vlessxtls.sh"
wget -O add-vmess "https://raw.githubusercontent.com/scriptvpskita/xray-learning/main/add-vmess.sh"
wget -O add-trojan "https://raw.githubusercontent.com/scriptvpskita/xray-learning/main/add-trojan.sh"
wget -O clear-log "https://raw.githubusercontent.com/scriptvpskita/xray-learning/main/clear-log.sh"
wget -O monitor "https://raw.githubusercontent.com/scriptvpskita/xray-learning/main/monitor.sh"
chmod +x add-vlessxtls
chmod +x add-vmess
chmod +x add-trojan
chmod +x clear-log
chmod +x monitor
cd
echo "install sukses"
echo "reboot dalam 3 detik..."
sleep 3
reboot
