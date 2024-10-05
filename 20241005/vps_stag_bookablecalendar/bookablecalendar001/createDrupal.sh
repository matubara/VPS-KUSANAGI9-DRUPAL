dbuser="bookablecalendar"
dbpass="melb1999"
FQDN="bookablecalendar.sincerew.online"
email="admin@sincerew.com.au"

provpath=/home/kusanagi/bookablecalendar/
proj=bookablecalendar001
#drupalver=10.0.x-dev@dev
drupalver=10.3.6


recipe=drupal10
adminuser=sinceretechnology
adminpass="Melb#1999"
dbname="bookablecalendar"
dbuser="bookablecalendar"
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

##################################################
# SCRIPT START
#echo "【Drupal】環境構築 KUSANAGI環境 初期化コマンド実行"
#read -p "Press [Enter] key to move on to the next.";

#初期化
#kusanagi init --tz Asia/Tokyo --lang ja --keyboard en --passwd ${kusanagipass} --nophrase --dbrootpass ${dbrootpass} --mariadb10.5 --httpd24 --php81



#echo "【Kusanagi】LAMP環境構築 KUSANAGI プロビジョニングコマンド実行"
#read -p "Press [Enter] key to move on to the next.";


#kusanagi provision --lamp --dbname=${dbname} --dbuser=${dbuser} --dbpass=${dbpass} --email=${email} --fqdn ${FQDN}  ${provname}

#echo "【Kusanagi】LAMP環境構築 FOR STUDYPOCKET プロビジョニング完了"

###############################
#プロビジョン内で実行のため削除
###############################
#プロビジョニングフォルダに移動
#cd ./${provname}


echo "【Drupal】環境構築 COMPOSER DRUPALプロジェクトインストール"
echo "現在のパス"
pwd
echo "プロジェクトのパス"
echo `pwd`/${proj}

read -p "Press [Enter] key to move on to the next.";

echo "mkdir ${proj} && cd ${proj} && composer create-project drupal/recommended-project:${drupalver} tmp && cp -r tmp/. . && rm -rf tmp";
mkdir ${proj} && cd ${proj} && composer create-project drupal/recommended-project:${drupalver} tmp && cp -r tmp/. . && rm -rf tmp

echo "【Drupal】環境構築 DRUPALプロジェクトインストール完了"

echo "【Drupal】環境構築 COMPOSER DRUSHインストール"
read -p "Press [Enter] key to move on to the next.";

composer require drush/drush

echo "【Drupal】環境構築 DRUSHランチャーのインストール"
read -p "Press [Enter] key to move on to the next.";
wget -O drush.phar https://github.com/drush-ops/drush-launcher/releases/latest/download/drush.phar
chmod +x drush.phar
#mv drush.phar drush
#cp drush /opt/kusanagi/bin 
#ln -s /opt/kusanagi/bin/drush /usr/local/bin/drush
#export DRUSH_LAUNCHER_FALLBACK=${provpath}${proj}/vendor/drush/drush/drush

sleep 1

echo "【Drupal】環境構築 DRUSHランチャーPATH設定"
read -p "Press [Enter] key to move on to the next.";

export DRUSH_LAUNCHER_FALLBACK=${provpath}${proj}/vendor/drush/drush/drush
echo $DRUSH_LAUNCHER_FALLBACK
drush --version

exit 0
sleep 1

echo "【Drupal】環境構築 DRUSHコマンドでDRUPALサイトインストーラ実行"
read -p "Press [Enter] key to move on to the next.";

echo "drush site:install --db-url=mysql://${dbuser}:${dbpass}@localhost:3306/${dbname} --account-name=${adminuser} --account-pass=${adminpass}"
drush site:install --db-url=mysql://${dbuser}:${dbpass}@localhost:3306/${dbname} --account-name=${adminuser} --account-pass=${adminpass}

sleep 1



echo "【Drupal】環境構築 DRUPAL用APACHE設定変更"
read -p "Press [Enter] key to move on to the next.";

#cp /etc/opt/kusanagi/httpd/conf.d/${provname}.conf /etc/opt/kusanagi/httpd/conf.d/${provname}.conf.bak.for-ssl-update
#sed -i -e "s/\/DocumentRoot/\/${proj}\/web/g" /etc/opt/kusanagi/httpd/conf.d/${provname}.conf

echo "【Drupal】環境構築 KUSANAGIコマンドでPHP他再起動"
kusanagi restart
echo "【Drupal】環境構築 完了しました"

#SCRIPT END

