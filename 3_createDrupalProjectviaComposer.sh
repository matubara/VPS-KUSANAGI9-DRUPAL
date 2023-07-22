echo "【Drupal】環境構築 COMPOSER DRUPALプロジェクトインストール"
read -p "Press [Enter] key to move on to the next.";
proj=app_studypocketjp
#drupalver=10.0.x-dev@dev
drupalver=10.1.0

echo "mkdir ${proj} && cd ${proj} && composer create-project drupal/recommended-project:${drupalver} tmp && cp -r tmp/. . && rm -rf tmp";
mkdir ${proj} && cd ${proj} && composer create-project drupal/recommended-project:${drupalver} tmp && cp -r tmp/. . && rm -rf tmp 

echo "【Drupal】環境構築 DRUPALプロジェクトインストール完了"
cp ../../4_installDrush.sh ./
cp ../../5_buildDrupalSite.sh ./
cp ../../6_changeNameforDocumentRoot.sh ./

source ./4_installDrush.sh
