## さくら VPS 上での操作

Ubuntu 16.04 イメージを DockerCompose のスタートアップスクリプト付きで作成。  

ローカル PC から VPS に接続。
```
ssh ubuntu@IP_ADDRESS
```

ツール群をインストール
```
$ sudo apt install -y emacs24 ufw
```

リポジトリを clone
```
$ sudo git clone https://github.com/ks6088ts/djangosite.git /home/ubuntu/djangosite
```

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