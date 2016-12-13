---
layout: post
title: CDブートできないマシンでFloppyで立ち上げる方法
category: tech
tags: [linux,puppy,rescue]
---

本当は、Puppyでのハマりなので、そこに書いたほうがわかりやすかったのかもしれないのですが…。

どちらかというと、固有というよりノンジャンルなので、こちらに。

# やったこと

SmartBootManagerを使う。

[https://help.ubuntu.com/community/SmartBootManager](https://help.ubuntu.com/community/SmartBootManager)

## 手順

やり方は、以下のとおり。

1. UbuntuのCDから、/install/sbm.bin を取ってくる。
0. Floppyへイメージコピーする

## Floppyへのイメージコピー方法

### Windowsの場合

フォーマット後、rawwriteというプログラムを使って、sbm.binを書き込む。

[http://www.chrysocome.net/rawwrite](http://www.chrysocome.net/rawwrite)

### Linux系の場合

```bash
dd if=sbm.bin of=/dev/fd0
```
---

文章にすると簡単なんだけど、ここへたどり着くまで結構かかったんですよねｗ
