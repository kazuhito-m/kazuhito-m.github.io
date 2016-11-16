---
layout: post
title: ややこしいことになった
category: tech
tags: [linux,dd,backup,recovery]
---

ややこしいことになりまして…。現在も進行中。

+ HD異音がするので恐くなって別のHDへコピーしようとする。
+ knoppixをつかって、ddコマンドでイメージごとやろうとしたが、from-toを間違えて途中までやってしまう。
+ 気づいてストップ。
+ 元のHD起動ができなくなった。

すぐ気づいて止めたためどこかが無事なら…と、「HD壊れた」系の情報を中心に模索中。
領域情報が書き換えられているとあたりをつけ、インデックスが変になった場合対応を探す。

LVNも絡んでるんだよな…

以下、スクラップ

[http://bbs.fedora.jp/read.php?FID=9&TID=4279](http://bbs.fedora.jp/read.php?FID=9&TID=4279)
[http://nstage.ddo.jp/pukiwiki/index.php?KNOPPIX%A4%C7%A5%EC%A5%B9%A5%AD%A5%E5%A1%BC#content_1_0](http://nstage.ddo.jp/pukiwiki/index.php?KNOPPIX%A4%C7%A5%EC%A5%B9%A5%AD%A5%E5%A1%BC#content_1_0)
[http://memo.blogdns.net/lvm.html](http://memo.blogdns.net/lvm.html)
[http://pantora.net/pages/linux/lvm/3/](http://pantora.net/pages/linux/lvm/3/)

すこし救いがあったのは、1年まえにHDDを移行する際に元のHDDを消さずの越していたこと。

台所事情から、これをいかしつつ、このデータを逃がしつつがんばってみよう。


※メモ、後で解説

```bash
fsck.ext -f /dev/VolGroup00/LogVol00
resize2fs -p /dev/VolGroup00/LogVol00 14336M (場合によってはすごい時間がかかる)
# lvreduce -L -50G /dev/VolGroup00/LogVol00
WARNING: Reducing active logical volume to 21.94 GB
THIS MAY DESTROY YOUR DATA (filesystem etc.)
Do you really want to reduce LogVol00? [y/n]: y
Reducing logical volume LogVol00 to 18.94 GB
Logical volume LogVol00 successfully resized
# lvscan
ACTIVE '/dev/VolGroup00/LogVol00' [18.94 GB] inherit
ACTIVE '/dev/VolGroup00/LogVol01' [1.94 GB] inherit
```

## HDDそのまま交換系

[http://d.hatena.ne.jp/shpolsky/20070306])http://d.hatena.ne.jp/shpolsky/20070306)
[(http://wiki.mmj.jp/index.php?Fedora5%2F%CF%C0%CD%FD%A5%DC%A5%EA%A5%E5%A1%BC%A5%E0](http://wiki.mmj.jp/index.php?Fedora5%2F%CF%C0%CD%FD%A5%DC%A5%EA%A5%E5%A1%BC%A5%E0)
[http://wiki.mmj.jp/index.php?EtCetera%2FHDD%B4%B9%C1%F5](http://wiki.mmj.jp/index.php?EtCetera%2FHDD%B4%B9%C1%F5)

こぴー元の構成を真似てパーティションをわる

```bash
# fdisk /dev/hdd

このディスクのシリンダ数は 39560 に設定されています。
間違いではないのですが、1024 を超えているため、以下の場合
に問題を生じうる事を確認しましょう:
1) ブート時に実行するソフトウェア (例. バージョンが古い LILO)
2) 別の OS のブートやパーティション作成ソフト
(例. DOS FDISK, OS/2 FDISK)
コマンド (m でヘルプ): p

Disk /dev/hdd: 20.4 GB, 20416757760 bytes
16 heads, 63 sectors/track, 39560 cylinders
Units = シリンダ数 of 1008 * 512 = 516096 bytes

デバイス Boot Start End Blocks Id System

コマンド (m でヘルプ): n
コマンドアクション
e 拡張
p 基本領域 (1-4)
p
領域番号 (1-4): 1
最初 シリンダ (1-39560, default 1): 1
終点 シリンダ または +サイズ または +サイズM または +サイズK (1-39560, default 39560): 208

コマンド (m でヘルプ): n
コマンドアクション
e 拡張
p 基本領域 (1-4)
p
領域番号 (1-4): 2
最初 シリンダ (209-39560, default 209):
Using default value 209
終点 シリンダ または +サイズ または +サイズM または +サイズK (209-39560, default 39560):
Using default value 39560

コマンド (m でヘルプ): p

Disk /dev/hdd: 20.4 GB, 20416757760 bytes
16 heads, 63 sectors/track, 39560 cylinders
Units = シリンダ数 of 1008 * 512 = 516096 bytes

デバイス Boot Start End Blocks Id System
/dev/hdd1 1 208 104800+ 83 Linux
/dev/hdd2 209 39560 19833408 83 Linux

コマンド (m でヘルプ): w
領域テーブルは交換されました！
```

## PV作成

```bash
# pvcreate /dev/hdd2
Physical volume "/dev/hdd2" successfully created
# vgcreate -s 32m NewVG /dev/hdd2
Volume group "NewVG" successfully created

解説に、「以前のエクステント数をlvdisplayで参照して、-lを指定します」とあるが、
-Lで容量指定ができるともあるので、それでやってみる。

# lvcreate -L 1.94G -n LogVol01 NewVG
Rounding up size to full physical extent 1.97 GB
Logical volume "LogVol01" created
# lvcreate -L 17.03G -n LogVol00 NewVG
Rounding up size to full physical extent 17.03 GB
Insufficient free extents (542) in volume group NewVG: 545 required
# lvcreate -l 542 -n LogVol00 NewVG
Logical volume "LogVol00" created
```

## ファイルシステム作成

root@Knoppix:~# mkfs -t ext3 /dev/hdd1
mke2fs 1.40-WIP (14-Nov-2006)
Filesystem label=
OS type: Linux
Block size=1024 (log=0)
Fragment size=1024 (log=0)
26208 inodes, 104800 blocks
5240 blocks (5.00%) reserved for the super user
First data block=1
Maximum filesystem blocks=67371008
13 block groups
8192 blocks per group, 8192 fragments per group
2016 inodes per group
Superblock backups stored on blocks:
8193, 24577, 40961, 57345, 73729

Writing inode tables: done
Creating journal (4096 blocks): done
Writing superblocks and filesystem accounting information: done

This filesystem will be automatically checked every 37 mounts or
180 days, whichever comes first. Use tune2fs -c or -i to override.
root@Knoppix:~# mkfs -t ext3 /dev/NewVG/LogVol00
mke2fs 1.40-WIP (14-Nov-2006)
Filesystem label=
OS type: Linux
Block size=4096 (log=2)
Fragment size=4096 (log=2)
2223872 inodes, 4440064 blocks
222003 blocks (5.00%) reserved for the super user
First data block=0
Maximum filesystem blocks=0
136 block groups
32768 blocks per group, 32768 fragments per group
16352 inodes per group
Superblock backups stored on blocks:
32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208,
4096000

Writing inode tables: done
Creating journal (32768 blocks): done
Writing superblocks and filesystem accounting information: done

This filesystem will be automatically checked every 32 mounts or
180 days, whichever comes first. Use tune2fs -c or -i to override.
root@Knoppix:~# mkswap /dev/NewVG/LogVol01
Setting up swapspace version 1, size = 2113925 kB
no label, UUID=37ea65ae-1996-41c0-b061-fc409f9e9527
```

ちょっと解説が要りそうですが…自分のためにもまたの機会に♪
