#!/bin/sh
VERSION="$(curl -fsSLI -o /dev/null -w "%{url_effective}" https://github.com/XTLS/Xray-core/releases/latest)"
VERSION="${VERSION#https://github.com/XTLS/Xray-core/releases/tag/v}"
UUID="$(cat /proc/sys/kernel/random/uuid)"

printf "========== Xray %s ==========\n" ${VERSION}
printf "UUID: %s\n" ${UUID}
printf "========== %s ==========\n" $(date "+%Y-%m-%d")

cat > config.json << EOF
{
    "inbounds": [
        {
            "port": ${PORT},
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "id": "${UUID}"
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "ws"
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom"
        }
    ]
}
EOF

xray -config config.json
