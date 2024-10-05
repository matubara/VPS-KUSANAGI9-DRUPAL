#dbuser="bookablecalendar"
#dbpass="melb1999"
#FQDN="bookablecalendar.sincerew.online"
#email="admin@sincerew.com.au"

#provpath=/home/kusanagi/bookablecalendar/
#proj=bookablecalendar001
#drupalver=10.3.6
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

#recipe=drupal10
#adminuser=sinceretechnology
#adminpass="Melb#1999"
#dbname="bookablecalendar"
#dbuser="bookablecalendar"
#dbpass="melb1999"


echo "【Drupal】環境構築 DRUSHランチャーPATH設定"
read -p "Press [Enter] key to move on to the next.";

echo ${provpath}${proj}/vendor/drush/drush/drush
read -p "Press [Enter] key to move on to the next.";

export DRUSH_LAUNCHER_FALLBACK=${provpath}/${proj}/vendor/drush/drush/drush
echo $DRUSH_LAUNCHER_FALLBACK
drush --version

echo 正しく設定が完了していることを確認して以下の設定をする
echo 以下のコマンドを実行
echo vi ~/.bash_profile
echo 次の行をファイルの最後に追加する
echo DRUSH_LAUNCHER_FALLBACK=${provpath}/${proj}/vendor/drush/drush/drush
echo 以下のコマンドを実行して再読み込み
echo source ~/.bash_profile
echo 以上で設定を完了しました

