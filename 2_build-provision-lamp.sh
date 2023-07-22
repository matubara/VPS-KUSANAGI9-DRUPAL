echo "【Kusanagi】LAMP環境構築 KUSANAGI プロビジョニングコマンド実行"
read -p "Press [Enter] key to move on to the next.";

dbname="studypocket-dev"
dbuser="studypocket-dev"
dbpass="melb1999"
FQDN="app2.studypocket.jp"
email="admin@sinceretechnology.com.au"

kusanagi provision --lamp --dbname=${dbname} --dbuser=${dbuser} --dbpass=${dbpass} --email=${email} --fqdn ${FQDN} crm_studypocket_dev

echo "【Kusanagi】LAMP環境構築 FOR STUDYPOCKET プロビジョニング完了"
cp ./3_createDrupalProjectviaComposer.sh ./crm_studypocket_dev

cd ./crm_studypocket_dev
source ./3_createDrupalProjectviaComposer.sh
