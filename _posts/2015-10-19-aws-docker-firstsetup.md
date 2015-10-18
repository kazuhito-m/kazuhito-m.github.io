---
layout: post
title: (AWSなど)仮想機に最速で「その時最新のDockerをインストールする」方法
category: tech
tags: [linux,aws,docker,setup,howto]
---

クラウドのサーバを「いくつでも作れる実験場」にするため「手っ取り早くDocker入れたい」と思うことが多いのです。

しかし

+ パッケージ管理任せなら微妙に古い
+ パッケージ管理にリポジトリ足すのも大業
+ DockerMacineで入れるのもおっくう
+ セットアップ自体にも時間かけたくない

からの「コマンド連打で最速で入れる」例をメモりました。

最早を目指したので「こまけーことはいいんだよ！」仕様になっておりますが、使う場合は自己責任で。

# 前提

+ テストしたのはAmazon Linux
    + おそらくAWSに用意されてる最近のLinux(UpStart式)なら大体行ける…はず
+ デフォルトユーザの"ubuntu"でログインしており、sudoが使えること


# オペレーション

```bash
# Docker本体
sudo wget https://get.docker.io/builds/Linux/x86_64/docker-latest -O /usr/bin/docker
sudo chmod +x /usr/bin/docker
# daemon startup 設定
sudo wget https://raw.githubusercontent.com/dotcloud/docker/master/contrib/init/upstart/docker.conf -O /etc/init/docker.conf
sudo initctl reload-configuration
sudo initctl list | grep docker
sudo initctl start docker
# 一般ユーザで叩ける設定
sudo chmod +s /usr/bin/docker

```

これで、`docker version`、`docker ps` など叩いてみて、いつものDockerならOKです。

---

あとはコンテナ動かしてみるのみ。


試しに「最新Jenkins」を立ち上げてみる例を示します。 (要8080ポート開け)

```bash
docker run -d -p 8080:8080 jenkins:latest
```

---

ログインしてからは数分でDocker＆コンテナ立ち上がりは気持ちが良いですね。

パッケージ管理からは離れますが、最初のwget叩き直せば一応VerUPにも対応できなくは無いので「そんなに重要じゃないが砂場にしたい」時にはおすすめです。


