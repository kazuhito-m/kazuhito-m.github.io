---
layout: post
title: ubuntuにMplayer+wmvコーデック+DVDとか動画再生関係インストール
category: tech
tags: [linux,ubuntu,multimadia]
---

とりあえず、一通り、なんでも再生できるようにしてみます。[ここ](http://u-mex.plala.jp/index2.php?Ubuntu%A4%C7%C6%B0%B2%E8%BA%C6%C0%B8)参照。

# やったこと

## medibuntuリポジトリの追加

リスト追加＆key取得

```bash
sudo wget http://www.medibuntu.org/sources.list.d/gutsy.list -O /etc/apt/sources.list.d/medibuntu.list
sudo apt-get update && sudo apt-get install medibuntu-keyring && sudo apt-get update
```

## 基本的なパッケージをインストール

```bash
sudo apt-get install libdvdread3
sudo /usr/share/doc/libdvdread3/install-css.sh
sudo apt-get install lame sox ffmpeg mjpegtools mpg321 vorbis-tools
```

## totem-gstreamer入れる

ネットワーク越しでの再生できるのでおすすめとのこと

```bash
sudo apt-get install totem-gstreamer gstreamer0.10-plugins-*
```

## mplayerを入れる

```bash
sudo apt-get install mplayer
sudo sed -i.backup -e 's@vo=x11,@vo=xv,@g' /etc/mplayer/mplayer.conf
sudo apt-get install mozilla-mplayer
```

## win32codecを入れる

```bash
sudo apt-get install win32codec
```

## DVD再生用にxineを入れる

```bash
sudo apt-get install libxine1-plugins xine-ui
```

---

Fedora8(x86_65) + mplayer で、WMVの再生諦めていただけに、感動♪

穴あると思うから、指摘あればお願いします。
