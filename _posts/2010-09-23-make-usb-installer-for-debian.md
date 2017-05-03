---
layout: post
title: Debian Lenny のインストーラUSBの作成(できるだけ最短)
category: tech
tags: [debian,linux,bootloader]
---

調べながら迷走しながらしながらやったので、備忘として記録します。

# やること

## 準備

- Linuxマシン(インターネットにつながる)
- USBメモリ(１G以上くらい？)

## 前提

- USBのデバイスは、/dev/sda1
- 全てrootユーザで操作
- 完成後は「最小ネットワークインストール用ディスクを入れたブート可能USBメモリ」に。
- すべては、2010/09/23 当時のみ有効

## やったこと

作成作業(コピペしていけるくらい全自動)

```bash
apt-get install dosfstools
mkdosfs -F 32 /dev/sda1
wget http://ftp.nl.debian.org/debian/dists/lenny/main/installer-i386/current/images/hd-media/boot.img.gz
gunzip boot.img.gz
dd if=boot.img of=/dev/sda1
wget http://cdimage.debian.org/debian-cd/5.0.6/i386/iso-cd/debian-506-i386-netinst.iso
mkdir ./usbmem
mount -t vfat /dev/sda1 ./usbmem
cp -ipv debian-506-i386-netinst.iso ./usbmem
```

確認

```bash
ls -l ./usbmem

-rwxr-xr-x 1 root root       496 2010-06-18 22:26 adgtk.cfg
-rwxr-xr-x 1 root root       367 2010-06-18 22:26 adtxt.cfg
-rwxr-xr-x 1 root root 157630464 2010-09-05 20:24 debian-506-i386-netinst.iso
-rwxr-xr-x 1 root root        68 2010-06-18 22:26 disk.lbl
-rwxr-xr-x 1 root root        56 2010-06-18 22:26 exithelp.cfg
-rwxr-xr-x 1 root root       888 2010-06-18 22:26 f1.txt
-rwxr-xr-x 1 root root       568 2010-06-18 22:26 f10.txt
-rwxr-xr-x 1 root root       665 2010-06-18 22:26 f2.txt
-rwxr-xr-x 1 root root       852 2010-06-18 22:26 f3.txt
-rwxr-xr-x 1 root root       486 2010-06-18 22:26 f4.txt
-rwxr-xr-x 1 root root       806 2010-06-18 22:26 f5.txt
-rwxr-xr-x 1 root root      1220 2010-06-18 22:26 f6.txt
-rwxr-xr-x 1 root root       916 2010-06-18 22:26 f7.txt
-rwxr-xr-x 1 root root      1019 2010-06-18 22:26 f8.txt
-rwxr-xr-x 1 root root       765 2010-06-18 22:26 f9.txt
-rwxr-xr-x 1 root root     56513 2010-06-18 22:26 g2ldr
-rwxr-xr-x 1 root root      8192 2010-06-18 22:26 g2ldr.mbr
-rwxr-xr-x 1 root root       132 2010-06-18 22:26 gtk.cfg
-rwxr-xr-x 1 root root   5184027 2010-06-18 22:26 initrd.gz
-rwxr-xr-x 1 root root  13006064 2010-06-18 22:26 initrdg.gz
-r-xr-xr-x 1 root root     13631 2010-06-18 22:26 ldlinux.sys
-rwxr-xr-x 1 root root   1469616 2010-06-18 22:26 linux
-rwxr-xr-x 1 root root       531 2010-06-18 22:26 menu.cfg
-rwxr-xr-x 1 root root       190 2010-06-18 22:26 prompt.cfg
-rwxr-xr-x 1 root root    292416 2010-06-18 22:26 setup.exe
-rwxr-xr-x 1 root root      6329 2010-06-18 22:26 splash.png
-rwxr-xr-x 1 root root       523 2010-06-18 22:26 stdmenu.cfg
-rwxr-xr-x 1 root root        87 2010-06-18 22:26 syslinux.cfg
-rwxr-xr-x 1 root root       131 2010-06-18 22:26 txt.cfg
-rwxr-xr-x 1 root root    145800 2010-06-18 22:26 vesamenu.c32
-rwxr-xr-x 1 root root       182 2010-06-18 22:26 win32-loader.ini
```

---

# 小並感

Linuxのコマンドラインで作成するのは、やり方を知っているなら簡単かもしれません。

Windows上で「ddと同じ操作」「gzipの操作」は、結構段取りと道具を必要としますね…。
