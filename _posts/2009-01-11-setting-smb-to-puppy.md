---
layout: post
title: Puppy Linux にSamba設定(今度はクライアントじゃなくサーバね)
category: tech
tags: [linux,puppy,samba,installt]
---

ntpとは逆に、smbにはサーバになってもらうこととしました。

# やったこと

## インストール

まずは、パッケージのインストールから

(特に指定のない場合、rootでオペレーション)

```bash
wget http://distro.ibiblio.org/pub/linux/distributions/puppylinux/pet_packages-4/samba-3.0.26.pet
```
この後、UIが表示されるので、それを使ってインストール。

## 設定ファイルの編集

```bash
vi /etc/opt/samba/smb.conf
```

設定ファイルには、以下項目を設定。

- ワークグループ
- コメント
- プリンタ設定を殺す
- homes有効

あとはデフォルト。

## smbd起動

```bash
/opt/samba/sbin/smbd -d
/opt/samba/sbin/nmbd -d
```

## ユーザ作成

```bash
pdbedit -a [ユーザ名]
```

可動確認...おお、見えたw

## 自動起動設定

```basj
vi /etc/rc.d/rc.local

# 末尾に以下を追加
/opt/samba/sbin/smbd -d
/opt/samba/sbin/nmbd -d
```

---

セキュリティ甘々だけど、あとで本物のSambaサーバを立ち上げるので、その時合わせて対処しよう。
