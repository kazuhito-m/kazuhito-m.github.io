---
layout: post
title: 新システム準備作業(つづき1)
category: tech
tags: [linux,dd,partision,bootloader,setup]
---

新マシンのLinuxセットアップの様子を割とリアル目にお届け。

※何もしていなければ、すべてrootのコンソールだと思ってください。

#データのコピー

hdd1とhdb1はマウントポイントが最初からあるので、それを使って、マウント&コピー。

```bash
cd /media
mount hdb1
mount hdd1
cp -a ./hdb1/* ./hdd1
```

本体データコピー前に元VGをアクティブに

```bash
vgchange -ay VolGroup002 logical volume(s) in volume group "VolGroup00" now active
lvscan
ACTIVE '/dev/NewVG/LogVol01' [1.97 GB] inherit
ACTIVE '/dev/NewVG/LogVol00' [16.94 GB] inherit
ACTIVE '/dev/VolGroup00/LogVol00' [18.94 GB] inherit
ACTIVE '/dev/VolGroup00/LogVol01' [1.94 GB] inherit

mkdir NewVg_LogVol00
mkdir Group00_LogVol00
mount -t ext3 /dev/NewVG/LogVol00 NewVg_LogVol00/
mount -t ext3 /dev/VolGroup00//LogVol00 ./Group00_LogVol00/
cp -a Group00_LogVol00/* NewVg_LogVol00/
```

(ひたすら待つ)

#grub作る

```bash
grub-install --recheck /dev/hdd1

Probing devices to guess BIOS drives. This may take a long time.
Could not find device for /boot: Not found or not a block device.

e2label /dev/hdd1 "/boot"
grub-install --recheck /dev/hdd1
Probing devices to guess BIOS drives. This may take a long time.
Could not find device for /boot: Not found or not a block device.

lvm vgchange -a n NewVG
0 logical volume(s) in volume group "NewVG" now active

lvm vgrename NewVG VolGroup00
Volume group "NewVG" successfully renamed to "VolGroup00"

lvm vgchange -a y VolGroup00
2 logical volume(s) in volume group "VolGroup00" now active
```

上記で、メッセージを読むとわかるのですが、grub-installが失敗しています。

この作業はknoppix上でやっていましたが、Knoppix上には、/bootディレクトリは無い。

本来は、元システムあるいはHDD稼働しているLinux上でやる作業？のようですね(推測)

わかってないものの「こうちゃう？」のノリで、knoppix上で/bootにhdd1をmount。

```bash
grub-install --recheck /dev/hdd1
```

再度行うと成功。

HDDを移行先一機だけにして、起動。やった！念願のFedora6起動画面に。

ところが、Login後にGUIが立ち上がらない。

/dev/VolGroup00/LogVol00 は、全てコピーしましたが、たしか参考にしたサイトに「seLinuxコピーすんな！」とあったと思うので、ここを疑ましょうか。

シングルユーザモードで入り、seLinuxを無効に。

```bash
vi /etc/sysconfig/selinux

6 SELINUX=disabled
```

これで再起動。おっけ！KDE起動。

長かったですが、引越し終わりー。

これで新マシンくるまでしばらくつないで、その後バックアップとして封印するドライブとしましょう。

20Gの古いHDとはいえ、贅沢なバックアップ機器だw

次は新マシンの選定と、余らせた80GのHDDの使い道について考えますか。
