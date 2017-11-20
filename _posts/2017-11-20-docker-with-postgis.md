---
published: true
layout: post
title: PostGISを有効にしたPostgreSQLのDockerイメージを作成する
category: tech
tags: [postgres,postgis,docker]
---

PostgreSQLのDBは豊富な `EXTENSION` があって良い…のですが、これを「フリーズドライ」するのをいつも悩むのです。

# これを読んで得られるもの

- PostgreSQLに「PostGIS」という `EXTENSION` を追加した状態&有効のDockerイメージ作成方法
  - 転じて「 `EXTENSION` を有効にした状態」でのDockerイメージ作成方法
- 「Create Database済み」など「自身のプロジェクトに最適なDockerイメージ」作成方法

# 経緯

たまたま、お仕事で「PostGISを有効にしたPostgreSQLのデータベース」が必要となりまして。

[PostGIS](https://ja.wikipedia.org/wiki/PostGIS)

「手動インストールの手段を説明したテキスト」が渡ってきたのですが、絶対やりたくないので、Dockernizeをしておこうかと思い立ちました。

…が、

- PostGISをインストールしたイメージが見つからない
- 見つかっても「有効にした状態のDatabaseをイメージにする」手段が解らない

で、試行錯誤したので備忘を書き留めて置きます。

# やったこと

こちらに[一式あります](https://github.com/kazuhito-m/dockers/tree/master/postgres-with-postgis)。

## PostGISをインストールした状態を再現したDockerfile作成

「そのものズバリなイメージ」が無く、本家ではない「PostGISをインストールしたImage」は見つかったので、FROMにそれを使い、以下のカタチにアレンジしました。

```Dockerfile
FROM mdillon/postgis:9.6

MAINTAINER kazuhito_m

# locale settings.
RUN localedef -i ja_JP -c -f UTF-8 -A /usr/share/locale/locale.alias ja_JP.UTF-8
ENV LANG ja_JP.UTF-8

# db intial sql's copy.
COPY init_sql/*.sql /docker-entrypoint-initdb.d/
```

中盤の「locale設定」以外、ほぼ「mdillonさんのイメージのまま」です。

イメージの継承関係は、

- [postgres9.6](https://hub.docker.com/_/postgres/) (本家Officialのイメージ)
  - [md5/docker-postgis](https://github.com/appropriate/docker-postgis) (AppropriateさんのDockerfileをmidillonさんがビルド/イメージ公開したもの)
    - [これ](https://github.com/kazuhito-m/dockers/blob/master/postgres-with-postgis/Dockerfile)

です。

最後の `COPY` は「本家のイメージには `init_sql` へSQLファイルを置いておくと、そこのファイルを取り込んで実行してくれる」という仕組みがあるため、継承先でもそれを踏襲しファイルを取り込むようにしています。

## 初期設定＋Database作成＆PostGIS有効化

上記の通り「初期実行SQLを仕込める」ので、

`init_sql/01_createdb.sql`

というファイルを作り、以下のSQLを記述します。

```sql
CREATE USER postgis_sample_user WITH SUPERUSER PASSWORD 'postgis_sample_user';
CREATE DATABASE postgis_sample ENCODING 'UTF8' LC_COLLATE 'C' TEMPLATE 'template0' OWNER 'postgis_sample_user';
\connect postgis_sample
CREATE EXTENSION postgis;
CREATE SCHEMA AUTHORIZATION postgis_sample_user;
```

ユーザ作成、DATABSE作成、スキーマ作成、と順番にやっています。

キモは「PostGISはDATABASE毎に有効にするもの」であるため、中盤で「データベースに接続し有効化」しています。

---

# 所感

自分は、だいたい「ローカルテストようのDBは、開発プロジェクトごとにDockerでAsCodeして」います。

PostgreSQLは「公式イメージ」が手厚いので簡易なのですが、「 `EXTENSION` が絡むと仕込み方が解らない」という状況になります。

なので、今回みたいな対応がこれからも必要だろうなと思っています。

…複数 `EXTENSION` 仕込む必要のあるやつが出てきたら、Dockerfile紐解いて合成せなあかん…かも。
