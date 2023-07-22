echo "【Drupal】環境構築 COMPOSER DRUSHインストール"
read -p "Press [Enter] key to move on to the next.";

provpath=/home/kusanagi/crm_studypocket_dev/
proj=app_studypocketjp

composer require drush/drush

echo "【Drupal】環境構築 DRUSHランチャーのインストール"
wget -O drush.phar https://github.com/drush-ops/drush-launcher/releases/latest/download/drush.phar
chmod +x drush.phar
mv drush.phar /usr/local/bin/drush
#export DRUSH_LAUNCHER_FALLBACK=${provpath}${proj}/vendor/drush/drush/drush

sleep 1

echo "【Drupal】環境構築 DRUSHランチャー環境設定"
provpath=/home/kusanagi/crm_studypocket_dev/
proj=app_studypocketjp

export DRUSH_LAUNCHER_FALLBACK=${provpath}${proj}/vendor/drush/drush/drush
echo $DRUSH_LAUNCHER_FALLBACK
drush --version

sleep 1

source ./5_buildDrupalSite.sh
