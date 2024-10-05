dbuser="api"
dbpass="melb1999"
FQDN="api.studypocket.online"
email="admin@sinceretechnology.com.au"

provpath=/home/kusanagi/api/
proj=headlessdrupal
#drupalver=10.0.x-dev@dev
drupalver=10.3.1


recipe=drupal10
adminuser=sinceretechnology
adminpass="Melb#1999"
dbname="api"
dbuser="api"
dbpass="melb1999"

source ../kusanagi-privisioning-config-bookablecalendar.sh
 echo dbrootpath=$dbrootpass
 echo provname=$provname
 echo dbname=$dbname
 echo dbuser=$dbuser
 echo dbpass=$dbpass
 echo FQDN=$FQDN
 echo email=$email

 echo provpath=$provpath
 echo proj=$proj
 echo drupalver=$drupalver

 echo recipe=$recipe
 echo adminusr=$adminuser
 echo adminpass=$adminpass

read -p "Press [Enter] key to move on to the next.";
exit 0


#echo "【Drupal】環境構築 DRUSHランチャーPATH設定"
#read -p "Press [Enter] key to move on to the next.";

#export DRUSH_LAUNCHER_FALLBACK=${provpath}${proj}/vendor/drush/drush/drush
#echo $DRUSH_LAUNCHER_FALLBACK
drush --version

#sleep 1

echo "【Drupal】環境構築 DRUSHコマンドでDRUPALサイトインストーラ実行"
read -p "Press [Enter] key to move on to the next.";

echo "drush site:install --db-url=mysql://${dbuser}:${dbpass}@localhost:3306/${dbname} --account-name=${adminuser} --account-pass=${adminpass}"
echo "上記コマンドを本当に実行しますか"
read -p "Press [Enter] key to move on to the next.";
drush site:install --db-url=mysql://${dbuser}:${dbpass}@localhost:3306/${dbname} --account-name=${adminuser} --account-pass=${adminpass}

sleep 1
exit 0


echo "【Drupal】環境構築 DRUPAL用APACHE設定変更"
read -p "Press [Enter] key to move on to the next.";

cp /etc/opt/kusanagi/httpd/conf.d/${provname}.conf /etc/opt/kusanagi/httpd/conf.d/${provname}.conf.bak.for-ssl-update
sed -i -e "s/\/DocumentRoot/\/${proj}\/web/g" /etc/opt/kusanagi/httpd/conf.d/${provname}.conf

echo "【Drupal】環境構築 KUSANAGIコマンドでPHP他再起動"
kusanagi restart
echo "【Drupal】環境構築 完了しました"

#SCRIPT END

