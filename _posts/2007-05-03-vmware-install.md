---
published: false
layout: post
title: VmWareの実験
category: tech
tags: [linux,vmware]
---

やーっとGW(ゴリラウィーク）
以前からやりたかったができなかった、VmWareインストールを行います。

## 参考にするサイト

[http://www.geocities.jp/turtle_wide/tools/vmwareInst.htm](http://www.geocities.jp/turtle_wide/tools/vmwareInst.htm)

## やること

まず、

+ ユーザ登録
+ VmWareWorkstationダウンロード
+ 同シリアル発行依頼・メール送達

までは終わった状態で開始します。

### インストール

+ rpm -ivh でrpmをインストール
+ /usr/bin/vmware-config.pl　叩く

だがここで設定が終わらないトラブル。

以下で解消

[http://blog.kyosuke.jp/item/59](http://blog.kyosuke.jp/item/59)

※一番下の２１行めをコメントアウト云々ってやつです。解凍して修正してもっかい圧縮

もうひとつハマり。xinetdかinetdのスーパーサーバ入れろって。

エーchkconrig,serviceコマンド入ってたら入ってるんじゃないのー？

別もんなんだね、はじめて知りました。

yumでインストール。