#! /usr/bin/env bash

# cat /etc/security/pwquality.conf
# cat /etc/login.defs

echo "[$USER@$HOSTNAME $PWD]# head -n 2 /etc/os-release"
head -n 2 /etc/os-release
echo ""

echo "[$USER@$HOSTNAME $PWD]# sestatus"
sestatus
echo ""

echo "[$USER@$HOSTNAME $PWD]# ss -tunlp"
ss -tunlp
echo ""

echo "[$USER@$HOSTNAME $PWD]# ufw status"
ufw status
