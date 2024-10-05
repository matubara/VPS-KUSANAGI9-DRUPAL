#Const Settings
kusanagipass="melb1999"
dbrootpass="melb1999"

provname="bookablecalendar"
dbname="bookablecalendar"
dbuser="bookablecalendar"
dbpass="melb1999"
FQDN="bookablecalendar.sincerew.online"
email="admin@sincerew.com"


echo "【Kusanagi】LAMP環境構築 KUSANAGI プロビジョニングコマンド実行 （${provname}）"
read -p "Press [Enter] key to move on to the next.";


echo "kusanagi provision --lamp --dbname=${dbname} --dbuser=${dbuser} --dbpass=${dbpass} --email=${email} --fqdn ${FQDN}  ${provname}"
#exit 0

kusanagi provision --lamp --dbname=${dbname} --dbuser=${dbuser} --dbpass=${dbpass} --email=${email} --fqdn ${FQDN}  ${provname}

echo "【Kusanagi】LAMP環境構築 FOR NEXTCLOUD プロビジョニング完了"
