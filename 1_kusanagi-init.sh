echo "【Drupal】環境構築 KUSANAGI環境 初期化コマンド実行"
read -p "Press [Enter] key to move on to the next.";

kusanagi init --tz Asia/Tokyo --lang ja --keyboard en --passwd melb1999 --nophrase --dbrootpass melb1999 --mariadb10.5 --httpd24 --php81

source ./2_build-provision-lamp.sh 
