# How to create this docker image

Login to RedHat registry

```shell
docker login registry.redhat.io/rhel8/httpd-24:latest
```

Dump configuration file 

```shell
docker run --rm --entrypoint=cat registry.redhat.io/rhel8/httpd-24:latest /etc/httpd/conf/httpd.conf > httpd.conf 
```

Build

```shell
docker build -t fugeritorg/graalkus:api-mixed-httpd .
```

Test

```shell
docker run --rm -p 8080:8080 --name graalkus-api-mixed-httpd fugeritorg/graalkus:api-mixed-httpd
```

Push

```shell
docker push fugeritorg/graalkus:api-mixed-httpd
```

