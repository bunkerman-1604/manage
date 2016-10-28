#!/bin/bash
ap=$1
newbase=qa_a
sqlport=12306
newuser=kgdev
newpwd=^1DFf1a7B
myhost=10.171.35.204
myredis=10.44.62.240
redisport=12379
mysolr=10.44.155.32
confenv=qa-A
my_path="${myhost}:${sqlport}/${newbase}"
mysqlpath="jdbc:mysql://${my_path}?zautoReconnect=true&amp;characterEncoding=utf8"
echo $#
if [  $# -eq 9 ];then
	timep=`date -d today +"%Y-%m-%d_%H:%M:%S"`
	sed -i "/^newbase=/cnewbase=$1"	/root/keegoo_tool/conf.sh
	sed -i "/^sqlport=/csqlport=$2"	/root/keegoo_tool/conf.sh
	sed -i "/^newuser=/cnewuser=$3"	/root/keegoo_tool/conf.sh
	sed -i "/^newpwd=/cnewpwd=$4"	/root/keegoo_tool/conf.sh
	sed -i "/^myhost=/cmyhost=$5"	/root/keegoo_tool/conf.sh
	sed -i "/^myredis=/cmyredis=$6"	/root/keegoo_tool/conf.sh
	sed -i "/^redis/credisport=$7"	/root/keegoo_tool/conf.sh
	sed -i "/^mysolr=/cmysolr=$8"	/root/keegoo_tool/conf.sh
	sed -i "/^confenv=/cconfenv=$9"	/root/keegoo_tool/conf.sh
	echo "${timep} $1 $2 $3 $4 $5 $6 $7 $8 $9 " >> /root/keegoo_tool/jk.log
else
	sed  -i "/^connection.url/cconnection.url=${mysqlpath}"			${ap}
	sed  -i "/^connection.us/cconnection.username=${newuser}"		${ap}
	sed  -i "/^connection.pa/cconnection.password=${newpwd}"		${ap}
	sed  -i "/^jdbc.url/cjdbc.url=jdbc:mysql://${my_path}"			${ap}
	sed  -i "/^jdbc.us/cjdbc.username=${newuser}"				${ap}
	sed  -i "/^jdbc.pa/cjdbc.password=${newpwd}"				${ap}
	sed  -i "/^redis.host=/credis.host=${myredis}"				${ap}
	sed  -i "/^redis.ip=/credis.ip=${myredis}"				${ap}
	sed  -i "/^redis.port=/credis.port=${redisport}"			${ap}
	sed  -i "/^solrj.h/csolrj.host=http://${mysolr}:8080/solr"		${ap}
	sed  -i "/^solrUrl=/s/localhost:8888/${mysolr}:8080/"			${ap}
	sed  -i "s|=c:/|=/data/|g"						${ap}
	sed  -i "/^slave.jdbc.url/cslave.jdbc.url2=jdbc:mysql://${my_path}"	${ap}
	sed  -i "/^slave.jdbc.us/cslave.jdbc.username2=${newuser}"		${ap}
	sed  -i "/^slave.jdbc.pa/cslave.jdbc.password2=${newpwd}"		${ap}
	if [ ${confenv} == 'product' ];then
		delta=http://apph5.mamashenghuo.com/weixin61
		alpha=http://wxh5.mamashenghuo.com
		echo "product Env !"
		sed  -i "/^keegoo.p/ckeegoo.pay.callback.url=http://uservice.mamashenghuo.com"					${ap}
		sed  -i "/^keegoo.or/ckeegoo.order.mianze.url=${alpha}/mianzhe/index.html"				${ap}
		sed  -i "/^keegoo.share.play.url/ckeegoo.share.play.url=${delta}/html/details.html"				${ap}
		sed  -i "/^keegoo.share.edu.url/ckeegoo.share.edu.url=${delta}/html/details.html"				${ap}
		sed  -i "/^keegoo.share.playstore.url/ckeegoo.share.playstore.url=${delta}/html/shop.html"			${ap}
		sed  -i "/^keegoo.share.edustore.url/ckeegoo.share.edustore.url=${delta}/html/shop.html"			${ap}
		sed  -i "/^merchantQrUrl=/cmerchantQrUrl=http://crm.mamashenghuo.com/merchant/business/qrcode/"			${ap}
		sed  -i "/^merchantDetailUrl=/cmerchantDetailUrl=${alpha}/keegoo-h5/html/shop_play.html?storeId="		${ap}
		sed  -i "/^keegoo.weixin.h5.env=/ckeegoo.weixin.h5.env=online"							${ap}
		sed  -i "/^isdev/cisdev=false"											${ap}
		sed  -i "/^keegoo.h5.url=/ckeegoo.h5.url=${alpha}"							${ap}
	elif [ ${confenv} == 'develope' ] ; then
		delta=http://apph5.mamashenghuo.com/weixin61d
		alpha=http://d.wxh5.mamashenghuo.com
		echo "develope Env !"
		sed  -i "/^keegoo.p/ckeegoo.pay.callback.url=http://d.uservice.mamashenghuo.com"				${ap}
		sed  -i "/^keegoo.or/ckeegoo.order.mianze.url=${alpha}/mianzhe/index.html"				${ap}
		sed  -i "/^keegoo.share.play.url/ckeegoo.share.play.url=${delta}/html/details.html"				${ap}
		sed  -i "/^keegoo.share.edu.url/ckeegoo.share.edu.url=${delta}/html/details.html"				${ap}
		sed  -i "/^keegoo.share.playstore.url/ckeegoo.share.playstore.url=${delta}/html/shop.html"			${ap}
		sed  -i "/^keegoo.share.edustore.url/ckeegoo.share.edustore.url=${delta}/html/shop.html"			${ap}
		sed  -i "/^merchantQrUrl=/cmerchantQrUrl=http://d.crm.mamashenghuo.com/merchant/business/qrcode/"		${ap}
		sed  -i "/^merchantDetailUrl=/cmerchantDetailUrl=${alpha}/keegoo-h5/html/shop_play.html?storeId="		${ap}
		sed  -i "/^keegoo.weixin.h5.env=/ckeegoo.weixin.h5.env=develope"						${ap}
		sed  -i "/^isdev/cisdev=true"											${ap}
		sed  -i "/^keegoo.h5.url=/ckeegoo.h5.url=${alpha}"							${ap}
	elif [ ${confenv} == 'qa-A' ] ; then
		delta=http://apph5.mamashenghuo.com/qa_a
		alpha=http://t.wxh5.mamashenghuo.com
		echo "qa_A Env !"
		sed  -i "/^keegoo.p/ckeegoo.pay.callback.url=http://t.uservice.mamashenghuo.com"				${ap}
		sed  -i "/^keegoo.or/ckeegoo.order.mianze.url=${alpha}/mianzhe/index.html"				${ap}
		sed  -i "/^keegoo.share.play.url/ckeegoo.share.play.url=${delta}/html/details.html"				${ap}
		sed  -i "/^keegoo.share.edu.url/ckeegoo.share.edu.url=${delta}/html/details.html"				${ap}
		sed  -i "/^keegoo.share.playstore.url/ckeegoo.share.playstore.url=${delta}/html/shop.html"			${ap}
		sed  -i "/^keegoo.share.edustore.url/ckeegoo.share.edustore.url=${delta}/html/shop.html"			${ap}
		sed  -i "/^merchantQrUrl=/cmerchantQrUrl=http://t.crm.mamashenghuo.com/merchant/business/qrcode/"		${ap}
		sed  -i "/^merchantDetailUrl=/cmerchantDetailUrl=${alpha}/keegoo-h5/html/shop_play.html?storeId="		${ap}
		sed  -i "/^keegoo.weixin.h5.env=/ckeegoo.weixin.h5.env=test"							${ap}
		sed  -i "/^isdev/cisdev=true"											${ap}
		sed  -i "/^keegoo.h5.url=/ckeegoo.h5.url=${alpha}"							${ap}
	elif [ ${confenv} == 'qa-B' ] ; then
		delta=http://apph5.mamashenghuo.com/qa_b
		alpha=http://123.56.77.166:10087
		echo "qa_B Env !"
		sed  -i "/^keegoo.p/ckeegoo.pay.callback.url=http://123.56.77.166:10086"					${ap}
		sed  -i "/^keegoo.or/ckeegoo.order.mianze.url=${alpha}/mianzhe/index.html"				${ap}
		sed  -i "/^keegoo.share.play.url/ckeegoo.share.play.url=${delta}/html/details.html"				${ap}
		sed  -i "/^keegoo.share.edu.url/ckeegoo.share.edu.url=${delta}/html/details.html"				${ap}
		sed  -i "/^keegoo.share.playstore.url/ckeegoo.share.playstore.url=${delta}/html/shop.html"			${ap}
		sed  -i "/^keegoo.share.edustore.url/ckeegoo.share.edustore.url=${delta}/html/shop.html"			${ap}
		sed  -i "/^merchantQrUrl=/cmerchantQrUrl=http://123.56.77.166:10081/merchant/business/qrcode/"			${ap}
		sed  -i "/^merchantDetailUrl=/cmerchantDetailUrl=${alpha}/keegoo-h5/html/shop_play.html?storeId="		${ap}
		sed  -i "/^keegoo.weixin.h5.env=/ckeegoo.weixin.h5.env=test"							${ap}
		sed  -i "/^isdev/cisdev=true"											${ap}
		sed  -i "/^keegoo.h5.url=/ckeegoo.h5.url=${alpha}"							${ap}
	fi
fi

