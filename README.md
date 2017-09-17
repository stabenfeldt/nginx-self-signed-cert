```
git clone git@github.com:stabenfeldt/nginx-self-signed-cert.git
cd nginx-self-signed-cert

docker build  . -t  stabenfeldt/nginx-self-signed-cert:latest
docker run  -d -p 80:80 -p 443:443 stabenfeldt/nginx-self-signed-cert:latest

$ docker ps | grep nginx-self-signed-cert
=> e8e0ab3ea7c8        stabenfeldt/nginx-self-signed-cert:latest   "nginx -g 'daemon ..."   10 minutes ago      Up 10 minutes       0.0.0.0:80->80/tcp, 0.0.0.0:443->443/tcp   priceless_lewin

$ docker exec -it e8e sh
 /var/www/sst # netstat -nepa | grep LIST
 tcp        0      0 0.0.0.0:80              0.0.0.0:*               LISTEN      1/nginx: master pro
```
