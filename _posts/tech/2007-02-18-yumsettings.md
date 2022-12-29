---
layout: post
title: yum系で行った作業を備忘録
category: tech
tags: [linux,yum,movie,sound]
---

Mplayerとか入れたいので、このサイトからyum系設定をしました。

[http://www.hyde-tech.com/HideWeb/fedora_core_6_installation_notes.html#Yum](http://www.hyde-tech.com/HideWeb/fedora_core_6_installation_notes.html#Yum)

## マルチメディアコーデック

```bash
mkdir tmp
cd tmp
wget http://www3.mplayerhq.hu/MPlayer/releases/codecs/all-20061022.tar.bz2
mkdir /usr/local/lib/codecs/
mkdir /usr/lib/win32
tar xvfj *.tar.bz2
rm *.tar.bz2
cp ./all-20061022/* /usr/local/lib/codecs/
chmod 755 /usr/local/lib/codecs/*
cp /usr/local/lib/codecs/* /usr/lib/win32/
rm -rf ./all-20061022*
```

## MPlayerインストール

```bash
yum -y install mplayer mplayer-skins mplayer-fonts
```

## xmmsインストール
