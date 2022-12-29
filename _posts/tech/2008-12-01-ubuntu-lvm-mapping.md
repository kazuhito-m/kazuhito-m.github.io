---
layout: post
title: 他マシンにてLVM運用されてたHDDをUbuntuへマウント
category: tech
tags: [linux,ubuntu,lvm,rescue]
---

Fedora8でデスクトップ運用していたのですが、Flash見れなくなったり、なんかいろいろ不都合でてきたので、
Fedora8からUbuntu8.10に乗り換えてみることにしました。

例により「新しいHDDにインストールして、旧HDDからいろいろ移す」をしたかったのですが、少しハマったので備忘です。

# やったこと

## 環境

- ハード: Dos機
- 元 : Fedora8
- 新 : Ubuntu8.10(Ubuntu Desktop 日本語remix)

## 旧HDDを接続＆LVMインストール

「Fedora8でLVM設定の旧ディスク」をつないでこれを読む。

…のだが、mount出来ません。

まず、認識出来る状態にしなくちゃいけないので、lvm2をインストール。

```bash
sudo apt-get install lvm2
```

HDDの状態を、内部からコマンド確認。

```bash
sudo pvscan

PV /dev/sdb2   VG vg0   lvm2 [232.69 GB / 32.00 MB free]
Total: 1 [232.69 GB] / in use: 1 [232.69 GB] / in no VG: 0 [0   ]

sudo vgscan

Reading all physical volumes.  This may take a while...
Found volume group &quot;vg0&quot; using metadata type lvm2

sudo lvscan

/proc/misc: No entry for device-mapper found
Is device-mapper driver missing from kernel?
Failure to communicate with kernel device-mapper driver.
/proc/misc: No entry for device-mapper found
Is device-mapper driver missing from kernel?
Failure to communicate with kernel device-mapper driver.
Incompatible libdevmapper 1.02.27 (2008-06-25)(compat) and kernel driver
inactive          '/dev/vg0/lv0' [230.72 GB] inherit
inactive          '/dev/vg0/lv1' [1.94 GB] inherit
```

## `device-mapper` module有効化&マウント

device-mapper が使えない、と怒られてる様子。moduleを有効にしてあげます。

```bash
sudo modprobe dm-mod
lvscan

inactive          '/dev/vg0/lv0' [230.72 GB] inherit
inactive          '/dev/vg0/lv1' [1.94 GB] inherit
```

よし、見えた！ 急いでマウントします。

```bash
sudo vgchange -ay vg0

2 logical volume(s) in volume group 'vg0' now active

sudo mount -t ext3 /dev/vg0/lv0 ./oldhdd/
```

容量二倍にしたし、まるままコピーしときますか。

```bash
sudo cp -ipfR oldhdd/ /
```
