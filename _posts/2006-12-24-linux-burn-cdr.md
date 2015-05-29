---
published: false
layout: post
title: Linux
category: tech
tags: [linux,font]
---

思いつきで再インストールを思いつく。
「設定バックアップせななあ」と思う。
HD自体は前の残しておいておこなうから、安心といえば安心なのだが、
ちょい不安なので、CDRに主要なディレクトリをバックアップ録っておこうと思う。
…が、CDRに焼く方法がわからない。(前やってるはずなのだが・・・)

http://fock.c.s.osakafu-u.ac.jp/~matsushita/cdr.htm

これを参考に行う。

中身を整理して、boot etc home rootあたりを/tmp/backupにあつめる。
そのディレクトリのイメージファイルを作成。
# mkisofs -o 20061223_linuxbackup.iso -V 20061223_BACK ./backup
一応、中身確認。
# mount -t iso9660 -o ro,loop=/dev/loop0 20061223_linuxbackup.iso mnttest/
CDに焼く。そのために使っているドライブの情報収集
# cdrecord -scanbus
SCSIバス、デバイスID、論理ユニット番号 ＝ 1,0,0
と出た。上記を踏まえ、焼きコマンドを放りこむ。
# cdrecord -v -eject speed=8 dev=1,0,0 ./20061223_linuxbackup.iso
これでは、何故かエラーとなる。
cdrecord: Invalid or incomplete multibyte or wide character. Cannot open SCSI driver.

めんどくさくなったので、GUIツールをインストールし焼いた。
yum install xcdroast.i386
これでよかったのかなあ？