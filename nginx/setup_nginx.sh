#!/bin/bash
docker run --name nginx \
-p 80:80 \
-v /root/docker/nginx/nginx.conf:/etc/nginx/nginx.conf \
-v /root/docker/nginx/conf.d/:/etc/nginx/conf.d/ \
-d nginx:stable 
