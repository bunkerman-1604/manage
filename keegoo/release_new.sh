#!/bin/bash
#1-项目名称
#2-项目版本
#3-强制更新

RELEASE_PROJECT_PATH=/opt
PROJECT_NAME=$1
PROJECT_VERSION=$2
PROJECT_DIR=/projects/keegoo/codes/$PROJECT_VERSION
SERVER_PATH_AND_PREFIX=/opt/tomcat-
PROJECT_BUILD_NAME=ROOT
GIT_PROJECT_PATH=https://TaoMingkai:keegoo%40test@git.coding.net/keegoo/$PROJECT_NAME.git
PROJECT_PATH=$PROJECT_DIR/$PROJECT_NAME
IMAGE="tomcat:7.0-jre7"
if [ $PROJECT_NAME == 'keegooBackend' ];then
	INDEX=10081
elif [ $PROJECT_NAME == 'keegooMerchantPlatform' ];then
	INDEX=10082
elif [ $PROJECT_NAME == 'keegooSellerPlatform' ];then
	INDEX=10085
elif [ $PROJECT_NAME == 'wxH5' ];then
	INDEX=4
elif [ $PROJECT_NAME == 'KeegooDService' ];then
	INDEX=10088
elif [ $PROJECT_NAME == 'KeegooSearch' ];then
	INDEX=10083
elif [ $PROJECT_NAME == 'KeegooUService_new' ];then
	INDEX=10086
fi

echo "====>begin deploy:"$PROJECT_NAME" version:"$PROJECT_VERSION
echo "########### Begin clone or checkout codes ############"
mkdir -p $PROJECT_DIR
cd $PROJECT_DIR
echo "cd $PROJECT_DIR"
echo "====>come in "$PROJECT_DIR
echo "====> rm -rf "$PROJECT_NAME
rm -rf $PROJECT_NAME
echo "====> begin clone tag"
git clone --branch $PROJECT_VERSION $GIT_PROJECT_PATH
echo "====> finished clone tag"
cd $PROJECT_PATH
echo "cd $PROJECT_PATH"
echo
echo "########## clone or checkout codes finished ###############"
echo
echo "################# Begin build project ######################" 
echo
echo "build "$PROJECT_NAME
echo
mvn clean
echo "====>mvn clean success finish!"
if [ "$3" = "-U" ]; then
    echo '====> Force to update maven jar files'
    mvn -U  package -Dmaven.test.skip=true 
else
    echo '====> Just update project codes'
    mvn package -Dmaven.test.skip=true 
fi
echo
echo "################# Build project finished ###################" 
echo
echo
echo "############## Begin override properties files ################"
echo
/root/keegoo_tool/conf.sh $PROJECT_PATH/target/$PROJECT_BUILD_NAME/WEB-INF/classes/application.properties
echo
echo "############## Override properties files finished #############"
echo
echo "Last deploy ["$PROJECT_NAME":"$PROJECT_VERSION"]"`date "+%Y-%m-%d %H:%M:%S"`
echo `date "+%Y-%m-%d %H:%M:%S"`": Last deploy ["$PROJECT_NAME":"$PROJECT_VERSION"]" >> /logs/versions.log
echo
echo "################ Begin restart Tomcat Server #####################"
if [ `docker ps -a | grep $PROJECT_VERSION$PROJECT_NAME | wc -l` -eq 0 ] ;then
	#tmp=${PROJECT_VERSION%.*}
	tmp=(`docker ps -a | grep $PROJECT_NAME`)
	docker stop ${tmp[0]}
	docker rm -v ${tmp[0]}
	docker run --name $PROJECT_VERSION$PROJECT_NAME -itd \
	-v $PROJECT_PATH/target/$PROJECT_BUILD_NAME:/usr/local/tomcat/webapps/ROOT \
	-p ${INDEX}:8080 ${IMAGE}
else
	tmp=(`docker ps -a | grep $PROJECT_VERSION$PROJECT_NAME`)
	echo "restart docker ${tmp[11]}!"
	docker stop ${tmp[0]}
	docker start ${tmp[0]}
fi
echo echo "################ Restart Tomcat Server finished ##################"
echo
echo
echo "########################## finish deploy #########################"
exit
