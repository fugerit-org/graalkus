# How to create this docker image

Login to RedHat registry

```shell
docker login registry.redhat.io/rhel8/httpd-24:latest
```

Dump configuration file 

```shell
docker run --rm --entrypoint=cat registry.redhat.io/rhel8/httpd-24:latest /etc/httpd/conf/httpd.conf > httpd.conf 
```

