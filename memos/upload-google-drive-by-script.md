# GoogleDriveへファイルをbashのみでアップロードする

TODO 大まかには描いているが、未完成なので盛る。

- 使うスクリプト
  - <https://github.com/labbots/google-drive-upload>
- GoogleDriveAPIを使うためのクライアントID/Secretなどの取得
  - <https://qiita.com/jordi/items/aa9f86cf92e04a8089db>
- スクリプトが使うコマンド(本家リポジトリに描いてある)
  - curl, sed, find, awk, getopt
- 自身が使うコマンド
  - git

## 作ったPostgresDBのバックアップ＆アップロードスクリプト(例)

```bash
#!/bin/bash

echo 'postgress のパスワードファイル作成。'

echo "localhost:5432:db:user:password" > ~/.pgpass
chmod 600 ~/.pgpass


echo 'pg_dump実行。'

dump_file="./pgdump_`date '+%Y%m%d%H%M%S'`.dump"
pg_dump -h localhost -U user db > ${dump_file}
gzip ${dump_file}


echo 'GoogleDriveダウンロード用スクリプトをダウンロード。'

git clone https://github.com/labbots/google-drive-upload.git



echo 'GoogleDriveアクセス用の設定ファイル作成。'

cat << EOS > ./googlekey.conf
CLIENT_ID=xxx.apps.googleusercontent.com
CLIENT_SECRET=yyy
EOS

echo 'REFRESH_TOKEN=zzz' > ~/.googledrive.conf


echo 'GoogleDriveアップロード実行。'

./google-drive-upload/upload.sh --config ./googlekey.conf -v -r drive_id ${dump_file}.gz
```
