
#!bin/bash
a="/etc/subversion"
d="/home/svn/repository/conf/svnserve.conf"
c="/home/svnserve.conf"

if [ ! -f "$a" ];then
echo y >> sudo apt-get install subversion
fi

if [ ! -f "/home/svn" ];then
sudo mkdir /home/svn
sudo mkdir /home/svn/repository
sudo chmod -R 777 /home/svn/repository
sudo svnadmin create /home/svn/repository
fi

if [ -f "/home/svn/repository/db" ];then
sudo chmod -R 777 db
fi

if [  -f "$c" ];then
rm -f "$c"
cp -r "$d" "$c"
else
  cp -r "$d" "$c"
fi

if [ -f "/home/passwd" ];then
rm -f "/home/passwd"
cp -r "/home/svn/repository/conf/passwd" "/home/passwd"
else
cp -r "/home/svn/repository/conf/passwd" "/home/passwd"
fi

if [ -f "/home/auhtz" ];then
rm -f "/home/authz"
cp -r "/home/svn/repository/conf/authz" "/home/authz"
else
cp -r "/home/svn/repository/conf/authz" "/home/authz"
fi

if [ -f "/home/svn/repository/conf/svnserve.conf" ];then
sed -i "/anon-access=/canon-access = read" /home/svn/repository/conf/svnserve.conf
sed -i "/auth-access=/cauth-access = write" /home/svn/repository/conf/svnserve.conf
echo "password-db = passwd" >> /home/svn/repository/conf/svnserve.conf
fi

if [ -f "/home/svn/repository/conf/passwd" ];then
echo "chendi = 123456" >> /home/svn/repository/conf/passwd
fi
if [ -f "/home/svn/repository/conf/authz" ];then
echo "admin = chendi" >> /home/svn/repository/conf/authz
echo "@admin = rw" >> /home/svn/repository/conf/authz
echo "* = r" >> /home/svn/repository/conf/authz
fi
