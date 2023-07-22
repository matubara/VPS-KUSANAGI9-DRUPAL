echo "【Drupal】環境構築 KUSANAGI アップデート"
read -p "Press [Enter] key to move on to the next.";

rm /var/cache/dnf/metadata_lock.pid

dnf upgrade -y
reboot
