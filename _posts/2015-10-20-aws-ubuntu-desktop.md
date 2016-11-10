---
layout: post
title: AWSのUbuntuにVNC経由のデスクトップ環境を最速で立てる方法
category: tech
tags:
  - linux
  - aws
  - setup
  - howto
  - ubuntu
  - desktop
  - vnc
published: true
---

以前、[Docker内のCentOSでVNCデスクトップ](https://github.com/kazuhito-m/dockers/blob/master/desktop_and_browser_vnc/Dockerfile) はやってたのですが、今度はそれの「AWS✕Ubuntu版」をやってみたので、記録しておきます。

最早を目指したので「こまけーことはいいんだよ！」仕様になっておりますが、それでも良いならご参考に。

# 前提

+ AWS上はUbuntu Server 14.04 LTS
+ ポートはセキュリティグループでTCP:5901を開放している
+ デフォルトユーザの"ubuntu"でログインしている


# オペレーション

以下のコマンドを順番に打っていくだけです。

対話型のやり取りもあるので、完全自動とは行きませんが…。


```bash
# リポジトリ最新化 & 必要なものインストール
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install -y gnome-core ubuntu-desktop tightvncserver
# 途中の「gdmかligtdmか」はgdmを選びました
# 初回、vncserverパスワード決め
vncserver :1
# すぐさま殺す
vncserver -kill :1
# ~/.vnc/xstartup バックアップ＆書き換え
mv ~/.vnc/xstartup ~/.vnc/xstartup.org
grep -v '^x-.*' ~/.vnc/xstartup.org > ~/.vnc/xstartup
cat << _EOS_ >>  ~/.vnc/xstartup
exec gnome-session &
gnome-panel &
gnome-settings-daemon &
metacity &
nautilus -n &
_EOS_
chmod 755 ~/.vnc/xstartup
# vncserver本稼働
vncserver :1
```

パスワード設定やxstartupを外から持ち込めるなら、完全自動化できると思われます。

---

あとは、好きなVNCクライアントから `http://[AWSのインスタンスのIP]:5901` で接続すれば、こんな感じでデスクトップが操作できます。

![なぜAWSで艦コレをしているんだ…](/images/2015-10-20-aws-ubuntu.png)


# Unityはむつかしそう(俺調べ、確定じゃないです)

本来は、上記の作業で「Unity入りのデスクトップが立ち上がる」はずなのですが…。

スクリーンショットを見て頂ければ解るのですが、「GNOMEデスクトップ」です。

「マシンがUnityに対応しているか？」の[Ubuntu日本チーム公式のチェック方法](https://wiki.ubuntulinux.jp/UbuntuTips/Desktop/HowToUseUnity)を試しても、

```bash
/usr/lib/nux/unity_support_test -p
Error: unable to open display
```

と表示されてしまいます。

どうも[世界の人の例(何例か)](https://www.youtube.com/watch?v=ljvgwmJCUjw
)を見ていると「ここまでで完成にしてる」ことが多いので「完全再現は難しい」のかもしれないなーという結論で終わらせています。

---

「デスクトップ環境が動けば」という簡易手段や、GUIでのテストも出来るので、アイディア次第では使えるのではと…これから使っていく予定です♪


# 参考

以下の記事を参考にさせていただきました。ありがとうございます。

+ [https://wiki.ubuntulinux.jp/UbuntuTips/Desktop/HowToUseUnity](https://wiki.ubuntulinux.jp/UbuntuTips/Desktop/HowToUseUnity)
+ [https://www.youtube.com/watch?v=ljvgwmJCUjw](https://www.youtube.com/watch?v=ljvgwmJCUjw)
+ [http://qiita.com/YuukiMiyoshi/items/7777bd36016d8ed1fae2](http://qiita.com/YuukiMiyoshi/items/7777bd36016d8ed1fae2) (tigervncは現在使えなくなってる模様)
+ [http://qiita.com/ryunosinfx@github/items/b28e23f65c74a0f59d03](http://qiita.com/ryunosinfx@github/items/b28e23f65c74a0f59d03)
+ [http://qiita.com/akito1986/items/375e82b420853da1a7c8](http://qiita.com/akito1986/items/375e82b420853da1a7c8kk)
+ [http://server-setting.info/ubuntu/vnc-remote-desktop.html](http://server-setting.info/ubuntu/vnc-remote-desktop.html) (ここのデスクトップ網羅は素晴らしい)
