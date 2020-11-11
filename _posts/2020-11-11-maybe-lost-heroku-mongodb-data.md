---
published: true
layout: post
title: Herokuの”mLab MongoDB add-on"が廃止された…のを知らずに慌てたハナシ
category: tech
tags: [heroku,mongodb,howto]
---

# これを読んで得られるもの

- HerokuでMongoDBを扱うアプリケーションをデプロイしていて、かつ2020/11/11頃に「接続不能」になった時の解決策がわかる

# 事象

## 事の発端

- 2020/10/11頃から、Herokuで`GROWI` という「MongoDBをバックエンドにするアプリ」を運用し始めた
- 2020/11/11の朝に以下のような画面が出て、アプリが動かなくなった
  - ![MongoDB接続不能](/images/2020-11-11-heroku-mongo-notconnect.png)
- ログを見ると「MongoDBがデタッチされた」と出ている
  - ![DetachMongoDB](/images/2020-11-11-detach-mongodb.png)
- ググると「今日(米時間での期日である10日)が”mLab MongoDB add-on”のサービスの終了日」と知る
  - 2020/07月からアナウンスされていたらしいが、2020/10から運用し始めた自分は知ったこっちゃない
- Herokuコンソールからも「mLab MongoDB add-on」のアドオン設定が消えてて「データロストか…」と青ざめる

## 廃止された「Heroku内の”mLab MongoDB add-on」とは、どんなものだったのか？

基本「GROWIの"Deploy to Heroku”任せで構成を作った」ので、”mLab MongoDB add-on"というものが何か解ってなかったのですが…。

”mLab MongoDB add-on"は「HerokuでMongoDBを扱う場合の定番」だったようで、多くのアプリケーションで使われてると思われるadd-onです。

今回のデプロイアプリである `GROWI` もそうなのですが、"Deploy to Heroku”タイプのアプリであれば、「構成上で自動で使われる」など、無意識で使ってる方も多かったのでは？と思います。

「MongoDBのストレージサービス(mLab)へのインスタンス作成・接続を勝手にやってくれるAdd-on」だったらしく、「じゃあその本体(mLab)へのログインとかどうすんの？」つーてーと、その「失われたサービス内に自動ログインの口が在った」らしいす。

…ま、上記も「もう消え去ったサービスを調べた結果」だったりするので、見ることすらできないのですが。

# データ復旧・アプリ復旧手順

結論的には __公式が案内している別サービス(MongoDB Atlas)に移行__ です。

## mLabからの「Add-on削除したよ」メールを探す

Herokuに登録しているメールアドレスに

`mLab Heroku Add-on Removed! (Heroku app: <アプリ名>)`

という件名のメールが届いているはずなのでそれを探してください。

---

だけだと「なんのこと？」だと思います。

日本語に機械翻訳したものが以下です。

```
mLab からこんにちは、

予定どおり、<アプリ名>Herokuアプリにて、 mLab MongoDBHerokuアドオンがシャットダウンされました。
これは以前に接続されていた、次のmLabでホストされているサンドボックスデータベースに影響を与えました。

- mLab Database Deployment: <デプロイ名っぽいの>
- mLab Admin Username: <ユーザ名>
- mLab Admin Email: <登録メ-ルアドレス>

データへのアクセスを回復するには、すぐにMongoDBAtlasに移行する必要があります。

このmLabアカウントには、ユーザー名「<ユーザ名>」でログインできます。

パスワードがわからない場合は、ユーザー名を入力してくださいリセットフォームにし、
「<登録メールアドレス>」アドレスにメールで届く指示に従ってください。

移行に最も関連するドキュメント：

  Migration FAQ:
  https://docs.mlab.com/mlab-to-atlas/

  Step-by-Step Guide to Migrating a Sandbox Heroku Add-on to Atlas:
  https://docs.mlab.com/how-to-migrate-sandbox-heroku-addons-to-atlas/

このガイドでは、Atlas organizationを作成し、それをmLabアカウントに接続して、
mLabからAtlasへの移行をできるだけ簡単にするために特別に構築された
移行ツールにアクセスできるようにする方法を説明します。

ご不明な点がある場合や問題が発生した場合は、
このメール（support@mlab.com）に返信してサポートを受けてください。

敬具、
mLabサポート
```

