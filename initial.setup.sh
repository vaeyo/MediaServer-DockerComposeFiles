#!/bin/bash

read -p "Name of User to to run docker containers under: " uname

uid=$(id -u $uname)
gid=$(id -g $uname)
tz="$(cat /etc/timezone)"

# Letsencrypt Cert Email
read -p "Enter email youd like associated with this server then [Enter]: " emails

# Domain we want certs for
echo "The next question is about your domain "
echo "Please enter the root address of the domain you own"
echo "i.e., example.com, mysite.net. Avoid the www http://"
read -p "Okay now lets enter the domain and press [Enter]: " domain

# Make the edits
----------------
# UID
sudo find . -type f -exec sed -i "s/-uid-/"$uid"/g" '{}' \;
# GID
sudo find . -type f -exec sed -i "s/-gid-/"$gid"/g" '{}' \;
# TZ
sudo find . -type f -exec sed -i "s/-tz-/"$tz"/g" '{}' \;
# Email
sudo find . -type f -exec sed -i "s/-email-/"$emails"/g" '{}' \;
# domain
sudo find . -type f -exec sed -i "s/-domain-/"$domain"/g" '{}' \;

