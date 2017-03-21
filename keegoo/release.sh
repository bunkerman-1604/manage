#!/bin/bash
. /etc/profile
. /root/.bashrc
. /root/.bash_profile

PROJECT_DIR=/projects
PROJECT_NAME=(`echo $1 | tr -s '=' ' '`)
PROJECT_VERSION=$2
GIT_PROJECT_PATH=https://zentao%40keegoo.com:deploy123+-@git.oschina.net/mamashenghuo/keegoo-niux.git/

if [ ! -d ${PROJECT_DIR}/keegoo-niux ];then
	echo 
	echo 
	echo "===>Step 0 git clone branche  ${PROJECT_VERSION}<==="
	echo 
	echo 
	cd ${PROJECT_DIR}
	echo "${PROJECT_DIR} git clone ${GIT_PROJECT_PATH}"
	git clone ${GIT_PROJECT_PATH}
fi
cd ${PROJECT_DIR}/keegoo-niux
echo 
echo 
echo "===>Step 1 git checkout branche to ${PROJECT_VERSION}<==="
echo 
echo 
git pull
if [ `git status | wc -l` -gt 5 ];then
	echo "some confict occur !"
	git status
	rm -rf ${PROJECT_DIR}/keegoo-niux/
	cd ${PROJECT_DIR}
	git clone ${GIT_PROJECT_PATH}
	cd ${PROJECT_DIR}/keegoo-niux
fi
git checkout ${PROJECT_VERSION}
echo 
echo 
echo "===>Step 2 git pull <==="
echo 
echo 
git pull
#if [ ${#PROJECT_NAME[@]} -eq 1 ];then
#	cd ${PROJECT_DIR}/keegoo-niux/${PROJECT_NAME}_build
#fi
echo 
echo 
echo "===>Step 3 mvn clean <==="
echo 
echo 
mvn clean
echo 
echo 
echo "===>Step 4 mvn package <==="
echo 
echo 
mvn package -Dmaven.test.skip=true
mkdir -p /WEB/docBase/
echo 
echo 
echo "===>Step 5 configurate project(s) <==="
echo 
echo 
for i in "${PROJECT_NAME[@]}";do
	PROJECT_PATH=$PROJECT_DIR/keegoo-niux/$i
	rm -rf /WEB/docBase/$i
	echo 
	echo 
	echo "====>ln -s" $PROJECT_PATH"/target/ROOT /WEB/docBase/"$i
	echo 
	echo 
	ln -s $PROJECT_PATH/target/ROOT /WEB/docBase/$i
done
/opt/keegoo_tool/lookcatalina.sh ALL restart
echo `date "+%Y-%m-%d %H:%M:%S"`": Last deploy ["$PROJECT_VERSION"]"
