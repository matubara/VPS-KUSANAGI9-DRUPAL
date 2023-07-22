echo "【Drupal】環境構築 DRUPAL用APACHE設定変更"
read -p "Press [Enter] key to move on to the next.";

cp /etc/opt/kusanagi/httpd/conf.d/crm_studypocket_dev.conf /etc/opt/kusanagi/httpd/conf.d/crm_studypocket_dev.conf.bak
sed -i -e "s/\/DocumentRoot/\/app_studypocketjp\/web/g" /etc/opt/kusanagi/httpd/conf.d/crm_studypocket_dev.conf  

echo "【Drupal】環境構築 KUSANAGIコマンドでPHP他再起動"
kusanagi restart
echo "【Drupal】環境構築 完了しました"