mLabさんは「Herokuからはデタッチしたけど(いつまでと名言していないが)データ残してるから、はよ移行して」と言ってます。

このメールで「add-onが裏で自動的に作っていた、mLabアカウントにログインする方法」が解決します。

## mLabにログインし「MonboDBのデータベースがある事」を確認する

先ほどのメールに従い、 https://mlab.com/login/ の ”reset your password” からパスワードリセットし、一度ログインします。

ログインすると、 ”MongoDB Deployments” にて「デプロイされていたDB」が一覧されているので、メールに在った情報と一致しているか確認してください。

## mLab側のMongoDBインスタンスをAtlasへ移行する

以下のサイトを参考に、mLabからAtlasに「データの移行」を行います。

- [HerokuでMongoDBのアドオンのmLabが終了するので、別のMongoBD無料サービスにマイグレーションした時のメモ](https://qiita.com/nobu17/items/ca9ae3d60dc837ca0de0)
  - add-onがデタッチ(消滅)する前の移行手段ですが、やること同じです
- [Step-by-Step Guide to Migrating a Sandbox Heroku Add-on to Atlas](https://docs.mlab.com/how-to-migrate-sandbox-heroku-addons-to-atlas/)
  - 先のメールで案内されていたガイドです

### 中身の確認とバックアップ

(必須な作業ではないので、必要ないと判断すれば飛ばしてください)

ツール任せなので「安全に移行できている」はずですが…

気が気でなかったので、インスタンスが作成された時点で…

- 中入ってコレクションを見る(思しきものが在るかどうか)
- クライアントにバックアップを取る

などしました。

```bash
docker run -it --rm -v "$PWD":/workspace -t mongo:4.4.1-bionic /bin/bash
# ---- ここからDocker内 ----
cd /workspace
mongo "mongodb+srv://<クラスタ名>.jrix1.mongodb.net/<ユーザ名>" --username <ユーザ名>
# コレクションとデータ内容をかくにんするなり、いろいろやって exit;
mongodump --uri "mongodb+srv://<ユーザ名>:<パスワード>@/<クラスタ名>.jrix1.mongodb.net/<ユーザ名>" -o <出力デイレクトリ>
```

## 新しいMongoDBの接続情報を、Herokuのアプリに設定する

Herokuのダッシュボードを表示し、 `Settings -> Config Vars` へ遷移し、`Reveal Config Vars` をクリックし、以下の変数を設定する。

- `MONGODB_URI` : `mongodb+srv://<ユーザ名>:<パスワード>@<クラスタ名>.jrix1.mongodb.net/<ユーザ名>?retryWrites=true&w=majority`

”mLab MongoDB add-on" は、DBを作成する際に「Config Varsに値も作る」のですが、「デタッチ時に削除する」というお行儀の良さ…なので、自力で定義します。

今回、対象アプリが `GROWI` であったためこれだけで復旧しましたが、対象のアプリで上手く接続できない場合は「アプリの設定ファイル等を直接書き換えてみる」などして見てください。

# 所感

「まーちょちょいで直るでしょ」→「おいおいこれはまずいぞ…(絶望と焦り」→「やっぱ公式に備えがあった(気を抜けないが微妙な安堵」

という「精神的な上下の変化での消耗が激しい」トラブルシュートでした。

…その前に「バックアップをこまめに取っていれば問題なかった」ハナシなのですが…。

(HerokuのDBと、GROWIのアプリ内エクスポートは、バックアップ自動化しにくいと個人的には思うのです…。)

# 参考サイト

- <https://docs.mlab.com/how-to-migrate-sandbox-heroku-addons-to-atlas>
- <https://docs.mlab.com/mlab-to-atlas/#migrating-multiple-free-sandbox-databases>
- <https://qiita.com/nobu17/items/ca9ae3d60dc837ca0de0>
- <https://qiita.com/geeknees/items/b7464db94f63ae7a6949>
- <https://qiita.com/svjunic/items/285e9cf20169d70aa1fa>
- <https://qiita.com/toshi1127/items/04ea864bf0cd7125a47d>
- <https://qiita.com/k-staging/items/a386d272abb2c9b92f1a>
- <https://qiita.com/leon-joel/items/2f13172c904b8a14b109>
- <https://garafu.blogspot.com/2017/01/mongodb-backup-restore.html>
