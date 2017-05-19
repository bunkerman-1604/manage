setup appium in windows
1-setup nodejs
 download from page https://nodejs.org/en/
 set where the nodejs is in your env path
 check setup status:cmd->node -v
2-setup android SDK
 set your "ANDROID_HOME" in env path
 set your "tool" and "platform-tools" in env path too
3-setup JDK
 set your "JAVA_HOME" in env path
4-setup appium
 cmd->
 npm install –g appium->
 check appium status-> put word "appium" in cmd

setup python in eclipse and fetch appium module
1-setup python in windows
 download setup application in http://www.python.org/
 setup and set "PYTHON_HOME" in env path
 set "%PYTHON_HOME%;%PYTHON_HOME%/Scripts" in env path
2-setup in eclipse
 Help->Install New SoftWare->http://pydev.org/updates
 
3-fetch appium and selenium module
 cmd->
 pip install selenium->
 pip install Appium-Python-Client->

#here is example about drive shell command and MySQLdb
#!/usr/bin/python
# -*- coding: UTF-8 -*-
select1 = "SELECT orderNo from eduorder  ORDER BY createdAt desc limit 0,1;"
select2 = "SELECT orderNo from playorder  ORDER BY createdAt desc limit 0,1;"
import MySQLdb
import sys
import commands
if sys.argv[1] == "edu" :
        sqls=select1
else :
        sqls=select2
if sys.argv[2] == "QA_A" :
        database="qa_a"
elif sys.argv[2] == "QA_B" :
        database="qa_b"
elif sys.argv[2] == "QA_C" :
        database="qa_c"
db = MySQLdb.connect("123.57.10.243","yourSelf","Ca$98d%b9c",database )
cursor = db.cursor()
cursor.execute(sqls)
data =  cursor.fetchone()
#print "Database Version is :%s" %data 
dd = str('%s'%data)
db.close()
tmp1 = "curl -d \"orderNo="+dd+"\" \"http://keegoo.net:3456/weixin/pay/callback\""
print tmp1
tpm1 = commands.getoutput(tmp1)
print tpm1
