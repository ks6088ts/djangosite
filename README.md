# djangosite
Web application written in Django

[![travis-ci](https://api.travis-ci.org/ks6088ts/djangosite.svg?branch=master)](https://api.travis-ci.org/ks6088ts/djangosite.svg?branch=master)

# Setup environment on Sakura VPS

1. Install CentOS7 on Sakura VPS
1. Generate SSH keys (like $ ssh-keygen -t rsa)
1. Paste public key to GitHub settings
1. Clone the repo from VPS server on /home directory
1. Run setup scripts($ ./scripts/setup_sakura.sh)


# Backup databases

## Production

Dump the current database to a json file
* ./manage.py dumpdata products --format=json --indent=2 > products.json

* Check if media directory exists

## Local

Download json database file and media directory from remote production to local

* scp user@ip_addr:/path/to/products.json /path/to/local
* scp -r user@ip_addr:/path/to/media /path/to/local

Inject products database to local

* ./manage.py loaddata products
