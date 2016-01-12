---
published : false
layout: post
title: LinuxのソフトウェアRAID"md"で既存の構成(RAID0)に容量アップ方向でHDDを交換する
category: tech
tags: [linux,raid ,software_raid,md]
---

久しぶりのHowtoモノですが…自身の構成にしか適用できないのでメモです。

# 前提

+ 対象となる筐体はARMのNAS（[KURO-NAS/X4](http://archive.kuroutoshikou.com/modules/display/?iid=1264)）
+ 入っているOS(Linuxディストリビューション)は”Debian GNU/Linux 6.0（squeeze）”
+ Linux Software RAID(通称"md"かな？)でRAID１（ミラーリング）を組んでいる
+ そのRIAD1の論理ディスク(/dev/md0)を/homeにマウントしてある

# やりたいこと

+ mdで組んだRAID1を新しく大きなHDDに交換したい
  + 現在1TBのディスクが生きているが双方を3TBのディスク2つ換装したい
+ 「RAID作りなおしてコピー」とかじゃなくて「交換を装ってひとつずつ換えつつ拡張」したい
  + 一つを離脱 → 新しいのに交換 → もう一つも離脱 → 新しいのに交換 という流れでいきたい

# やったこと

## 現状の構成の確認

まずは、ファイルシステムのマウント状況。


```bash
# df -h
Filesystem            Size  Used Avail Use% マウント位置
/dev/sda2             3.8G  2.0G  1.6G  56% /
tmpfs                  60M     0   60M   0% /lib/init/rw
udev                   10M  164K  9.9M   2% /dev
tmpfs                  60M     0   60M   0% /dev/shm
/dev/sda1             963M   35M  879M   4% /boot
/dev/sda4              54G  444M   51G   1% /var
/dev/md0              917G  335G  537G  39% /home
```

ごちゃごちゃしてますけど、最後の /dev/md0 (/homeマウント) なディスクがRAID1対象です…思ったより容量余裕あるな。

次に、mdから吸える情報を確認。

```bash
# cat /proc/mdstat
Personalities : [linear] [raid0] [raid1] [raid6] [raid5] [raid4] [multipath]
md0 : active raid1 sdc1[0] sdd1[1]
      976761423 blocks super 1.2 [2/2] [UU]

unused devices: <none>
```

構築時に --level でもミスったのか、Personalitiesが大変なことになっていますが、とりあえず健康のようです。

さて、この状態からHDDの換装をしていきます。

## 片方のディスクを脱退

## 片方を新ディスクに交換

## 構成として認識

## もうひとつのディスクも交換

## 容量アップ

# 参考資料・サイト

+ [http://mo.kerosoft.com/0200](http://mo.kerosoft.com/0200)
+ [http://www.ioss.jp/sohodiy/mdadm8-1_5.php](http://www.ioss.jp/sohodiy/mdadm8-1_5.php)
+ [http://d.hatena.ne.jp/h2onda/20080527/1211838066](http://d.hatena.ne.jp/h2onda/20080527/1211838066)
