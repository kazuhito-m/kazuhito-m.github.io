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

もうちょい詳しく…

```bash
# mdadm --detail /dev/md0
/dev/md0:
        Version : 1.2
  Creation Time : Mon May  6 16:17:19 2013
     Raid Level : raid1
     Array Size : 976761423 (931.51 GiB 1000.20 GB)
  Used Dev Size : 976761423 (931.51 GiB 1000.20 GB)
   Raid Devices : 2
  Total Devices : 2
    Persistence : Superblock is persistent

    Update Time : Tue Jan 12 06:25:11 2016
          State : clean
 Active Devices : 2
Working Devices : 2
 Failed Devices : 0
  Spare Devices : 0

           Name : fumiko:0  (local to host fumiko)
           UUID : bbbb3156:fce5edff:12466ad1:d00be983
         Events : 101

    Number   Major   Minor   RaidDevice State
       0       8       33        0      active sync   /dev/sdc1
       1       8       49        1      active sync   /dev/sdd1
```

さて、この状態からHDDの換装をしていきます。

※これ以降の作業はすべてrootユーザで行っていることとします

## 片方のディスクを脱退&電源断


片方のディスク(/dev/sdc1)を脱退させます。

「異常」→「削除」という状態をたどって行きます。

まずは「異常」化

```bash
mdadm /dev/md0 --manage --fail /dev/sdc1
mdadm: set /dev/sdc1 faulty in /dev/md0

cat /proc/mdstat
Personalities : [linear] [raid0] [raid1] [raid6] [raid5] [raid4] [multipath]
md0 : active raid1 sdc1[0](F) sdd1[1]
      976761423 blocks super 1.2 [2/1] [_U]

mdadm --detail /dev/md0
     /dev/md0:
             Version : 1.2
       Creation Time : Mon May  6 16:17:19 2013
          Raid Level : raid1
          Array Size : 976761423 (931.51 GiB 1000.20 GB)
       Used Dev Size : 976761423 (931.51 GiB 1000.20 GB)
        Raid Devices : 2
       Total Devices : 2
         Persistence : Superblock is persistent

         Update Time : Wed Jan 13 23:34:06 2016
               State : clean, degraded
      Active Devices : 1
     Working Devices : 1
      Failed Devices : 1
       Spare Devices : 0

                Name : fumiko:0  (local to host fumiko)
                UUID : bbbb3156:fce5edff:12466ad1:d00be983
              Events : 104

         Number   Major   Minor   RaidDevice State
            0       0        0        0      removed
            1       8       49        1      active sync   /dev/sdd1

            0       8       33        -      faulty spare   /dev/sdc1
```

なるほど、こうなるんですね。

次に「削除」化。


```bash
mdadm /dev/md0 --remove /dev/sdc1
mdadm: hot removed /dev/sdc1 from /dev/md0

cat /proc/mdstat
Personalities : [linear] [raid0] [raid1] [raid6] [raid5] [raid4] [multipath]
md0 : active raid1 sdd1[1]
      976761423 blocks super 1.2 [2/1] [_U]

unused devices: <none>

cat /proc/mdstat
Personalities : [linear] [raid0] [raid1] [raid6] [raid5] [raid4] [multipath]
md0 : active raid1 sdd1[1]
      976761423 blocks super 1.2 [2/1] [_U]

unused devices: <none>
```

ステータスから /dev/sdc1 が完全になくなってますね。

これが確認できたら、筐体シャットダウンです。

bash```
shutdown -h now
```
## 物理的に片方を新ディスクに交換

## 構成として認識

## もうひとつのディスクも交換

## 容量アップ

# 参考資料・サイト

+ [http://mo.kerosoft.com/0200](http://mo.kerosoft.com/0200)
+ [http://www.ioss.jp/sohodiy/mdadm8-1_5.php](http://www.ioss.jp/sohodiy/mdadm8-1_5.php)
+ [http://d.hatena.ne.jp/h2onda/20080527/1211838066](http://d.hatena.ne.jp/h2onda/20080527/1211838066)
