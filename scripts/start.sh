#!/bin/bash

# 进入脚本目录
cd $(dirname "$0")
# 回到上一层(项目目录)
cd ..

# 获取项目工作目录
dir=$(pwd)

# 创建日志目录
mkdir -p logs

docker run -d --rm --name=nginx -p 80:80 -p 443:443 \
  -v ${dir}/conf/nginx.conf:/usr/local/openresty/nginx/conf/nginx.conf \
  -v ${dir}/vhost:/usr/local/openresty/nginx/vhost \
  -v ${dir}/logs:/usr/local/openresty/nginx/logs \
  -v ${dir}/html:/usr/local/openresty/nginx/html \
  -v ${dir}/lua:/data/works/lua \
  openresty/openresty:alpine