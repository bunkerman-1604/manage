#!/bin/bash
#			 o0oo_
#                      o8888888o
#                      88" . "88
#                      (| -_- |)
#                      0\  =  /0
#                    ___/`---'\___
#                  .' \\|     |# '.
#                 / \\|||  :  |||# \
#                / _||||| -:- |||||- \
#               |   | \\\  -  #/ |   |
#               | \_|  ''\---/''  |_/ |
#               \  .-\__  '-'  ___/-. /
#             ___'. .'  /--.--\  `. .'___
#          ."" '<  `.___\_<|>_/___.' >' "".
#         | | :  `- \`.;`\ _ /`;.`/ - ` : | |
#         \  \ `_.   \_ __\ /__ _/   .-` /  /
#     =====`-.____`.___ \_____/___.-`___.-'=====
#                       `=---='
#
#
#     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
#               佛祖保佑         永无BUG
#
#
#
#. /root/.bash_rc

RELEASE_PROJECT_PATH=/opt
PROJECT_DIR=/projects/keegoo/codes
PROJECT_NAME=""
SERVER_PATH_AND_PREFIX=/opt/tomcat-
timep=`date -d today +"%Y-%m-%d_%H:%M:%S"`
echo "${timep} /root/keegoo_tool/lookcatalina.sh $1 $2 $3 $4" >> /root/keegoo_tool/jk.log

if [ $# -eq 0 ];then
	echo "-----------------------------------------------------------"
	
	echo "====>Select you release project name :"
	
	select PROJECT_NAME in "keegooMerchantPlatform" "keegooBackend" "keegooSellerPlatform" "KeegooUService_new" "KeegooSearch" "Cancel" ; do
	  break;
	done
	
	if [ $PROJECT_NAME = 'Cancel' ]; then
	    echo
	    echo '====>Cancel deploy this time, bye!--'
	    echo
	    exit
	fi
	select PROJECT_OPERATION in "restart" "release" "debug" "tail" ; do
	  break;
	done
else
	PROJECT_NAME=$1
	PROJECT_OPERATION=$2
fi
if [ $PROJECT_OPERATION = "restart" ];then
	if [ $1 == 'solr' ];then
		/opt/tomcat-solr/bin/shutdown.sh
		echo "rm -rf /opt/solr/home/data/*"
		rm -rf /opt/solr/home/data/*
		echo "rm -rf /opt/tomcat-solr/logs/*"
		rm -rf /opt/tomcat-solr/logs/*
		/opt/tomcat-solr/bin/startup.sh
	elif [ $1 == 'wxH5' ];then
		${SERVER_PATH_AND_PREFIX}${PROJECT_NAME}/bin/shutdown.sh
		rm -rf ${SERVER_PATH_AND_PREFIX}${PROJECT_NAME}/logs/*
        	${SERVER_PATH_AND_PREFIX}${PROJECT_NAME}/bin/startup.sh
	else
        	${SERVER_PATH_AND_PREFIX}${PROJECT_NAME}/bin/shutdown.sh
		rm -rf ${SERVER_PATH_AND_PREFIX}${PROJECT_NAME}/logs/*
		/root/keegoo_tool/conf.sh ${PROJECT_DIR}/${PROJECT_NAME}/target/ROOT/WEB-INF/classes/application.properties
        	${SERVER_PATH_AND_PREFIX}${PROJECT_NAME}/bin/startup.sh
	fi
elif [ $PROJECT_OPERATION = "debug" ];then 
	#${SERVER_PATH_AND_PREFIX}${PROJECT_NAME}/bin/shutdown.sh
	#echo "${SERVER_PATH_AND_PREFIX}${PROJECT_NAME}/bin/catalina.sh jpda start"
	#${SERVER_PATH_AND_PREFIX}${PROJECT_NAME}/bin/catalina.sh jpda start
	${SERVER_PATH_AND_PREFIX}${PROJECT_NAME}/bin/shutdown.sh
	rm -rf ${SERVER_PATH_AND_PREFIX}${PROJECT_NAME}/logs/*
	sed  -i "s|INFO|DEBUG|g" ${PROJECT_DIR}/${PROJECT_NAME}/target/ROOT/WEB-INF/classes/log4j.properties
        ${SERVER_PATH_AND_PREFIX}${PROJECT_NAME}/bin/catalina.sh jpda start
elif [ $PROJECT_OPERATION = "tail" ];then
	tail -f ${SERVER_PATH_AND_PREFIX}${PROJECT_NAME}/logs/catalina.out 
elif [ $PROJECT_OPERATION = "release" ];then
	if [ $# -eq 4 ];then
		rm -rf ${SERVER_PATH_AND_PREFIX}${PROJECT_NAME}/logs/*
		/root/keegoo_tool/release.sh $1 $3 $4
	else
		echo "parameter number less than 4,need more parameters!"
	fi
fi

