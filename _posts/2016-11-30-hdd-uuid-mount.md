---
layout: post
title: LinuxでハードディスクをUUIDでmount設定(fstab)を書く
category: tech
tags: [linux,ubuntu,fstab,mount]
---

自分用のコマンドの備忘録です。

(絶対忘れるので、虎の巻書きます。解説は少なめ)

## 前提

- Ubuntu 16.04 LTS
- HDDはフォーマット/fs構築済でマザボにつないである
- HDDは `/strage/01` にマウントしたい

## やったこと

### UUID確認

```bash
ls -l /dev/disk/by-uuid

合計 0
lrwxrwxrwx 1 root root  9 11月 30 11:25 8caedd20-de2d-4971-90ba-a75d1e7c3384 -> ../../sdb
lrwxrwxrwx 1 root root 10 11月 30 11:25 b1da9824-49c6-4671-8ad8-d4498386e6df -> ../../sda1

```

なるほど、俺が繋ぎたいHDDは `sdb` ですね。(パーティション切らんとfs構築したんだねｗ)

### fstab編集

```bash
sudo vi /etc/fstab

UUID=b1da9824-49c6-4671-8ad8-d4498386e6df /               ext4    errors=remount-ro 0 1
/swapfile               swap                    swap    defaults        0 0
UUID=8caedd20-de2d-4971-90ba-a75d1e7c3384 /strage/01      ext4    errors=remount-ro 0 1 #この行を追加
```

あとは、 `mount` でも再起動でも良いけれど、目的考えたら再起動が実験になるかな？

---

毎回毎回、難度調べたことかわからないので、サマリだけ書いとくのは良いかなと思いました。
(とはいえ、今度は「ここを忘れてしまって探すハメに」といのは避けたいものですがｗ)
