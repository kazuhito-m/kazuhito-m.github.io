---
published: false
layout: post
title: Dockerで使う「ディスク上の場所」をお引越し
category: tech
tags: [docker,tomcat]
---

こちらも「二度程やってるのに、ソラで書けなくて必ずググる」ので、メモっておきたいなと思いました。(小並)


# 前提

- Ubuntu 16.04 LTS
- 移動先は、`/(rootのHDD)` マウントとは別HDDにしたい `/strage/01/docker` にデータを引っ越したい
- Dockerはインストール済み
- Dockerのインストールは [本家のやり方](https://docs.docker.com/engine/installation/linux/ubuntulinux/) で `sudo apt-get install docker-engine` でおこなっている
- Dockerの設定はデフォルトで弄ってない
  - `/usr/bin/docker` に [setuid](https://ja.wikipedia.org/wiki/Setuid) で+sして一般ユーザで叩けるようにしたくらい
  - 「Dockerのデータファイル群のpath」はデフォルトの `/var/lib/docker`

# やったこと

基本「主となる一般ユーザ」でコマンド叩いてることとします。

## 準備

引っ越し先の「親フォルダ」を用意する。

```bash
mkdir -p /strage/01

```

一般ユーザで作っちゃいましたね…ま、dockerはデーモンで走るし、rootだから良いでしょ。

## Docker止める

```bash
sudo systemctl stop docker
```

## 現状の「Dockerのデータファイル群」をコピーする

```bash
sudo cp -ar /var/lib/docker /strage/01/
```

## Dockerが見ている「Dockerのデータファイル群のpath」を変更する

おそらく「移動して`ln -s`でシンボリックリンクを張る」だけでも良いと思うのですが、設定を覚えるために「Docker自体の設定変更」をします。

本来は `/etc/defaults/docker` に設定があるのですが、「systemd使ってたら無効」で、かつ自分の環境がまさにそうなので、以下の変更を行います。

```bash
sudo vi /lib/systemd/system/docker.service

# 以下をコメントアウト、追記する。
# ExecStart=/usr/bin/docker daemon -H fd://
ExecStart=/usr/bin/docker daemon -H fd:// -g /strage/01/docker
```

自動生成のファイルなので、AsCodeするときは工夫が必要そうですが、「ここに起動設定があってコマンドラインパラメタが書ける」ということは覚えておきたいトコです。

systemdに設定をリロードさせておきます。

```bash
sudo systemctl daemon-reload
```

## Docker起動&確認

```bash
sudo systemctl start docker

docker images

REPOSITORY               TAG                   IMAGE ID            CREATED             SIZE
tomcat                   9.0-jre8-alpine       e2149d7b90b9        12 days ago         135.3 MB
...

# いくつかのイメージが表示されてたらOK
```

本当に「指定した場所を使ってるか」を確認するため、イメージなどをDLしてみましょう。


```bash
# ディレクトリの総容量を出す
sudo du -s /strage/01/docker
10343400 /strage/01/docker
# 適応なdockerイメージを落としてみる(イメージに他意はありません）
docker pull hjd48/redhat
# 再度ディレクトリの総容量を出す
sudo du -s /strage/01/docker
10788152 /strage/01/docker
```

大丈夫そうですね。

## 元のディレクトリを削除

そもそも、これを減らすためにやったので、これを忘れてはいけません。

```bash
sudo rm -rf /var/lib/docker
```

---

# 小並感

`/var/lib` に在るのは「正しい設計」なのですが、端末でもサーバでも「容量が足りなくなる -> 増設 -> 別ドライブ」ということが多いとおもうのです。

だから「後から変えたい」と思うことは多いのですが…(ま `/ver` 自体を引っ越しor最初から増設できるとこにするのが正しい姿だとは思いますが)

「後からの設定変更の情報が少ない」のと「環境ごとにわりと違う（公式の設定ファイルが無効だったり）」のは、ちょっとメモっておきたいかなと思いました。

# 参考URL

以下を参考にさせていただきました。感謝。

- [http://qiita.com/RyoMa_0923/items/e1174b2951411ddd1d08](http://qiita.com/RyoMa_0923/items/e1174b2951411ddd1d08)
