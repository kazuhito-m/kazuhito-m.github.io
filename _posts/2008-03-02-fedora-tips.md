---
layout: post
title: Fedora8(にかかわらず？)Tips
category: tech
tags: [linux,cdr]
---

新マシンになって、Fedora8(x86_64)になった。
とはいえ、小さなテクニックは変わらないと思うので、めも。

## Rarを解凍したい

```bash
sudo yum install unrar
```

これにより、Gnomeの解凍ユティリティ(File Roller)で、解凍できるようになる。
…圧縮はどうすんだ？

## cue-bin構成のファイルの取り出し

```bash
sudo yum install bchunk.x86_64
bchunk A.img A.cue Hoge.iso
sudo mount -o loop -t iso9660 Hoge.iso ./Huge
```

素人っぽい疑問だけれど、Rootでないとだめなんかな？
sudoの例をネットじゃぎょうさんみるけど…
