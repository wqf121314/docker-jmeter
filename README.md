# Introduction
This is a docker container project based on the ubuntu:22.04 version for deploying a Jmeter(5.6.2) agent server

# Simple command
## Creating a docker image
```
docker build -t docker-jmeter .
```
## Creating containers via img
```
docker run -e SERVER_PORT={port} -e SERVER_RMI_LOCALPORT={localport} -e SERVER_HOSTNAME={hostname} -p${port}:${port} -p{localport}:{localport} -d docker-jmeter:latest server

EXAMPLE: 
docker run -e SERVER_PORT=1100 -e SERVER_RMI_LOCALPORT=5100 -e SERVER_HOSTNAME=localhost -p1100:1100 -p5100:5100 -d docker-jmeter:latest server
```
## Execute distributed tests
```
./Tools/apache-jmeter-5.6.2/bin/jmeter -n -t ./cases/test.jmx -R localhost:1100 -Jserver.rmi.ssl.disable=true -l ./cases/report/result.csv -j ./cases/report/log.log

```