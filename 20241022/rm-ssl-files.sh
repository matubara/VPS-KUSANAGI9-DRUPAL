name=apptest
echo このスクリプトはROOT権限で実行してください
if [ -d /etc/letsencrypt/live/${name}.sincerew.online ]; then
echo "folder exists in live"		
sudo rm -rf /etc/letsencrypt/live/${name}.sincerew.online
fi

if [ -f /etc/letsencrypt/renewal/${name}.sincerew.online.conf ]; then
echo "file exists in renewal"		
sudo rm -f /etc/letsencrypt/renewal/${name}.sincerew.online.conf
fi

if [ -d /etc/letsencrypt/archive/${name}.sincerew.online ]; then
echo "folder exists in archive"		
sudo rm -rf /etc/letsencrypt/archive/${name}.sincerew.online
fi
exit
