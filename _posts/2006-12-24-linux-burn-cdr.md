---
layout: post
title: LinuxでCDR焼く
category: tech
tags: [linux,cdr]
---

思いつきで再インストールを思いつきました。

なので「設定バックアップせななあ」と思います。

HD自体は前の残しておいておこなうから、安心といえば安心なのですが、
ちょい不安なので、CDRに主要なディレクトリをバックアップ録っておこうと思います。

…が、CDRに焼く方法がわかりません。(前やってるはずなのだが・・・)

## レシピ

[http://fock.c.s.osakafu-u.ac.jp/~matsushita/cdr.htm](http://fock.c.s.osakafu-u.ac.jp/~matsushita/cdr.htm)

これを参考に行う。

## 実際にやっことと

中身を整理して、boot etc home rootあたりを/tmp/backupにあつめる。

そのディレクトリのイメージファイルを作成。

```
suod mkisofs -o 20061223_linuxbackup.iso -V 20061223_BACK ./backup
```

一応、中身確認。

```
sudo mount -t iso9660 -o ro,loop=/dev/loop0 20061223_linuxbackup.iso mnttest/
```

CDに焼く。そのために使っているドライブの情報収集

```
sudo cdrecord -scanbus
SCSIバス、デバイスID、論理ユニット番号 ＝ 1,0,0
```

と出た。上記を踏まえ、焼きコマンドを放りこむ。

```
sudo cdrecord -v -eject speed=8 dev=1,0,0 ./20061223_linuxbackup.iso
```

これでは、何故かエラーとなります。

```
cdrecord: Invalid or incomplete multibyte or wide character. Cannot open SCSI driver.
```

めんどくさくなったので、GUIツールをインストールし焼きました。

```
sudo yum install xcdroast.i386
```

---

最終的には妥協の産物になってしまったのですが…。

これでよかったのかなあ？
