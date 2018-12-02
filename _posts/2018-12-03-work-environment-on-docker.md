---
published: true
layout: post
title: SSHトンネリングしたFirefoxを使ってブラウジングする「作業用端末」をDockerで作ってみる#インフラ勉強会
category: tech
tags: [docker,firefox,infrastructur,iac]
cover: "/images/2018-12-03-ipconfig-diff.png"
---

![コンテナ内とPC自体の「リモートホストIP」の比較](/images/2018-12-03-ipconfig-diff.png)

これは [#インフラ勉強会](https://wp.infra-workshop.tech) の [アドベントカレンダー](https://adventar.org/calendars/3022) の三日目です。

前日、二日目は「 [まみー](https://twitter.com/mamy1326) さんの [インフラ勉強会は時間と場所を飛び越える](https://mamy1326.hatenablog.com/entry/2018/12/02/230030) 」でした。

---

自身はプログラマなので、インフラについては「運用に居たことがある」「クラウドの設計することがある」という立場からの参加ですが、今回は「運用やってると各現場に一つはありそう」な、

「__特殊用途の固定作業用端末__」

のお話です。

# これを読んで得られるもの

- 業務で使う「限定された作業用端末」をDockerを使い配布する方法
  - SSHトンネリングでブラウジングする端末をDockerで作成する方法

# 経緯

会社と仕事をしてると「内規で使わなければならないWebアプリケーションがある」とかあると思います。

しかもそれが「社内ネットワークからのみアクセス可能」だったり「IPを固定してそこからしかアクセスさせません」だったりすることがありますね。

実際、最近も

- 発注側からは「仕事の内容を特定の情報サイト(Webアプリ)を使って閲覧・書き込みするように」と指定がある
- 発注側の上記サイトは「固定IPからしかアクセスを許可しない」
- 自分(みうら)は「受注側」の企業の拠点、あるいは「その拠点に繋がる場所」で仕事をしており、かつ「発注側の情報サイトを使う仕事」がある

という条件なので、以下のような形態で仕事をしていました。

![ネットワークと仕事全体像](/images/2018-12-03-network-and-work.png)

SSH(鍵認証)で入ることが出来るサーバを用意し固定IPを付け、そこを踏み台として「拠点の固定端末」or「(みうらの)自宅の作業PC」から、情報サイト(Webアプリ)にアクセスしていました。

「サイトを見るためのサーバを用意する」というのも手間ですが、改善したかったのは「特殊な設定をした固定端末やPC」の方で、今回はそれを扱います。

![固定端末やPC](/images/2018-12-03-special-console.png)

- 拠点に固定で物理端末を置いている
- 外部からアクセスするときには、「ブラウザの設定やポートフォワーディングを仕込む”手順書”に従った作業をする」
- 上記手順に従って設定すると「環境を汚す」

ということから「この端末の用意をDockerで出来ないか」と思ってやってみました。

# やったこと

## どんなものを作ったのか

こちらにあります。

<https://github.com/kazuhito-m/dockers/tree/master/portforwarding-webbrowsing>

この `Dockerfile` / `docker-compose.yml` を、ローカルPCで build&run すると、以下のようなことが出来るようになっています。

![コンテナを含めた構造](/images/2018-12-03-container-structure.png)

1. ローカルPCのブラウザで <http://localhost:6080> を表示すると、コンテナ内の `NoVNC(httpで動くVNCビューア)` により「VNCのデスクトップ」が表示される
0. VNC内では自動起動で `firefox` ブラウザが表示されてるが、設定で「localhost:11080をproxyとするように」なっている
0. localhost:11080 は「sshコマンドにより、 `固定IPを持った公開サーバ` にhttp/httpsをトンネリング」している
0. 前述の `firefox` に指定したURLは `固定IPを持った公開サーバ` 上からhttp/httpsリクエストが投げられ、結果が帰ってくる

## 起動方法

以下を満たしていることを前提とします。

- ローカルマシンに `docker` と `docker-compose` がインストールされている

### 設定ファイルを書く

[前述のソース一式](https://github.com/kazuhito-m/dockers/tree/master/portforwarding-webbrowsing) をダウンロードすると、以下のファイル構造になっていると思います。

```
.
├ Dockerfile
├ docker-compose.yml
├ resources
│ ├ config.sh
│ └ ssh_tonnering_key.pem
└ scripts
  ├ boot.sh
  └ init_firefox.sh
```

`./resources/config.sh` を以下の通り設定して下さい。

```bash
#!/bin/bash
export SSH_KEY_FILE=/ssh_tonnering_key.pem
export SSH_PROXY_PORT=11080
export SSH_HOST=[固定IPを持った公開サーバ]
export SSH_USER=[固定IPを持った公開サーバのログインユーザ]
export SSH_PORT=[固定IPを持った公開サーバのSSHポート]
export BROWSER_DEFAULT_URL=[firefoxにデフォルトで表示したいURL]
```

### 「固定IPを持った公開サーバ」用の鍵を配置する

`./resources/ssh_tonnering_key.pem` に「固定IPを持った公開サーバの秘密鍵ファイル」を指定して下さい。

( `ssh -i [秘密鍵ファイル]` のように指定するファイルです。)

### Dockerのbuild & run

以下を実行します。

```bash
docker-compose up
```

しばらくして、ブラウザから <http://localhost:6080> を指定し表示すると「設定ファイルの `BROWSER_DEFAULT_URL` に指定したページが表示された `firefox` の画面」が表示されてくるはずです。

---

試しに、以下の設定( `./resources/config.sh` )で起動するとします。

```bash
export SSH_HOST=[AWSインスタンスのIP(AmazonLinux)]
export SSH_USER=ec2-user
export SSH_PORT=22
export BROWSER_DEFAULT_URL=https://ipconfig.io
```

デフォルトページの <https://ipconfig.io> は「リモートホストを表示する」サイトです。

上記設定で `docker-compose up` し、 <http://localhost:6080> を表示してみます。

(`./resources/ssh_tonnering_key.pem` には「AWSインスタンスの秘密鍵」を配置しているものとします。 )

![コンテナ内とPC自体の「リモートホストIP」の比較](/images/2018-12-03-ipconfig-diff.png)

奥のブラウザが「コンテナの内容を表示しているブラウザ画面」ですが、手前のものは「ローカルPC自体のブラウザで <https://ipconfig.io> を表示したもの」です。

ページ左上の赤い部分は「リモートホストIP」で、異なっていることがわかります。

これは「コンテナの中のブラウザの結果は別のリモートホスト(AWSインスタンスのIP(AmazonLinux))でリクエストし返してきた結果である」ためです。

# 所感

「特殊な設定(トンネリングを仕込む、など)をした端末」って、サービスのメンテでもインフラの仕事でも必要になることがあると思います。

ただ、ブラウザの設定とか「GUIの設定も含む」と、途端に「長大な手順書を用意して」とか「各自端末を汚す」「個人で設定するのを強いる」とか、そういうことになりがちで…。

そういうとき「インハウスリポジトリから`docker run` のワンライナーで落として実行」などできると、すごく便利なんじゃないか？と思いやってみました。

トレーサビリティが気になる方は、ログ等「立ち上げてアクセスされたら解る仕組み」も自動で設定しておくのも良いかもしれません。


---

[アドベントカレンダー](https://adventar.org/calendars/3022) 、次は四日目 [porinkysan](https://twitter.com/porinkysan) さんの「」 です。

# 参考

以下を参考にさせていただきました。

- どこへ行っても安心！SSHサーバーを踏み台にしてWebアクセスする方法
  - <https://linuxfan.info/ssh-dyamic-forward>
- OpenBox man page
  - <https://www.mankier.com/1/openbox>
- DockerImage : docker-headless-vnc-container
  - <https://github.com/ConSol/docker-headless-vnc-container>
- Supervisorで簡単にデーモン化
  - <https://qiita.com/yushin/items/15f4f90c5663710dbd56>
