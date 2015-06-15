---
published: false
layout: post
title: エミュレータ＆DTMソフトのインストール
category: tech
tags: [linux,dtm,game,emulator]
---

かねてから興味があったもの、Linuxならインストール簡単♪、てことでインストールしました。

## ファミコンのエミュレータ「FCE Ultra」

以下のURLからバイナリをダウンロード

http://fceultra.sourceforge.net/

解凍後、バイナリビルド、インストールする。
$./configure
#make install

起動方法は、以下のとおり。UIが欲しいのだよなあ…
$ fceu -inputcfg gamepad1 /dev/input/js0 [ファイル名]

## DTMソフト「ardour(Version 2)」

以前から入れていたのだが、世の資料がすべて最新版なので入れる。

Fedora 6用のrpmを入れるため、リポジトリを追加。(planetccrma)

# rpm -Uvhhttp://ccrma.stanford.edu/planetccrma/mirror/fedora/linux/planetccrma/6/i386/planetccrma-repo-1.0-3.fc6.ccrma.noarch.rpm

で、yumでインストール。
# yum install ardour2.i386

今のところ動いているが、もうちょっと使ってからでないと、不具合はわからないな。

ベーシックなエフェクト(リバーブ、ディレイなど)はどうやってかけるんだろう。
VSTしかないのかなあ。VSTだったとしても、Wine絡めな動かんっていうしなあ。
