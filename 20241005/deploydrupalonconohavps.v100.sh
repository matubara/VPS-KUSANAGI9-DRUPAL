
##################################################
# SCRIPT START
#Const Settings読み込み
source ./const_deploydrupalonconohavps.v100.sh
 echo "----------------------"
 echo "Const settings"
 echo "Settings for Kusanagi"
 echo dbrootpath=$dbrootpass
 echo provname=$provname
 echo dbname=$dbname
 echo dbuser=$dbuser
 echo dbpass=$dbpass
 echo FQDN=$FQDN
 echo email=$email
 echo "Settings for Drupal"
 echo provpath=$provpath
 echo proj=$proj
 echo drupalver=$drupalver
 echo adminusr=$adminuser
 echo adminpass=$adminpass
 echo "----------------------"

provpath=/home/kusanagi/${provname}/

echo "【Drupal】環境構築 KUSANAGI環境およびDrupal開発環境インストールを実施します"
 echo "【注意】※※※ kusanagiの初期化はスキップします（必要ならスクリプトを変更してください）"
 echo "###上記の設定で実施します。本当によろしいですか？###"
read -p "Press [Enter] key to move on to the next.";



##### ここはスキップします ここから #####
#echo "【Drupal】環境構築 KUSANAGI環境 初期化コマンド実行"
#read -p "Press [Enter] key to move on to the next.";

#初期化
#kusanagi init --tz Asia/Tokyo --lang ja --keyboard en --passwd ${kusanagipass} --nophrase --dbrootpass ${dbrootpass} --mariadb10.5 --httpd24 --php81
##### ここはスキップします ここまで #####



echo "【Kusanagi】LAMP環境構築 KUSANAGI プロビジョニングを作成する"
read -p "Press [Enter] key to move on to the next.";

kusanagi provision --lamp --dbname=${dbname} --dbuser=${dbuser} --dbpass=${dbpass} --email=${email} --fqdn ${FQDN}  ${provname}

#プロビジョニングフォルダに移動
cd ./${provname}




echo "【Drupal】環境構築 COMPOSERで DRUPALプロジェクトをインストールする"
read -p "Press [Enter] key to move on to the next.";


echo "mkdir ${proj} && cd ${proj} && composer create-project drupal/recommended-project:${drupalver} tmp && cp -r tmp/. . && rm -rf tmp";
mkdir ${proj} && cd ${proj} && composer create-project drupal/recommended-project:${drupalver} tmp && cp -r tmp/. . && rm -rf tmp 




echo "【Drupal】環境構築 COMPOSERで DRUSHをインストールする"
read -p "Press [Enter] key to move on to the next.";

composer require drush/drush

echo "【Drupal】環境構築 DRUSHランチャーをインストールする"
wget -O drush.phar https://github.com/drush-ops/drush-launcher/releases/latest/download/drush.phar
chmod +x drush.phar
mv drush.phar /usr/local/bin/drush

sleep 1

echo "【Drupal】環境構築 DRUSHランチャー環境を設定する（再起動時は環境変数が消えるため必要なら~/.bash_profileに追加すること）"
export DRUSH_LAUNCHER_FALLBACK=${provpath}${proj}/vendor/drush/drush/drush
echo $DRUSH_LAUNCHER_FALLBACK
drush --version

sleep 1


echo "【Drupal】環境構築 DRUSHコマンドでDRUPALサイトを自動構築する"
read -p "Press [Enter] key to move on to the next.";

echo "drush site:install --db-url=mysql://${dbuser}:${dbpass}@localhost:3306/${dbname} --account-name=${adminuser} --account-pass=${adminpass}"
drush site:install --db-url=mysql://${dbuser}:${dbpass}@localhost:3306/${dbname} --account-name=${adminuser} --account-pass=${adminpass}

sleep 1

echo "【Drupal】環境構築 DRUPAL用APACHE設定変更する（/etc/opt/kusanagi/httpd/conf.d の対象ファイルを変更）"
read -p "Press [Enter] key to move on to the next.";

sudo cp /etc/opt/kusanagi/httpd/conf.d/${provname}.conf /etc/opt/kusanagi/httpd/conf.d/${provname}.conf.bak.for-ssl-update
sudo sed -i -e "s/\/DocumentRoot/\/${proj}\/web/g" /etc/opt/kusanagi/httpd/conf.d/${provname}.conf  

echo "【Drupal】環境構築 KUSANAGIコマンドでPHP他を再起動する"
kusanagi restart
echo "【Drupal】環境構築 完了しました"

#SCRIPT END
