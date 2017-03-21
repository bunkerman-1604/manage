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

PROJECT_DIR=/projects
SERVER_PATH_AND_PREFIX=/opt/tomcat-
timep=`date -d today +"%Y-%m-%d_%H:%M:%S"`

PROJECT_NAME=(`echo $1 | tr -s '=' ' '`)
PROJECT_OPERATION=$2
if [ $PROJECT_OPERATION = "restart" ];then
	tmp=(`ls /opt/ | grep '^tomcat'`)
	for i in "${tmp[@]}";do
	        PROJECT_PATH=$PROJECT_DIR/keegoo-niux/${i#*-}
	        echo
	        echo
	        echo "conf.sh $PROJECT_PATH/target/ROOT/WEB-INF/classes/application.properties"
	        echo
	        echo
	        /opt/keegoo_tool/conf.sh $PROJECT_PATH/target/ROOT/WEB-INF/classes/application.properties
	        proc=(`ps -ef | grep /opt/$i/ | grep -v grep | awk '{print $2}' `)
		for j in "${proc[@]}";do
			echo "kill ${i}_${j}";
			echo "$j" | sed -e "s/^/kill -9 /g" | sh -
		done
	        if [ `cat /opt/keegoo_tool/conf.sh | grep =product | wc -l` -eq 0 ];then
	                echo
	                echo
	                echo "===>remove ${i} log data<==="
	                echo
	                echo
	                rm -rf /opt/$i/logs/*
	        else
	                tmp1=`date "+%Y-%m-%d %H:%M:%S"`
	                mkdir /opt/keegoo_tool/${tmp1}_${i}
	                mv /opt/$i/logs/* /opt/keegoo_tool/${tmp1}_${i}
	        fi
	        echo "################ Begin restart $i Tomcat Server #####################"
	        echo
	        echo
	        /opt/$i/bin/catalina.sh start
	done

	if [ ${#PROJECT_NAME[@]} -gt 1 ];then
		if [ `ls /opt | grep tomcat-solr | wc -l` -gt 0 ];then
			/opt/tomcat-solr/bin/shutdown.sh
			echo "rm -rf /opt/solr/home/data/*"
			rm -rf /opt/solr/home/data/*
			echo "rm -rf /opt/tomcat-solr/logs/*"
			rm -rf /opt/tomcat-solr/logs/*
			/opt/tomcat-solr/bin/startup.sh
		fi
	fi
elif [ $PROJECT_OPERATION = "debug" ];then 
	echo "[Here Is A Joker ]Not Finish debug Coding !"
	#${SERVER_PATH_AND_PREFIX}${PROJECT_NAME}/bin/shutdown.sh
	#echo "${SERVER_PATH_AND_PREFIX}${PROJECT_NAME}/bin/catalina.sh jpda start"
	#${SERVER_PATH_AND_PREFIX}${PROJECT_NAME}/bin/catalina.sh jpda start
	#${SERVER_PATH_AND_PREFIX}${PROJECT_NAME}/bin/shutdown.sh
	#rm -rf ${SERVER_PATH_AND_PREFIX}${PROJECT_NAME}/logs/*
	#sed  -i "s|INFO|DEBUG|g" ${PROJECT_DIR}/${PROJECT_NAME}/target/ROOT/WEB-INF/classes/log4j.properties
        #${SERVER_PATH_AND_PREFIX}${PROJECT_NAME}/bin/startup.sh
elif [ $PROJECT_OPERATION = "release" ];then
	if [ $# -eq 3 ];then
		/opt/keegoo_tool/release.sh $1 $3
	else
		echo "parameter number less than 3,need more parameters!"
	fi
fi
