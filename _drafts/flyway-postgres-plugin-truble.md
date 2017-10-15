---
published: false
layout: post
title: (仮)FlywayでPostgresqlを扱う場合、拡張機能の管理テーブルが削除出来ない場合
category: tech
tags: [flyway, posgresql, trubleshoot]
---

# flywayClean を実行した際、拡張機能の管理テーブルが削除できなくて失敗する

```bash
./gradlew clean compileTestJava flywayClean

:clean
:processResources
:compileJava

...

:flywayClean FAILED

FAILURE: Build failed with an exception.

* What went wrong:
Execution failed for task ':flywayClean'.
> Error occurred while executing flywayClean
  Unable to drop "public"."spatial_ref_sys"
  ERROR: 拡張機能 postgisが必要としているためテーブル spatial_ref_sysを削除できません
    ヒント: 代わりに拡張機能 postgisを削除できます
```

これは `postgis` という拡張機能が使っている管理テーブルである `public.spatial_ref_sys` を削除できないから、という理由である。

publicスキーマのテーブル全てを消せなければ、flyway的には初期化にならない。

# 世の中はどうしてるのか

[ここ](https://github.com/flyway/flyway/issues/100) によると、

1. `DROP EXTENSION` を `flywayClean` 時に実行するようにする
0. 最初のマイグレーションに `CREATE EXTENSION` 行を追加する

ということで `beforeClean.sql` に、追加する。

```
DROP EXTENSION;
```

postgis用の管理テーブルを削除できるように、拡張を削除する。


# 参考サイト


- [DROP EXTENSION(マニュアル)](https://www.postgresql.jp/document/9.4/html/sql-dropextension.html)
- [CREATE EXTENSION(マニュアル)](https://www.postgresql.jp/document/9.3/html/sql-createextension.html)
- [解決方法の書いたissue](https://github.com/flyway/flyway/issues/100)
