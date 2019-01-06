## さくら VPS 上での操作

Ubuntu 16.04 イメージを ufw スタートアップスクリプト付きで作成。  

ローカル PC から VPS に接続。
```
ssh ubuntu@IP_ADDRESS
```

ツール群をインストール
```
$ sudo apt install -y emacs24 make git curl nginx
```

Python 3.6 をインストール
```
sudo apt-get update -y
sudo apt-get install -y software-properties-common
sudo add-apt-repository ppa:jonathonf/python-3.6
sudo apt-get update -y
sudo apt-get install -y python3.6 python3.6-dev python3-pip
```

リポジトリのセットアップ
```
$ git clone https://github.com/ks6088ts/djangosite.git 
$ export PIPENV_VENV_IN_PROJECT=true
$ make init
$ emacs .env
$ mkdir static
$ make django
$ sudo ufw allow 8080
$ make server
```

## Docker 
Docker を利用する場合、DockerCompose スタートアップスクリプトを利用すると Docker が初期状態から利用できて便利。  
以下、Docker 上に Django アプリケーションを gunicorn でサービスする手順。  

環境設定ファイルを djangosite/.env に追加。

```
EMAIL_PORT=<type your parameter>
EMAIL_HOST=<type your parameter>
EMAIL_HOST_USER=<type your parameter>
EMAIL_HOST_PASSWORD=<type your parameter>
EMAIL_USE_TLS=<type your parameter>
DEFAULT_FROM_EMAIL=<type your parameter>
```

Docker イメージをビルド

```
$ docker build \
    -f docker/python3.6/Dockerfile \
    --no-cache \
    --tag djangosite:1.0 .
```

コンテナ起動

```
$ docker run -it \
    --name sample \
    -p 8080:8080 \
    djangosite:1.0 \
    /bin/bash
```

コンテナ内で操作

```
$ cd /djangosite
$ make admin
$ make server
```

これは debug 設定時の動作確認用の作業。
```
rm -rf static && mv static_root static
mkdir media
```

## ufw

```
$ sudo ufw allow 80
```

## systemd/nginx

Systemd
```
# copy .socket and .service files
$ sudo cp deployments/systemd/* /etc/systemd/system/
$ sudo systemctl enable djangosite.socket
$ sudo systemctl enable djangosite.service

$ sudo systemctl start djangosite.socket
$ sudo systemctl start djangosite.service
$ sudo systemctl status  djangosite.service
$ sudo systemctl status  djangosite.socket
```

Nginx
```
$ sudo cp deployments/nginx/djangosite /etc/nginx/sites-available/
$ sudo ln -s /etc/nginx/sites-available/djangosite /etc/nginx/sites-enabled/
$ sudo unlink /etc/nginx/sites-enabled/default
$ sudo nginx -t # syntax check
$ sudo systemctl reload nginx
```


## https 対応

```
$ sudo mkdir -p /var/www/letsencrypt
$ sudo chown ubuntu:root /var/www/letsencrypt

# ref. https://www.digitalocean.com/community/tutorials/how-to-secure-nginx-with-let-s-encrypt-on-ubuntu-16-04
$ sudo add-apt-repository ppa:certbot/certbot
$ sudo apt-get update -y
$ sudo apt-get install python-certbot-nginx
$ sudo apt-get -y install certbot

# Note: nginx に acme-challenge へのアクセス許可ルールを事前に追加する
$ sudo certbot certonly --webroot -w /var/www/letsencrypt -d www.ks6088ts.work # SSL/TLS 証明書を生成
$ sudo ls -al /etc/letsencrypt/live/www.ks6088ts.work # 確認
```

## SSL/TLS 証明書の更新

念の為、以下のコマンドで証明書が更新されることを確認してみる。
```
$ sudo /usr/bin/certbot renew --force-renew
```

スーパーユーザ権限で cron で証明書の更新を定期実行するように設定する。

```
$ sudo crontab -e
```

して以下のタスクを追加。

```
00 00 1 * * /usr/bin/certbot renew -q --renew-hook "/bin/systemctl reload nginx"
```


## Tips

```
$ docker rm `docker ps -aq`
```

### データベース関連

#### バックアップ

データベースを json 出力する
```
source venv/bin/activate
python manage.py dumpdata products --format=json --indent=2 > products.json
```

scp でデータベースの json 出力と media ファイルをダウンロード
```
scp user@ip_addr:/home/django-site/project/products.json /path/to/local
scp -r user@ip_addr:/home/django-site/project/media /path/to/local
```

#### リストア

```
# データベースを生成
pipenv run python manage.py loaddata products --settings config.settings.production

# media ファイルを配置
scp -r ~/Downloads/media/ user@ip_addr:/home/ubuntu/djangosite/www/djangosite
```
