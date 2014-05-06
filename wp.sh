#!/bin/sh
cd /Applications/MAMP/htdocs
printf "What would you like to name your new WordPress root directory (i.e. mywpdir)? "
read NEWDIR
git clone git@github.com:logoscreative/WordPress-Skeleton.git $NEWDIR --recursive
cd $NEWDIR
rm -rf .git
printf "MySQL User: "
read MYSQLUSER
if [ "$MYSQLUSER" = "" ]; then
	set MYSQLUSER = "root"
fi
printf "MySQL Password: "
read MYSQLPWD
printf "What would you like to name your new database (i.e. newwpdb)? "
read NEWDB
echo "CREATE DATABASE $NEWDB; GRANT ALL ON $NEWDB.* TO '$MYSQLUSER'@'localhost';" | ../../Library/bin/mysql -u$MYSQLUSER -p$MYSQLPWD

if [ -f ./wp-config.php ]
then
open http://localhost:8888/$NEWDIR/wp-admin/install.php
else
cp -n ./local-config-sample.php ./local-config.php
SECRETKEYS=$(curl -L https://api.wordpress.org/secret-key/1.1/salt/)
EXISTINGKEYS='put your unique phrase here'
printf '%s\n' "g/$EXISTINGKEYS/d" a "$SECRETKEYS" . w | ed -s wp-config.php
DBUSER=$"local_db_user"
DBPASS=$"local_db_password"
DBNAME=$"local_db_name"
sed -i '' -e "s/${DBUSER}/${MYSQLUSER}/g" local-config.php
sed -i '' -e "s/${DBPASS}/${MYSQLPWD}/g" local-config.php
sed -i '' -e "s/${DBNAME}/${NEWDB}/g" local-config.php
open http://localhost:8888/$NEWDIR/wp-admin/install.php
fi