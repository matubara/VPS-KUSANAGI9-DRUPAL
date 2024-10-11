
####################################################
# kusanagiプロビジョニングとDrupalインストール実施 # 
####################################################

#表示用制御文字の設定
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

##################################################
#Const Settings読み込み
##################################################
source ./const_deploynextcloudonconohavps.v100.sh
 echo "----------------------"
 echo "Const settings"
 echo "Settings for Kusanagi"
 echo KUSANAGIパスワード kusanagipass=${GREEN}$kusanagipass${RESET}
 echo DBルートパスワード dbrootpath=${GREEN}$dbrootpass${RESET}
 echo KUSANAGIプロファイル kusanagiprofile=${GREEN}$kusanagiprofile${RESET}
 echo DB名 dbname=${GREEN}$dbname${RESET}
 echo DBユーザ dbuser=${GREEN}$dbuser${RESET}
 echo DBパスワード dbpass=${GREEN}$dbpass${RESET}
 echo ドメイン名 FQDN=${GREEN}$FQDN${RESET}
 echo 管理者メールアドレス email=${GREEN}$email${RESET}
 echo "Settings for Drupal"
 echo Drupalプロジェクト名 drupalproject=${YELLOW}$drupalproject
 echo Drupalバージョン drupalver=${YELLOW}$drupalver${RESET}
 echo DrupalユーザID drupalusr=${YELLOW}$drupalusr${RESET}
 echo Drupalパスワード drupalpass=${YELLOW}$drupalpass${RESET}
 echo "----------------------"

provpath=/home/kusanagi/${kusanagiprofile}/

echo "【NEXTCLOUD】環境構築 KUSANAGI環境インストールを実施します"
 echo "【注意】※※※ kusanagiの初期化はスキップします（必要ならスクリプトを変更してください）"
 echo "###設定が正しいことを確認してください####"
 echo "上記の設定で実施します。本当によろしいですか？"
read -p $CONFIRMMES


##### ここはスキップします ここから #####
#echo "【NEXTCLOUD】環境構築 KUSANAGI環境 初期化コマンド実行"
#read -p "Press [Enter] key to move on to the next.";

#初期化
#kusanagi init --tz Asia/Tokyo --lang ja --keyboard en --passwd ${kusanagipass} --nophrase --dbrootpass ${dbrootpass} --mariadb10.5 --httpd24 --php81
##### ここはスキップします ここまで #####


echo "【Kusanagi】LAMP環境構築 KUSANAGI プロビジョニングを実施します"
echo "作成するプロファイルの名前は、$kusanagiprofile です。"
read -p $CONFIRMMES

kusanagi provision --lamp --dbname=${dbname} --dbuser=${dbuser} --dbpass=${dbpass} --email=${email} --fqdn ${FQDN}  ${kusanagiprofile}
echo "【Kusanagi】LAMP環境構築 KUSANAGI プロビジョニングを完了しました"
