---
published: false
layout: post
title: PuppyLinuxでサーバ作ってみる
category: tech
tags: [linux,puppylinux,server,install]
---

わざわざ、相性の悪いのをサーバ化せんでも...というのは言うな(泣)

HITACHI FLORA 270 NH1

[http://www.hitachi.co.jp/Prod/comp/OSD/pc/flora/prod/oldmodel/note/spec270nh1_970402.html](http://www.hitachi.co.jp/Prod/comp/OSD/pc/flora/prod/oldmodel/note/spec270nh1_970402.html)

5,6年前にオークションで購入したもの。母親→父親用マシンとして活躍。んで退役。

# やらせる仕事

+ sshd
+ bind(Lan内dnsセカンダリサーバ)
+ Wine(タスクトレイ常駐ソフトのため)
+ smb

と、完全にLan内専用

# 最初にやったこと

+ CDブート出来ないマシンなのでフロッピーでCDブート出来るように始動
	+ SmartBootManagerなるものをフロッピーに突っ込む。んでフロッピー入れたまま電源ON。
+ PuppyLinuxをCDで立ち上げ
+ fdiskでswapとそれ以外全部1ptに。
+ mkfs.ext3,mkswap
+ ハードディスクにインストール
+ ネットワーク設定
+ hostname変更(/etc/hostname,/etc/hosts)
+ chmod 4755 /bin/busybox
+ swapon (これが命綱っぽい)
+ rootパスワード変更
+ 一般ユーザ追加

ここからは、マシン独自設定だな〜。
