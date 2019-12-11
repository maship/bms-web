#!/bin/bash

command -v git >/dev/null 2>&1 || { echo >&2 -e "\033[31m[ERROR] required git but it's not installed. To: https://git-scm.com/ \033[0m"; exit 1; }
command -v docker >/dev/null 2>&1 || { echo >&2 -e "\033[31m[ERROR] required docker but it's not installed. To: https://www.docker.com/ \033[0m"; exit 1; }
command -v npm >/dev/null 2>&1 || { echo >&2 -e "\033[31m[ERROR] required npm but it's not installed. To: https://www.npmjs.com/ \033[0m"; exit 1; }

# 项目名
serviceName=bms-web

# docker仓库地址
harbor="docker.io/maship"
echo -e "\033[32m----- build $serviceName start -----\033[0m"

gid=$(git rev-parse --short=7  HEAD)
echo -e "short commit id: $gid"

echo -e "\033[32m----- start npm build -----\033[0m"
npm install
npm run build || { echo -e "\033[31m[ERROR] run [npm run build] faild, exit \033[0m"; exit 1; }
mkdir docker/apps
cp -R dist/* docker/apps

# docker 构建镜像
cd docker
echo -e "\033[32m----- building image[$harbor/$serviceName:$gid] ... -----\033[0m"
docker build -t $harbor/$serviceName:$gid .

rm -rf apps

echo -e "\033[32m----- build image[$harbor/$serviceName:$gid] successful -----\033[0m"
