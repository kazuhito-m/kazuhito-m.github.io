# crowi-plusのDockerコンテナ破壊してしまったが復旧させた話

## 起動している際、データはどこにあるのか

- /var/lib/docker/volumsにデータ残ってる
- 拡張子と日付から「MongoDbっぽいコンテナ」を探す
  - ファイルの中身のテキストも「そのまま」なので材料に成る


## Export/Importで復帰させた話(2018/10)

まず、docker-composeで、growiを起動させる。

```bash
git clone https://github.com/weseek/growi-docker-compose.git growi
cd growi
docker-compose up
```

DBのIPを特定する。

```bash
docker inspect growi_mongo_1 | grep 'IPAddress'
...
"IPAddress": "172.20.0.2",
```

172系アドレスが、それに当たる。ここに対して、DB操作を行う。

試してみると、以下の方法だけでdump/restore出来た。

```bash
mongodump --db growi --host=172.20.0.2
mongorestore --host=172.20.0.2
```

MongoDBは、

```
host
  - dbs : DBのようなもの
    - collection : テーブルのようなもの
```

という概念でできており、GrowiのMongoDBホストは、 admin,growi,localというDBSを持ち、そのうちgrowiがGrowiのデータを保持するDBSです。

dumpすると、直下に `./dump/growi` というフォルダが出来て、そこにデータがBSON形式で出力されています。

復元するときは、DBを指定せずとも「./dump以下の構造」によって、growiのDBSを上書きします。

ただ、このデータはヒューマンリーダブルではないので、確認用にはexportコマンドでjson出すのが良さそうです。

```bash
mongoexport --db growi --host=172.20.0.2 --collection users --out ./users.json
```

## 参考

- CrowiをCentOSに入れる(一般的概念)
  - <https://qiita.com/bezeklik/items/48fe054c2df05f03f3d1#redis>
  - <https://qiita.com/oshuya/items/bd12cd40d4ba49c3f00b>
- docker-crowi
  - <https://github.com/crowi/docker-crowi/blob/master/Dockerfile>
  - <https://stackoverflow.com/questions/34559557/how-to-enable-authentication-on-mongodb-through-docker>
- メモリ不足でElasticsearchが動かない問題(未解決)
  - <https://github.com/docker-library/elasticsearch/issues/111>
- MongoDBのUPDATE
  - <https://docs.mongodb.com/manual/reference/method/db.collection.update/>
  - <https://specify.io/how-tos/mongodb-update-documents>
- MongoDBのコンパクト化
  - <https://docs.mongodb.com/manual/reference/method/db.repairDatabase/>
  - <https://qiita.com/irasally/items/a3fda132a222ab98ce70>
  - <http://eiua-memo.tumblr.com/post/145047075142/mongodbのデータ容量の削減にはcompactコマンドを使う>
- MongoDBのデータ保存先
  - <https://qiita.com/peroon/items/440b18ba59d7f837fc98>
- MongoDBのバックアップトレストア
  - <http://tm8r.hateblo.jp/entry/20110623/1308841753>
  - <https://qiita.com/bohebohechan/items/55e873d6948a5e89eff5>
  - <https://qiita.com/SkyLaptor/items/d02b702764428a08e3f5>
  - <https://qiita.com/shiromi/items/ec266e423d7b273cd239>
- ファイルシステムでrmしてしまったもののサルベージ
  - <https://unskilled.site/linux%E3%81%AE%E6%81%90%E6%80%96%E4%BD%93%E9%A8%93%E3%80%8Crm%E3%81%A7%E9%96%93%E9%81%95%E3%81%A3%E3%81%A6%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E6%B6%88%E3%81%97%E3%81%A6%E3%81%97%E3%81%BE%E3%81%A3/>
  - <http://d.hatena.ne.jp/y-kawaz/20110123/1295779916>
- Docker volumeの削除
  - <https://qiita.com/Ikumi/items/b319a12d7e2c9f7b904d>
