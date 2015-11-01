---
published: false
layout: post
title: 「MindmeisterからTrelloのカードを作成するツール」をScala作ってみた
category: tech
tags: [usb,ci,hardware]
---

自身は「何かどうやっていいかわからないこと」や「ゴールへの道筋がわからないもの」に当たる時、「マインドマップツール」を使用します。

この時の使い方は「タスク分解機」であり「放射状アウトラインエディタ」だったりします。

で、最近は「複数人で同時編集出来る」という理由で「mindmeister」というWebサービスを使うことが多いのです。


TODO タイトル、タグ編集

# 使い方 

## 前提

## 準備

## コマンド実行

# 実装について

## ライブラリ選定

trello4jとtrello-java-wrapperを迷いましたが…

+ maven-centralに入ってる事(sbtにリポジトリ追加しなくていい)
+ ぱっと見、Usageが簡単そう感をアピってたから

trello-java-wrapperにしました。



# 小並感

個人的には「なかなか便利になった」感じがあるので、複数人での「ブレストからのタスク出し」に活用していきたいと思います。

そして「INとOUTがはっきりしたツール」なので、Webサービス化もあるかも？…とか構想が広がりますねw

# 参考

以下を参考にさせていただきました。ありがとうございます。


+ [https://github.com/bywan/trello-java-wrapper](https://github.com/bywan/trello-java-wrapper)
+ [https://github.com/ForNeVeR/trello4j](https://github.com/ForNeVeR/trello4j)
+ [http://qiita.com/isseium/items/8eebac5b79ff6ed1a180](http://qiita.com/isseium/items/8eebac5b79ff6ed1a180)
+ [https://github.com/n8han/conscript](https//github.com/n8han/conscript)
+ [http://qiita.com/ha_g1/items/d41febac011df4601544](http://qiita.com/ha_g1/items/d41febac011df4601544)
+ [http://mocobeta-backup.tumblr.com/post/123266618477/100-2015-scala-3](http://mocobeta-backup.tumblr.com/post/123266618477/100-2015-scala-3)
+ [https://gist.github.com/takuya71/4025974](https://gist.github.com/takuya71/4025974)
+ [http://d.hatena.ne.jp/Kazuhira/20140419/1397895464](http://d.hatena.ne.jp/Kazuhira/20140419/1397895464)
+ []()
+ []()
+ []()
+ []()
+ []()
+ Scalaらへん
	+ [http://tech-blog.tsukaby.com/archives/646](http://tech-blog.tsukaby.com/archives/646)
	+ [http://d.hatena.ne.jp/xuwei/20110217/1297904429](http://d.hatena.ne.jp/xuwei/20110217/1297904429)
	+ [http://www.scala-sbt.org/0.13/tutorial/ja/](http://www.scala-sbt.org/0.13/tutorial/ja/)
	+ [http://blog.basyura.org/entry/20091108/p3](http://blog.basyura.org/entry/20091108/p3)
	+ [http://seratch.hatenablog.jp/entry/20110429/1304072372](http://seratch.hatenablog.jp/entry/20110429/1304072372)
	+ [http://qiita.com/mtoyoshi/items/c95cc88de2910945c39d](http://qiita.com/mtoyoshi/items/c95cc88de2910945c39d)
	+ [http://bach.istc.kobe-u.ac.jp/lect/ProLang/org/scala-recursive.html](http://bach.istc.kobe-u.ac.jp/lect/ProLang/org/scala-recursive.html)
	+ [http://www.ne.jp/asahi/hishidama/home/tech/scala/collection/map.html](http://www.ne.jp/asahi/hishidama/home/tech/scala/collection/map.html)
	+ [http://www.mwsoft.jp/programming/scala/fileread.html](http://www.mwsoft.jp/programming/scala/fileread.html)
	+ [http://uriku.hatenablog.com/entry/2015/05/24/225349](http://uriku.hatenablog.com/entry/2015/05/24/225349)
	+ [sbtがらみのトラブル](http://stackoverflow.com/questions/19805102/unresolved-dependency-org-scala-sbtsbt0-13-not-found-when-running-sbt-0-13)
	+ []()
