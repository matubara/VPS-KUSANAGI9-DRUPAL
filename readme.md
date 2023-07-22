接続
0_kusaangi-update.shを実行する
アップデート完了後にリブートするためしばらくして再接続

1_kusanagi-init.sh を実行する
※ 以降、完了まで自動的に以下のスクリプトを読み込み完了する



kusanagi statusで確認

RUN 2_build-provision-lamp.sh
この時点でドメインにアクセスするとHTTPSでアクセスできることを確認

プロビジョニングフォルダに移動して3_createDrupalProjectviaComposerを実行

4_installDrush.shを実行
ただし、環境変数が設定できないのでいまは手動で設定する

drush --version が実行できることを確認

5_buildDrupalSite.shを実行

最後に以下のファイル（APACHECONFIG)のドキュメントルートとドキュメントルート設定を変更
/etc/opt/kusanagi/httpd/conf.d/プロビジョニング名

kusanagi restart


DRUPALが参照できることを確認
