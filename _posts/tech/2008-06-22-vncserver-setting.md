---
layout: post
title: vncserverの設定
category: tech
tags: [vncserver,linux,fedora]
---

一台、遊び用マシンができまして…。

とはいえディスプレイは足りないので、遅いとは知りつつも、VNCサーバ運用しようかと。

※以下は Fedora9@i386

## インストール

は簡単♪

```bash
yum install vnc-server
```

## 設定

以前も設定に迷った記憶が…


```bash
mkdir .vnc
cp -a /etc/X11/xinit/xinitrc ~/.vnc/xstartup
```

### Xmodmapの修正

/etc/X11/xinit/Xmodmap.jpの最初の2行をコメントアウト。

```bash
#keycode 22 = BackSpace
#keycode 49 = Kanji
```


### ユーザ毎にVNCを起動して利用する

```bash
vi /etc/sysconfig/vncservers
```

(個人設定のため設定値は割愛)


一般ユーザで、「vncpasswd」を使い、VNC用パスワード設定

```bash
vncpasswd
```

### デーモン設定

```bash
chkconfig vncserver --level 35 on
```

### ファイアウォール穴あけ設定

```bash
vi /etc/sysconfig/iptables
```

以下設定を追加。

```bash
-A INPUT -m state --state NEW -m udp -p udp --dport 5900 -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport 5901:5909 -j ACCEPT
(何人のユーザで動かすかわからないので、とりあえず9人分)
```

### iptables 再起動

```bash
service iptables restart
```

再起動、挙動確認。

…したけど、リモートの一般ユーザ用では、サウンドとかが動かせない上、クソ遅いw
スクリーン番号0指定して、そのマシンのスクリーンを乗っとれば、問題ないですけど。

ディスプレイもう一個買うかあw
