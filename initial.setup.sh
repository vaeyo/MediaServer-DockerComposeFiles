#!/bin/bash

read -p "Your username? This if for ownership and permissions of containers: " uname
read -p "Enter email address for SSL cerificates and Press [Enter]: " emails

uid=$(id -u $uname)
gid=$(id -g $uname)
tz="$(cat /etc/timezone)"

echo "We need your domain root for the SSL certs" 
echo "i.e example.com or mysite.com, avoid www.example.com or https:// etc.."
read -p "Enter the domain youd like to secure and press [Enter]: " domain

# Make the edits
----------------
# UID
sudo find . -type f -name "*.env" -exec sed -i "s/-uid-/"$uid"/g" '{}' \;
# GID
sudo find . -type f -name "*.env" -exec sed -i "s/-gid-/"$gid"/g" '{}' \;
# TZ
sudo find . -type f -name "*.env" -exec sed -i "s/-tz-/"$tz"/g" '{}' \;
# Email
sudo find . -type f -exec sed -i "s/-email-/"$emails"/g" '{}' \;
# domain
sudo find . -type f -exec sed -i "s/-domain-/"$domain"/g" '{}' \;

