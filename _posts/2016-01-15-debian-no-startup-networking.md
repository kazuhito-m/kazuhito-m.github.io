---
published: false
layout: post
title: 割と古めの特殊事情なDebianサーバで「再起動したらネットワーク繋がらなくなった」話
category: tech
tags: [linux,debian,servcie,iss]
---

[コレ](/tech/2016/01/13/md-raid-hdd-restore) の時に

+ 古いDebianが入っているNASで再起動したらログインできなくなった
+ そのDebianは「ARMかつそのNAS用に用意されたOSイメージ」だったが、特殊性を感じてなかった

というハマりから、知見を得たので自分用メモとして書き残します。

# 現状確認

とりあえず、何も考えずに「ネットワークサービスの起動コマンド叩く」をしてみる。

```bash
sudo /etc/init.d/networking start
```
これだけで、接続可能になったので、

+ ネットワークを起動する機構自体は正常
+ スタートアップの設定がおかしい

ということはわかった。
