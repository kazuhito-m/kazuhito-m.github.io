---
published: false
layout: post
title: Linux Software RAID(md)のRAID1ディスクを一撃で認識不能にした話
category: tech
tags: [linux,debian,servcie,iss]
---

# 現状確認

以下の状態になり…顔面蒼白…からのスタートでこの記事は始まります。

+ mdのディスクの健康状態から、一本ディスク抜く
+ 新しい新品のディスクを交換すべく筐体あけて取り替え
  + その際一つ前のディスク(/dev/sdc,dがRAID1で、/dev/sdbのディスク)は破損状態だったので物理的に撤去
+ ドライブレイターずれているにもかかわらずRAID1のあーだこーだして再起動
+ あれ、RAIDアレイ消えてるぞ？
+ 元のディスク両方からRAID情報が消失臭い(判定をされている)

# やったこと

## 現状認識

まず、近所のマシンに「RAID1のディスク」を２つつなぎ、状態を確認します。

```bash
ls -l /dev/sd*
brw-rw---- 1 root disk 8,  0  1月 17 00:07 /dev/sda
brw-rw---- 1 root disk 8,  1  1月 17 00:07 /dev/sda1
brw-rw---- 1 root disk 8, 16  1月 17 00:07 /dev/sdb
brw-rw---- 1 root disk 8, 17  1月 17 00:07 /dev/sdb1
brw-rw---- 1 root disk 8, 32  1月 17 00:07 /dev/sdc
```
おかしい…sdbとsdcがRAIDディスクだったはずなのに…sdcのパーティションが切られてない。

gdiskを起動すると…

```bash
gdisk /dev/sdc
GPT fdisk (gdisk) version 0.7.2
〜〜
****************************************************************************
Caution: Found protective or hybrid MBR and corrupt GPT. Using GPT, but disk
verification and recovery are STRONGLY recommended.
****************************************************************************
```
とか言われる。どうやら一個のディスクは「パーティションテーブルも吹っ飛んでる」模様…。

恐る恐る…バックアップからの復元を試みる。

```bash
gdisk /dev/sdc
〜〜
Command (? for help): r
recovery/transformation command (? for help): b
recovery/transformation command (? for help): c
recovery/transformation command (? for help): w
```

超脅されるので怯えながら作業をし…PC再起動。

```bash
brw-rw----. 1 root disk 8,  0  1月 17 01:03 /dev/sda
brw-rw----. 1 root disk 8,  1  1月 17 01:03 /dev/sda1
brw-rw----. 1 root disk 8, 16  1月 17 01:03 /dev/sdb
brw-rw----. 1 root disk 8, 17  1月 17 01:03 /dev/sdb1
brw-rw----. 1 root disk 8, 32  1月 17 01:03 /dev/sdc
brw-rw----. 1 root disk 8, 33  1月 17 01:03 /dev/sdc1
```

ふう…ここからか。先がおもいやられるなｗ

## mdadmでのディスクの状態確認

## スーパーブロックを回復…できないか？

TODO 結論的にはできなそいう

## Linuxのドライブとしての状態確認

## Linuxのコマンドによる「取れるファイルだけ取る」サルベージ

### foremost

```bash
sudo foremost -t all -i /dev/sdb1 -o ./
```

こうすると、 ./ にファイル種ごとのフォルダ(avi,gif,jpg,wavなど)を作り、そこへサルベージしたファイルを「元の名前でない数値名で」保存していきます。

やってみると…やった!元RAID内にあったZIPとかJPGとかがどんどこ溜まっていくじゃないですか！

…が、その「元の名前でない数値名」が曲者で…「標準出力で元の名前やフォルダパスっぽいものを出している」にもかかわらず、「その情報全部捨てて連番名にする」ので、
あとで「星の数ほどあるファイルを分類しなおし」する作業が待っています。

ツールの特性上「フォルダ構成が出せない」のは良いとしても、せめて「名前だけでも元に」「連番ファイルと名前のひも付きをテキストに残す」くらいやってくれてもいいのに…。

ともあれ！ここで「ファイルデータはまだある！」というのがわかったので、次のアプローチの行けそうです。
