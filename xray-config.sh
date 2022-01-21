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
domain=$( cat /etc/v2ray/domain )
uuid=$(cat /proc/sys/kernel/random/uuid)
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
                            "certificateFile": "/etc/v2ray/v2ray.crt", // replace with your certificate, absolute path
                            "keyFile": "/etc/v2ray/v2ray.key" // Replace with your private key, absolute path
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
                        "id": "", // 填写你的 UUID
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
