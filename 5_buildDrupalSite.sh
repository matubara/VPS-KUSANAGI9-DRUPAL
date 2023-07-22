echo "【Drupal】環境構築 DRUSHコマンドでDRUPALサイトインストーラ実行"
read -p "Press [Enter] key to move on to the next.";

provpath=/home/kusanagi/crm_studypocket_dev/
proj=app_studypocketjp
export DRUSH_LAUNCHER_FALLBACK=${provpath}${proj}/vendor/drush/drush/drush
drush --version

recipe=drupal10
adminuser=sinceretechnology
adminpass="Melb#1999"
dbname="studypocket-dev"
dbuser="studypocket-dev"
dbpass="melb1999"
echo "drush site:install --db-url=mysql://${dbuser}:${dbpass}@localhost:3306/${dbname} --account-name=${adminuser} --account-pass=${adminpass}"
drush site:install --db-url=mysql://${dbuser}:${dbpass}@localhost:3306/${dbname} --account-name=${adminuser} --account-pass=${adminpass}

sleep 1

source ./6_changeNameforDocumentRoot.sh
