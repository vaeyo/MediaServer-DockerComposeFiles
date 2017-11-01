#!/bin/bash

#check for root
if [[ $EUID -ne 0 ]]; then
   else
   echo "This script should not be run as root"
   echo "Please restart the script from your non-root user"
fi

# Testing for Internet Connection
if ping -q -c 1 -W 1 google.com >/dev/null; then
  echo "The network is up"
else
  echo "The network is down"
  echo "Please restart when service returns"
fi

uid=$(id -u)
gid=$(id -g)
tz="$(cat /etc/timezone)"

read -p "Enter email youd like associated with this server then [Enter]: " emails

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

