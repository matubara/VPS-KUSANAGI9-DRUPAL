echo "COMPOSERでVENDORの再構築を実施します"
bash ./rebuild_vendor.sh
echo "WEBフォルダをアーカイブのWEBフォルダで置き換えます"
sudo cp ./bookablecalendar001/web/ ../ -rpf
sudo chmod 777 ../web
sudo cp ../settings.php ../web/sites/default/
echo "データベースをリストアします"
bash ./restore_db.sh
drush cr
kusanagi restart
echo "すべてのリストア処理を完了しました"
