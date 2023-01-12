#!/bin/bash

if [ $# != 2 ]
then
    echo "Usage: createuser.sh [user_name] [uid]"
    exit 1
fi

UserName="$1"
Uid="$2"

addgroup --system $UserName
adduser --system --home /opt/dockerdata/$UserName --uid $Uid --shell /bin/bash --ingroup $UserName $UserName
echo "$UserName:$UserName" | chpasswd
usermod -aG sudo $UserName

# github
echo "140.82.112.3"$'\t'"github.com" \
     $'\n'"140.82.113.3"$'\t'"github.com" \
     $'\n'"140.82.114.5"$'\t'"api.github.com" \
     $'\n'"185.199.108.153"$'\t'"github.io" \
     $'\n'"199.232.69.194"$'\t'"github.global.ssl.fastly.net" \
     $'\n'"185.199.108.133"$'\t'"raw.github.com" \
     $'\n'"185.199.108.133"$'\t'"raw.githubusercontent.com" \
     $'\n'"185.199.109.133"$'\t'"raw.githubusercontent.com" \
     $'\n'"185.199.110.133"$'\t'"raw.githubusercontent.com" \
     $'\n'"185.199.111.133"$'\t'"raw.githubusercontent.com" \
     $'\n'"2606:50c0:8000::154"$'\t'"raw.githubusercontent.com" \
     $'\n'"2606:50c0:8001::154"$'\t'"raw.githubusercontent.com" \
     $'\n'"2606:50c0:8002::154"$'\t'"raw.githubusercontent.com" \
     $'\n'"2606:50c0:8003::154"$'\t'"raw.githubusercontent.com" \
     $'\n'"185.199.108.153"$'\t'"assets-cdn.github.com" \
     $'\n'"185.199.109.153"$'\t'"assets-cdn.github.com" \
     $'\n'"185.199.110.153"$'\t'"assets-cdn.github.com" \
     $'\n'"185.199.111.153"$'\t'"assets-cdn.github.com" \
     $'\n'"2606:50c0:8000::153"$'\t'"assets-cdn.github.com" \
     $'\n'"2606:50c0:8001::153"$'\t'"assets-cdn.github.com" \
     $'\n'"2606:50c0:8002::153"$'\t'"assets-cdn.github.com" \
     $'\n'"2606:50c0:8003::153"$'\t'"assets-cdn.github.com" \
     >> /etc/hosts