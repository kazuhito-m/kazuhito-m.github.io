# postgresqlのTips

すぐ忘れるので、メモ。

## pgAdmin3のエクスポートをコマンドでレストア

普通のSQLではない？いまいちわからない。

pg_restore なら出来る。

```bash
pg_restore -h localhost --username=postgres --dbname=database --verbose ./test.backup
```


## INSERT文形式でエクスポート

復元可能な状態にして、データを削ったのち…

```bash
pg_dump -h localhost -U databaseuser --table=user --data-only --column-inserts publicadmin > ./user.sql
```
