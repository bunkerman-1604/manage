#!/bin/bash
ap=$1
newbase=qa_a
sqlport=3306
newuser=yourSelf
newpwd=Ca\$98d%b9c
myhost=10.171.60.186
myredis=10.44.62.240
redisport=12379
mysolr=10.44.155.32
confenv=qa-A
my_path="${myhost}:${sqlport}/${newbase}"
mysqlpath="jdbc:mysql://${my_path}?zautoReconnect=true&amp;characterEncoding=utf8"
echo $#
if [  $# -eq 9 ];then
	timep=`date -d today +"%Y-%m-%d_%H:%M:%S"`
	sed -i "/^newbase=/cnewbase=$1"	/opt/keegoo_tool/conf.sh
	sed -i "/^sqlport=/csqlport=$2"	/opt/keegoo_tool/conf.sh
	sed -i "/^newuser=/cnewuser=$3"	/opt/keegoo_tool/conf.sh
	sed -i "/^newpwd=/cnewpwd=$4"	/opt/keegoo_tool/conf.sh
	sed -i "/^myhost=/cmyhost=$5"	/opt/keegoo_tool/conf.sh
	sed -i "/^myredis=/cmyredis=$6"	/opt/keegoo_tool/conf.sh
	sed -i "/^redis/credisport=$7"	/opt/keegoo_tool/conf.sh
	sed -i "/^mysolr=/cmysolr=$8"	/opt/keegoo_tool/conf.sh
	sed -i "/^confenv=/cconfenv=$9"	/opt/keegoo_tool/conf.sh
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
	sed  -i "/^solrUrl=/csolrUrl=http://${mysolr}:8080/solr"		${ap}
	sed  -i "s|=c:/|=/data/|g"						${ap}
	sed  -i "/^slave.jdbc.url/cslave.jdbc.url2=jdbc:mysql://${my_path}"	${ap}
	sed  -i "/^slave.jdbc.us/cslave.jdbc.username2=${newuser}"		${ap}
	sed  -i "/^slave.jdbc.pa/cslave.jdbc.password2=${newpwd}"		${ap}
	if [ ${confenv} == 'product' ];then
		#delta=http://apph5.mamashenghuo.com/weixin61
		alpha=http://h5wx.mamashenghuo.com
		lamda=http://crm.mamashenghuo.com
		echo "product Env !"
		sed  -i "/^keegoo.p/ckeegoo.pay.callback.url=http://uservice.mamashenghuo.com"					${ap}
		sed  -i "/^keegoo.or/ckeegoo.order.mianze.url=${alpha}/mianzhe/index.html"					${ap}
		sed  -i "/^keegoo.share.play.u/ckeegoo.share.play.url=${alpha}/#!/merchant/play_detail/"			${ap}
		sed  -i "/^keegoo.share.edu.url/ckeegoo.share.edu.url=${alpha}/#!/merchant/edu_detail/"				${ap}
		sed  -i "/^keegoo.share.playsto/ckeegoo.share.playstore.url=${alpha}/#!/shop/play/"				${ap}
		sed  -i "/^keegoo.share.edustore/ckeegoo.share.edustore.url=${alpha}/#!/shop/edu/"				${ap}
		sed  -i "/^merchantQrUrl=/cmerchantQrUrl=${lamda}/merchant/business/qrcode/"					${ap}
		sed  -i "/^merchantDetailUrl=/cmerchantDetailUrl=${alpha}/#!/shop/play/"					${ap}
		sed  -i "/^keegoo.weixin.h5.env=/ckeegoo.weixin.h5.env=online"							${ap}
		sed  -i "/^isdev/cisdev=false"											${ap}
		sed  -i "/^keegoo.h5.url=/ckeegoo.h5.url=${alpha}"								${ap}
		sed  -i "/^business.store.qrcode.url/cbusiness.store.qrcode.url=${lamda}/merchant/business/qrcode/"		${ap}
		sed  -i "/^edu.service.d/cedu.service.detail=${alpha}/#!/merchant/edu_detail/"					${ap}
		sed  -i "/^edu.service.v/cedu.service.vodetail=${alpha}/#!/merchant/eduvod_detail/"				${ap}
		sed  -i "/^keegoo.share.eduvod.url/ckeegoo.share.eduvod.url=${alpha}/#!/merchant/eduvod_detail/"		${ap}
		sed  -i "/^keegoo.alipay.h5.r/ckeegoo.alipay.h5.return.url=${alpha}"						${ap}
	elif [ ${confenv} == 'develope' ] ; then
		#delta=http://apph5.mamashenghuo.com/weixin61d
		alpha=http://d.h5wx.mamashenghuo.com
		lamda=http://d.crm.mamashenghuo.com
		echo "develope Env !"
		sed  -i "/^keegoo.p/ckeegoo.pay.callback.url=http://d.uservice.mamashenghuo.com"				${ap}
		sed  -i "/^keegoo.or/ckeegoo.order.mianze.url=${alpha}/mianzhe/index.html"					${ap}
		sed  -i "/^keegoo.share.play.u/ckeegoo.share.play.url=${alpha}/#!/merchant/play_detail/"			${ap}
		sed  -i "/^keegoo.share.edu.url/ckeegoo.share.edu.url=${alpha}/#!/merchant/edu_detail/"				${ap}
		sed  -i "/^keegoo.share.playsto/ckeegoo.share.playstore.url=${alpha}/#!/shop/play/"				${ap}
		sed  -i "/^keegoo.share.edustore/ckeegoo.share.edustore.url=${alpha}/#!/shop/edu/"				${ap}
		sed  -i "/^merchantQrUrl=/cmerchantQrUrl=${lamda}/merchant/business/qrcode/"					${ap}
		sed  -i "/^merchantDetailUrl=/cmerchantDetailUrl=${alpha}/#!/shop/play/"					${ap}
		sed  -i "/^keegoo.weixin.h5.env=/ckeegoo.weixin.h5.env=develope"						${ap}
		sed  -i "/^isdev/cisdev=true"											${ap}
		sed  -i "/^keegoo.h5.url=/ckeegoo.h5.url=${alpha}"								${ap}
		sed  -i "/^business.store.qrcode.url/cbusiness.store.qrcode.url=${lamda}/merchant/business/qrcode/"		${ap}
		sed  -i "/^edu.service.d/cedu.service.detail=${alpha}/#!/merchant/edu_detail/"					${ap}
		sed  -i "/^edu.service.v/cedu.service.vodetail=${alpha}/#!/merchant/eduvod_detail/"				${ap}
		sed  -i "/^keegoo.share.eduvod.url/ckeegoo.share.eduvod.url=${alpha}/#!/merchant/eduvod_detail/"		${ap}
		sed  -i "/^keegoo.alipay.h5.r/ckeegoo.alipay.h5.return.url=${alpha}"						${ap}
	elif [ ${confenv} == 'qa-A' ] ; then
		#delta=http://apph5.mamashenghuo.com/qa_a
		alpha=http://d.h5wx.mamashenghuo.com
		lamda=http://t.crm.mamashenghuo.com
		echo "qa_A Env !"
		sed  -i "/^keegoo.p/ckeegoo.pay.callback.url=http://t.uservice.mamashenghuo.com"				${ap}
		sed  -i "/^keegoo.or/ckeegoo.order.mianze.url=${alpha}/mianzhe/index.html"					${ap}
		sed  -i "/^keegoo.share.play.u/ckeegoo.share.play.url=${alpha}/#!/merchant/play_detail/"			${ap}
		sed  -i "/^keegoo.share.edu.url/ckeegoo.share.edu.url=${alpha}/#!/merchant/edu_detail/"				${ap}
		sed  -i "/^keegoo.share.playsto/ckeegoo.share.playstore.url=${alpha}/#!/shop/play/"				${ap}
		sed  -i "/^keegoo.share.edustore/ckeegoo.share.edustore.url=${alpha}/#!/shop/edu/"				${ap}
		sed  -i "/^merchantQrUrl=/cmerchantQrUrl=${lamda}/merchant/business/qrcode/"					${ap}
		sed  -i "/^merchantDetailUrl=/cmerchantDetailUrl=${alpha}/#!/shop/play/"					${ap}
		sed  -i "/^keegoo.weixin.h5.env=/ckeegoo.weixin.h5.env=test"							${ap}
		sed  -i "/^isdev/cisdev=true"											${ap}
		sed  -i "/^keegoo.h5.url=/ckeegoo.h5.url=${alpha}"								${ap}
		sed  -i "/^business.store.qrcode.url/cbusiness.store.qrcode.url=${lamda}/merchant/business/qrcode/"		${ap}
		sed  -i "/^edu.service.d/cedu.service.detail=${alpha}/#!/merchant/edu_detail/"					${ap}
		sed  -i "/^edu.service.v/cedu.service.vodetail=${alpha}/#!/merchant/eduvod_detail/"				${ap}
		sed  -i "/^keegoo.share.eduvod.url/ckeegoo.share.eduvod.url=${alpha}/#!/merchant/eduvod_detail/"		${ap}
		sed  -i "/^keegoo.alipay.h5.r/ckeegoo.alipay.h5.return.url=${alpha}"						${ap}
	elif [ ${confenv} == 'qa-B' ] ; then
		#delta=http://apph5.mamashenghuo.com/qa_b
		alpha=http://d.h5wx.mamashenghuo.com
		lamda=http://123.56.77.166:10081
		echo "qa_B Env !"
		sed  -i "/^keegoo.p/ckeegoo.pay.callback.url=http://123.56.77.166:51286"					${ap}
		sed  -i "/^keegoo.or/ckeegoo.order.mianze.url=${alpha}/mianzhe/index.html"					${ap}
		sed  -i "/^keegoo.share.play.u/ckeegoo.share.play.url=${alpha}/#!/merchant/play_detail/"			${ap}
		sed  -i "/^keegoo.share.edu.url/ckeegoo.share.edu.url=${alpha}/#!/merchant/edu_detail/"				${ap}
		sed  -i "/^keegoo.share.playsto/ckeegoo.share.playstore.url=${alpha}/#!/shop/play/"				${ap}
		sed  -i "/^keegoo.share.edustore/ckeegoo.share.edustore.url=${alpha}/#!/shop/edu/"				${ap}
		sed  -i "/^merchantQrUrl=/cmerchantQrUrl=${lamda}/merchant/business/qrcode/"					${ap}
		sed  -i "/^merchantDetailUrl=/cmerchantDetailUrl=${alpha}/#!/shop/play/"					${ap}
		sed  -i "/^keegoo.weixin.h5.env=/ckeegoo.weixin.h5.env=test"							${ap}
		sed  -i "/^isdev/cisdev=true"											${ap}
		sed  -i "/^keegoo.h5.url=/ckeegoo.h5.url=${alpha}"								${ap}
		sed  -i "/^business.store.qrcode.url/cbusiness.store.qrcode.url=${lamda}/merchant/business/qrcode/"		${ap}
		sed  -i "/^edu.service.d/cedu.service.detail=${alpha}/#!/merchant/edu_detail/"					${ap}
		sed  -i "/^edu.service.v/cedu.service.vodetail=${alpha}/#!/merchant/eduvod_detail/"				${ap}
		sed  -i "/^keegoo.share.eduvod.url/ckeegoo.share.eduvod.url=${alpha}/#!/merchant/eduvod_detail/"		${ap}
		sed  -i "/^keegoo.alipay.h5.r/ckeegoo.alipay.h5.return.url=${alpha}"						${ap}
	elif [ ${confenv} == 'qa-C' ] ; then
		#delta=http://apph5.mamashenghuo.com/qa_c
		alpha=http://d.h5wx.mamashenghuo.com
		lamda=http://123.57.10.243:10081
		echo "qa_C Env !"
		sed  -i "/^keegoo.p/ckeegoo.pay.callback.url=http://123.57.10.243:10086"					${ap}
		sed  -i "/^keegoo.or/ckeegoo.order.mianze.url=${alpha}/mianzhe/index.html"					${ap}
		sed  -i "/^keegoo.share.play.u/ckeegoo.share.play.url=${alpha}/#!/merchant/play_detail/"			${ap}
		sed  -i "/^keegoo.share.edu.url/ckeegoo.share.edu.url=${alpha}/#!/merchant/edu_detail/"				${ap}
		sed  -i "/^keegoo.share.playsto/ckeegoo.share.playstore.url=${alpha}/#!/shop/play/"				${ap}
		sed  -i "/^keegoo.share.edustore/ckeegoo.share.edustore.url=${alpha}/#!/shop/edu/"				${ap}
		sed  -i "/^merchantQrUrl=/cmerchantQrUrl=${lamda}/merchant/business/qrcode/"					${ap}
		sed  -i "/^merchantDetailUrl=/cmerchantDetailUrl=${alpha}/#!/shop/play/"					${ap}
		sed  -i "/^keegoo.weixin.h5.env=/ckeegoo.weixin.h5.env=test"							${ap}
		sed  -i "/^isdev/cisdev=true"											${ap}
		sed  -i "/^keegoo.h5.url=/ckeegoo.h5.url=${alpha}"								${ap}
		sed  -i "/^business.store.qrcode.url/cbusiness.store.qrcode.url=${lamda}/merchant/business/qrcode/"		${ap}
		sed  -i "/^edu.service.d/cedu.service.detail=${alpha}/#!/merchant/edu_detail/"					${ap}
		sed  -i "/^edu.service.v/cedu.service.vodetail=${alpha}/#!/merchant/eduvod_detail/"				${ap}
		sed  -i "/^keegoo.share.eduvod.url/ckeegoo.share.eduvod.url=${alpha}/#!/merchant/eduvod_detail/"		${ap}
		sed  -i "/^keegoo.alipay.h5.r/ckeegoo.alipay.h5.return.url=${alpha}"						${ap}
	fi
fi

