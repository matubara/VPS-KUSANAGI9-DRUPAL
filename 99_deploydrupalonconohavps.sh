source ./const_deploydrupalonconohavps.sh

##################################################
# SCRIPT START
provpath=/home/kusanagi/${provname}/
echo "【Drupal】環境構築 KUSANAGI環境 初期化コマンド実行"
read -p "Press [Enter] key to move on to the next.";

#初期化
kusanagi init --tz Asia/Tokyo --lang ja --keyboard en --passwd ${kusanagipass} --nophrase --dbrootpass ${dbrootpass} --mariadb10.5 --httpd24 --php81



echo "【Kusanagi】LAMP環境構築 KUSANAGI プロビジョニングコマンド実行"
read -p "Press [Enter] key to move on to the next.";

kusanagi provision --lamp --dbname=${dbname} --dbuser=${dbuser} --dbpass=${dbpass} --email=${email} --fqdn ${FQDN}  ${provname}

#プロビジョニングフォルダに移動
cd ./${provname}




echo "【Drupal】環境構築 COMPOSER DRUPALプロジェクトインストール"
read -p "Press [Enter] key to move on to the next.";


echo "mkdir ${proj} && cd ${proj} && composer create-project drupal/recommended-project:${drupalver} tmp && cp -r tmp/. . && rm -rf tmp";
mkdir ${proj} && cd ${proj} && composer create-project drupal/recommended-project:${drupalver} tmp && cp -r tmp/. . && rm -rf tmp 




echo "【Drupal】環境構築 COMPOSER DRUSHインストール"
read -p "Press [Enter] key to move on to the next.";

composer require drush/drush

echo "【Drupal】環境構築 DRUSHランチャーのインストール"
wget -O drush.phar https://github.com/drush-ops/drush-launcher/releases/latest/download/drush.phar
chmod +x drush.phar
mv drush.phar /usr/local/bin/drush

sleep 1

echo "【Drupal】環境構築 DRUSHランチャー環境設定"
export DRUSH_LAUNCHER_FALLBACK=${provpath}${proj}/vendor/drush/drush/drush
echo $DRUSH_LAUNCHER_FALLBACK
drush --version

sleep 1


echo "【Drupal】環境構築 DRUSHコマンドでDRUPALサイトインストーラ実行"
read -p "Press [Enter] key to move on to the next.";

echo "drush site:install --db-url=mysql://${dbuser}:${dbpass}@localhost:3306/${dbname} --account-name=${adminuser} --account-pass=${adminpass}"
drush site:install --db-url=mysql://${dbuser}:${dbpass}@localhost:3306/${dbname} --account-name=${adminuser} --account-pass=${adminpass}

sleep 1

echo "【Drupal】環境構築 DRUPAL用APACHE設定変更"
read -p "Press [Enter] key to move on to the next.";

cp /etc/opt/kusanagi/httpd/conf.d/${provname}.conf /etc/opt/kusanagi/httpd/conf.d/c${provname}.conf.bak
sed -i -e "s/\/DocumentRoot/\/${proj}\/web/g" /etc/opt/kusanagi/httpd/conf.d/${provname}.conf  

echo "【Drupal】環境構築 KUSANAGIコマンドでPHP他再起動"
kusanagi restart
echo "【Drupal】環境構築 完了しました"

#SCRIPT END
