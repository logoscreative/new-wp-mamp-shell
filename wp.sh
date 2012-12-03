#!/bin/sh
cd /Applications/MAMP/htdocs
printf "What would you like to name your new WordPress root directory (i.e. mywpdir)? "
read NEWDIR
git clone https://github.com/WordPress/WordPress.git $NEWDIR
cd $NEWDIR
printf "What version of WordPress would you like to use? It must be a non-beta release (i.e. 3.4.2). "
read WPVER
git checkout $WPVER
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
cp -n ./wp-config-sample.php ./wp-config.php
SECRETKEYS=$(curl -L https://api.wordpress.org/secret-key/1.1/salt/)
EXISTINGKEYS='put your unique phrase here'
printf '%s\n' "g/$EXISTINGKEYS/d" a "$SECRETKEYS" . w | ed -s wp-config.php
DBUSER=$"username_here"
DBPASS=$"password_here"
DBNAME=$"database_name_here"
sed -i '' -e "s/${DBUSER}/${MYSQLUSER}/g" wp-config.php
sed -i '' -e "s/${DBPASS}/${MYSQLPWD}/g" wp-config.php
sed -i '' -e "s/${DBNAME}/${NEWDB}/g" wp-config.php
open http://localhost:8888/$NEWDIR/wp-admin/install.php
fi