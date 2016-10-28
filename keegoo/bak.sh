#!/bin/bash
timep=`date -d today +"%Y-%m-%d_%H:%M:%S"`
logpath=/root/keegoo_tool/sgol
jklog=${logpath%/*}/jk.log
if [ ! -d ${logpath} ];then
	mkdir ${logpath}
fi
if [ -f ${jklog} ];then
	mv ${jklog} ${logpath}/${timep}jk.log
fi
