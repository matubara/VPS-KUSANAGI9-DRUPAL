#!/bin/bash
#####################################################################
# NEXTCLOUDリストアスクリプト                                       #
#####################################################################
# 第一引数を取得する（実行モードを指定する）
if [ $# -eq 1 ]; then
  # 自動実行: AUTO
  EXECMODE=$1
  echo "リストアスクリプトを自動モード（Cron実行モード）で実行します"
else
  # 手動実行: MANUAL
  EXECMODE=MANUAL
  echo "リストアスクリプトを手動モードで実行します"
fi

# ドキュメントルートのパスを設定
DOCUMENTROOT_PATH=/home/users/1/main.jp-sincerewill/web/mirror2024.sincerew.biz/

# スクリプトファイルが存在するパスを指定
SCRIPT_PATH=${DOCUMENTROOT_PATH}sh/
# バックアップファイルが存在するパスを指定
#BACKUPDIR=${DOCUMENTROOT_PATH}backup/
BACKUPDIR=/home/users/1/main.jp-sincerewill/TRANSFERED_FROM_LOLIPOP_SINCERE_SERVER/

# バックアップファイルを解凍したフォルダ内のドキュメントルートを絶対パスで指定
DOCUMENTROOT_IN_BACKUPFILE=${DOCUMENTROOT_PATH}home/kusanagi/nextcloud2024jul/DocumentRoot/

# バックアップファイルにサフィックスがある場合は指定
#SUFFIX=_online
SUFFIX=

# ファイル圧縮コマンドのオプションを指定
#ARCHIVE_OPTION="-xfmp"
#ARCHIVE_OPTION="-zxfmp"
ARCHIVE_OPTION="-zxf"

# バックアップファイルの拡張子を指定
#EXTENTION="tar"
EXTENTION="tar.gz"

# ちなみにファイル名は以下の通り
# 更新済みかどうか updatedflag{固定サフィックス}.txt
# バックアップ日付（ファイル名のプリフィックス） latestfile{固定サフィックス}.txt
# NEXTCLOUDフォルダ圧縮ファイル {バックアップ日付}nextcloud{固定サフィックス}.tar
# DATAフォルダ圧縮ファイル {バックアップ日付}data{固定サフィックス}.tar
# バックアップ日付SUFFIX latestfile{固定サフィックス}.txt

# PHP実行ファイル（コマンド）のパスを設定する
PHP_CMD="/usr/local/php/8.2/bin/php"


#すでにリストア処理済みかどうか判定する
echo BACKUPDIR=${BACKUPDIR}
if [ -f ${BACKUPDIR}updatedflag${SUFFIX}.txt ]; then
    #rm -f ${BACKUPDIR}updatedflag${SUFFIX}.txt
echo ok
else
    #すでにリストア済みのため終了する
    echo "すでにリストア済みのため終了する（updatedflag.txtが存在しない）"
#    exit
fi 


echo "リストア処理を開始してもよいですか?"
if [ ${EXECMODE} != "AUTO" ]; then read -p "Press [Enter] key to move on to the next."; fi

# メンテナンスモードをONにする
${PHP_CMD} ${DOCUMENTROOT_PATH}nextcloud/occ maintenance:mode --on

#一時フォルダのファイルを削除する（念のため）
rm -rf ${DOCUMENTROOT_IN_BACKUPFILE}nextcloud
rm -rf ${DOCUMENTROOT_IN_BACKUPFILE}data

# バックアップファイルの日付プレフィックスを取得する
SYSDATE=`cat ${BACKUPDIR}latestfile${SUFFIX}.txt`_
echo "backup date=${SYSDATE}"


#echo "mysql -u LAA1592052 -psincere2024 -h mysql305.phy.lolipop.lan LAA1592052-mirror2024 < ${BACKUPDIR}${SYSDATE}nextcloud_db${SUFFIX}.sql"
#exit 0


# ファイルの展開と更新処理

# NEXTCLOUDフォルダ
echo "nextcloudフォルダを展開してもよいですか?"
if [ ${EXECMODE} != "AUTO" ]; then read -p "Press [Enter] key to move on to the next."; fi

#容量不足のためデータフォルダを削除する
rm -rf ${DOCUMENTROOT_PATH}data

# バックアップファイルからNEXTCLOUDフォルダを展開する
tar ${ARCHIVE_OPTION} ${BACKUPDIR}${SYSDATE}nextcloud${SUFFIX}.${EXTENTION} -C ${DOCUMENTROOT_PATH}
# NEXTCLOUDフォルダをバックアップファイルで上書き更新する
cp -rp ${DOCUMENTROOT_IN_BACKUPFILE}nextcloud ${DOCUMENTROOT_PATH}
# 上書き更新済みの不要な一時ファイルを削除する
rm -rf ${DOCUMENTROOT_IN_BACKUPFILE}nextcloud


#dataフォルダ
echo "dataフォルダを展開してもよいですか?"
if [ ${EXECMODE} != "AUTO" ]; then read -p "Press [Enter] key to move on to the next."; fi

#容量不足のためデータフォルダを削除する
rm -rf ${DOCUMENTROOT_PATH}data

#バックアップファイルからデータフォルダを展開する
echo "EXPAND DATA FOLDER TO TEMPORALLY FOLDER"
tar ${ARCHIVE_OPTION} ${BACKUPDIR}${SYSDATE}data${SUFFIX}.${EXTENTION} -C ${DOCUMENTROOT_PATH}

echo "MOVE DATA FOLDER TO SYSTEM"
#容量不足のためデータフォルダを削除する(直前に再実行)
rm -rf ${DOCUMENTROOT_PATH}data
#解凍されたデータフォルダを本来の場所に移動する（コピーすると容量不足になる）
mv ${DOCUMENTROOT_IN_BACKUPFILE}data ${DOCUMENTROOT_PATH}
# 上書き更新済みの不要な一時ファイルを削除する
rm -rf ${DOCUMENTROOT_IN_BACKUPFILE}data


# 設定ファイルを当サーバー用のファイルに差し替える（ドキュメントルートに必ずおいておくこと）
echo "ドキュメントルートのconfig.phpでnextcloudのconfig.phpを上書きしてもよいですか?"
if [ ${EXECMODE} != "AUTO" ]; then read -p "Press [Enter] key to move on to the next."; fi
#config file
cp -p ${DOCUMENTROOT_PATH}config.php ${DOCUMENTROOT_PATH}nextcloud/config 


# データベースの更新を実施する
echo "データベースの復元を実施してもよいですか?"
if [ ${EXECMODE} != "AUTO" ]; then read -p "Press [Enter] key to move on to the next."; fi
#DATABASE
# バージョン違いで検出されるエラーをスキップするためfオプション（強制実行）を追加
mysql -f -u LAA1592052 -psincere2024 -h mysql305.phy.lolipop.lan LAA1592052-mirror2024 < ${BACKUPDIR}${SYSDATE}nextcloud_db${SUFFIX}.sql
#MAINTENANCE MODE OFF
#/usr/local/php/7.4/bin/php  /home/users/2/main.jp-blogdeoshiete/web/docs.sinceretechnology.biz/nextcloud/occ maintenance:mode --off

# すべての処理が終了したため更新フラグを削除する（以降リストア処理は実施されない）
    rm -f ${BACKUPDIR}updatedflag${SUFFIX}.txt

# メンテナンスモードをONにする（ミラーサイトのため常時メンテナンス画面にしておく）
${PHP_CMD} ${DOCUMENTROOT_PATH}nextcloud/occ maintenance:mode --on

# メールでリストア処理の完了を通知する
echo "NOTIFY COMPLETE TO ADMIN VIA EMAIL"
${PHP_CMD} ${SCRIPT_PATH}diskinfo.php ${DOCUMENTROOT_PATH} cloud2024jul.sincereW.online admin@sinceretechnology.com.au RESTORE
echo "ALL RESTORE HAS BEEN COMPLETED"
