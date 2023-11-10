@echo off
setlocal

@REM 获取脚本文件所在的目录地址
set "scriptDir=%~dp0"

@REM 进入项目跟目录
cd %scriptDir%
cd ..

@REM 获取项目工作目录
set "dir=%CD%"

REM 创建日志目录
set "logs=%dir%\logs"

if not exist "%logs%" (
  mkdir "%logs%"
)

@REM 执行 docker 命令
docker run -d --rm --name=nginx -p 80:80 -p 443:443 ^
  -v %dir%/conf/nginx.conf:/usr/local/openresty/nginx/conf/nginx.conf ^
  -v %dir%/vhost:/usr/local/openresty/nginx/vhost ^
  -v %dir%/logs:/usr/local/openresty/nginx/logs ^
  -v %dir%/html:/usr/local/openresty/nginx/html ^
  -v %dir%/lua:/data/works/lua ^
  openresty/openresty:alpine

endlocal
