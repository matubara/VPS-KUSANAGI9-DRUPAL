接続
RUN 0_kusaangi-update.sh 
しばらくして再接続

RUN  1_kusanagi-init.sh 
kusanagi statusで確認

RUN 2_build-provision-lamp.sh
この時点でドメインにアクセスするとHTTPSでアクセスできることを確認


プロビジョニングフォルダに移動して3_createDrupalProjectviaComposerを実行

Drupalプロジェクトフォルダに以下ファイルが自動で入る
4_installDrush.sh
4_setenv.sh
5_buildDrupalSite.sh

4_installDrush.shを実行
ただし、環境変数が設定できないのでいまは手動で設定する

drush --version が実行できることを確認

5_buildDrupalSite.shを実行

最後に以下のファイル（APACHECONFIG)のドキュメントルートとドキュメントルート設定を変更
/etc/opt/kusanagi/httpd/conf.d/プロビジョニング名

kusanagi restart


DRUPALが参照できることを確認
