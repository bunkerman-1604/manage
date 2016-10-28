#!/bin/bash
. /etc/profile
. /root/.bashrc
. /root/.bash_profile

RELEASE_PROJECT_PATH=/opt
PROJECT_DIR=/projects/keegoo/codes
PROJECT_NAME=$1
PROJECT_VERSION=$2
SERVER_PATH_AND_PREFIX=/opt/tomcat-
PROJECT_BUILD_NAME=ROOT

		#https://git.coding.net/keegoo/keegooSellerPlatform.git
#GIT_PROJECT_PATH=https://git.coding.net/keegoo/$PROJECT_NAME.git
if [ $PROJECT_NAME == "wxh5" ];then
	#目前刘云的项目名称为app_index
	GIT_PROJECT_PATH=https://15600570022%40163.com:19901023liu@git.coding.net/yangrui_code/app_index.git
else
	GIT_PROJECT_PATH=https://TaoMingkai:keegoo%40test@git.coding.net/keegoo/$PROJECT_NAME.git
fi
RELEASE_PROJECT_NAME=$PROJECT_NAME
PROJECT_PATH=$PROJECT_DIR/$PROJECT_NAME

echo "====>begin deploy:"$RELEASE_PROJECT_NAME" version:"$PROJECT_VERSION

echo "########### Begin clone or checkout codes ############"
mkdir -p $PROJECT_DIR
cd $PROJECT_DIR
echo "====>come in "$PROJECT_DIR

echo "====> rm -rf "$PROJECT_NAME
rm -rf $PROJECT_NAME

echo "====> begin clone tag"
git clone --branch $PROJECT_VERSION $GIT_PROJECT_PATH
echo "====> finished clone tag"

cd $PROJECT_PATH

echo
echo
echo "########## clone or checkout codes finished ###############"
echo
echo

echo "################# Begin build project ######################" 
echo

if [ $PROJECT_NAME = "wxh5" ];then
	#目前刘云的项目名称为app_index
	rm -rf /opt/tomcat-wxh5/webapps/keegoo-h5/app_index
	mv /projects/keegoo/codes/app_index /opt/tomcat-wxh5/webapps/keegoo-h5/app_index/
else
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
	
	
	echo 
	echo "################# Begin create link to docBase ###################"
	echo
	
	echo "====>ln -s"$PROJECT_PATH"/target/"$PROJECT_BUILD_NAME" /WEB/docBase/"$PROJECT_NAME
	mkdir -p /WEB/docBase/
	rm -rf /WEB/docBase/$PROJECT_NAME
	ln -s $PROJECT_PATH/target/$PROJECT_BUILD_NAME /WEB/docBase/$PROJECT_NAME
	
	echo
	echo "################ Create link to docBase finished #################"
	
fi
touch /logs/versions.log
echo "Last deploy ["$PROJECT_NAME":"$PROJECT_VERSION"]"
echo `date "+%Y-%m-%d %H:%M:%S"`": Last deploy ["$PROJECT_NAME":"$PROJECT_VERSION"]" >> /logs/versions.log

echo
echo "################ Begin restart Tomcat Server #####################"
echo
echo "====> begin shutdown"
#/opt/tomcat-$PROJECT_NAME/bin/shutdown.sh
ps -ef | grep $SERVER_PATH_AND_PREFIX$PROJECT_NAME/ | grep -v grep | awk '{print $2}' | sed -e "s/^/kill -9 /g" | sh -
echo "====> shutdown finished"

echo
echo "====> begin start server"
$SERVER_PATH_AND_PREFIX$PROJECT_NAME/bin/catalina.sh start
echo "====> start server finished"

echo
echo "################ Restart Tomcat Server finished ##################"
echo
echo
echo "########################## finish deploy #########################"
exit
