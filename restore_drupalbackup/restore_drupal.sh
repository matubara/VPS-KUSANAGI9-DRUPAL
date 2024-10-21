####################################################
# kusanagiプロビジョニングとDrupalインストール実施 #
####################################################

# 表示用制御文字の設定
ESC=$(printf '\033') RESET="${ESC}[0m"

BOLD="${ESC}[1m"        FAINT="${ESC}[2m"       ITALIC="${ESC}[3m"
UNDERLINE="${ESC}[4m"   BLINK="${ESC}[5m"       FAST_BLINK="${ESC}[6m"
REVERSE="${ESC}[7m"     CONCEAL="${ESC}[8m"     STRIKE="${ESC}[9m"
GOTHIC="${ESC}[20m"     DOUBLE_UNDERLINE="${ESC}[21m" NORMAL="${ESC}[22m"
NO_ITALIC="${ESC}[23m"  NO_UNDERLINE="${ESC}[24m"     NO_BLINK="${ESC}[25m"
NO_REVERSE="${ESC}[27m" NO_CONCEAL="${ESC}[28m"       NO_STRIKE="${ESC}[29m"
BLACK="${ESC}[30m"      RED="${ESC}[31m"        GREEN="${ESC}[32m"
YELLOW="${ESC}[33m"     BLUE="${ESC}[34m"       MAGENTA="${ESC}[35m"
CYAN="${ESC}[36m"       WHITE="${ESC}[37m"      DEFAULT="${ESC}[39m"
BG_BLACK="${ESC}[40m"   BG_RED="${ESC}[41m"     BG_GREEN="${ESC}[42m"
BG_YELLOW="${ESC}[43m"  BG_BLUE="${ESC}[44m"    BG_MAGENTA="${ESC}[45m"
BG_CYAN="${ESC}[46m"    BG_WHITE="${ESC}[47m"   BG_DEFAULT="${ESC}[49m"

CONFIRMMES="${RED}よろしいですか？ENTERキーを押してください。次に進みます。${RESET}"

profile=stag_chatgpt3
drupalproj=d11chatgpt100
#Drupalプロジェクトパス
projpath=/home/kusanagi/${profile}/${drupalproj}
webpath=${projpath}/web
vendorpath=${projpath}/vendor
backupfile=../../archives/20241013_041001_chatgpt100.tar.gz
backupdb=../../archives/20241013_041001_chatgpt100.sql
dbuser=testd10d112
dbname=testd10d112
dbpass=melb1999
dbhost=localhost


echo "【Drupal】環境構築 KUSANAGI環境 初期化コマンド実行"
read -p ${CONFIRMMES};


echo 設定ファイルのバックアップを取る
ls ${webpath}/sites/default/settings.php 
read -p ${CONFIRMMES};
cp -f ${webpath}/sites/default/settings.php ${projpath} 
echo ファイルを展開する
read -p ${CONFIRMMES};
tar zxf ${backupfile}
echo VENDER,WEBフォルダ、COMPOSERファイルを削除する
read -p ${CONFIRMMES};
sudo rm -rf ${webpath}
sudo rm -rf ${vendorpath}
sudo rm -f ${projpath}/composer.json
sudo rm -f ${projpath}/composer.lock
echo バックアップファイルのWEB,VENDERフォルダとCOMPSER.*ファイルを元に場所にコピーする
read -p ${CONFIRMMES};
mv -f ./chatgpt100/web ${projpath}
mv -f ./chatgpt100/vendor ${projpath}
cp -f ./chatgpt100/composer.* ${projpath}

echo 設定ファイルを元に場所に戻す
read -p ${CONFIRMMES};
cp -f ${projpath}/settings.php ${webpath}/sites/default/ 
echo 所有者、権限を変更する
echo データベースをリストアする
echo KUSANAGI RESTARTでサーバーに反映する

echo データベースをリストアする
read -p ${CONFIRMMES};
mysql -f -u ${dbuser} -p${dbpass} -h ${dbhost} ${dbname} < ${backupdb}
