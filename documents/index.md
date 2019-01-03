```
$ docker build \
    -f docker/python3.6/Dockerfile \
    --no-cache \
    --tag djangosite:1.0 .
```


```
$ docker run -it \
    --name sample \
    -p 8080:8080 \
    djangosite:1.0 \
    /bin/bash
```

```
$ make admin
$ make server
```
