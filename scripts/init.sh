#!/bin/bash

"""
sudo apt-get update -y
sudo apt install -y git
git clone https://github.com/ks6088ts/djangosite.git
"""

DOMAIN="www.ks6088ts.work"

# python3.6
sudo apt-get update -y
sudo apt-get install -y software-properties-common
sudo add-apt-repository -y ppa:jonathonf/python-3.6
sudo apt-get update -y
sudo apt-get install -y python3.6 python3.6-dev python3-pip

# modules
sudo apt install -y emacs24 make curl nginx

# certbot
sudo add-apt-repository -y ppa:certbot/certbot
sudo apt-get update -y
sudo apt-get install -y python-certbot-nginx
sudo mkdir -p /var/www/letsencrypt
sudo chown ubuntu:root /var/www/letsencrypt
"""
sudo certbot certonly --webroot -w /var/www/letsencrypt -d ${DOMAIN} # SSL/TLS 証明書を生成
sudo ls -al /etc/letsencrypt/live/${DOMAIN} # 確認
"""

# setup repos
export PIPENV_VENV_IN_PROJECT=true
make init
emacs .env
emacs Makefile # change settings if needed
make django

# -----
# for debug
# sudo ufw allow 8080
# make server
# -----

# production environment
sudo ufw allow 80
sudo cp deployments/systemd/* /etc/systemd/system/
sudo systemctl enable djangosite.socket
sudo systemctl enable djangosite.service
sudo systemctl start djangosite.socket
sudo systemctl start djangosite.service
sudo systemctl status djangosite.service
sudo systemctl status djangosite.socket

# nginx
sudo cp deployments/nginx/* /etc/nginx/sites-available/
sudo ln -s /etc/nginx/sites-available/djangosite.1 /etc/nginx/sites-enabled/
sudo unlink /etc/nginx/sites-enabled/default
sudo nginx -t # syntax check
sudo systemctl reload nginx
