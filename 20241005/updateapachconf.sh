
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

echo "【Drupal】環境構築 DRUPAL用APACHE設定変更"
read -p "Press [Enter] key to move on to the next.";

sudo cp /etc/opt/kusanagi/httpd/conf.d/${provname}.conf /etc/opt/kusanagi/httpd/conf.d/${provname}.conf.bak.for-ssl-update
sudo sed -i -e "s/\/DocumentRoot/\/${proj}\/web/g" /etc/opt/kusanagi/httpd/conf.d/${provname}.conf  

echo "【Drupal】環境構築 KUSANAGIコマンドでPHP他再起動"
kusanagi restart
echo "【Drupal】環境構築 完了しました"

#SCRIPT END
