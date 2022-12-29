---
layout: post
title: sambaの設置
category: tech
tags: [linux,samba,install]
---

Windowsのマシンも使ってて、不便なんで設定してみます。

(あんま良いおもいしたことがないのが、SMBですが…）

---

※今後、特に指定がなければrootでのオペレーション

## インストール

```bash
yum -y install samba.i386
```

...としたが、すでに入っていた模様。

## パブリックフォルダ作成

```bash
mkdir /home/public
chown nobody.nobody /home/public
```

## ユーザ設定

```
pdbedit -a ユーザ
```

## 設定ファイル変更

```bash
vi /etc/samba/smb.conf

[global]
unix charset = UTF-8
dos charset = CP932
display charset = UTF-8
workgroup = XXXXXX
server string = XXXXXX
hosts allow = 192.168.1. 192.168.2. 127.
load printers = no
disable spoolss = yes

#ゴミ箱設定

[homes]
comment = Home Directories
browseable = no
writable = yes
# 各ユーザ専用のごみ箱機能追加(ここから)
# ※ファイル削除時に自動的にごみ箱へ移動されるようにする
vfs objects = recycle　←　ごみ箱の有効化
recycle:repository = .recycle　←　ごみ箱のディレクトリ名(/home/ユーザ名/.recycle)
recycle:keeptree = no　←　ごみ箱へ移動時にディレクトリ構造を維持しない
recycle:versions = yes　←　同名のファイルがごみ箱にある場合に別名で移動
recycle:touch = no　←　ごみ箱へ移動時にタイムスタンプを更新しない
recycle:maxsize = 0　←　ごみ箱へ移動するファイルのサイズ上限(0:無制限)
recycle:exclude = *.tmp ~$*　←　ここで指定したファイルはごみ箱へ移動せずに即削除する
各ユーザ専用のごみ箱機能追加(ここまで)
```

## 起動＆登録

```bash
service smb start
chkconfig smb on
```

うーっし、あとは、Windows端末からテストだけかー。
