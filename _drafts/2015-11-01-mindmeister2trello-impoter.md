---
published: false
layout: post
title: 「MindmeisterからTrelloのカードを作成するツール」をScala作ってみた
category: tech
tags: [mindmeister,trello,conscript,scala,trello-java-wrapper]
---

自身は「何かどうやっていいかわからないこと」や「ゴールへの道筋がわからないもの」に当たる時、「マインドマップツール」を使用します。

この時の使い方は「タスク分解機」であり「放射状アウトラインエディタ」だったりします。

最近は「複数人で同時編集出来る」という理由で「[mindmeister](https://www.mindmeister.com/)」というWebサービスを使うことが多いのです。

で、そのタスク分解したものは「[Trello](https://trello.com)」という、
タスクボードのコレまたWebサービスに転記して整理・Todo消化とかしていくわけです。

ただ！当たり前ながらその転記がめんどい…ので！

「mindmeisterの末端アーティクル -> Trelloのカード へと転送」

するバッチを作りました。

# 使い方

## 前提

+ Scala/conscriptが動くOS環境であること(筆者はUbuntu Linux)
+ mindmeister, Trelloにはアカウントを持っていること

## 準備

ツールを入れるため、その前にやっておくこととして…

+ Javaインストール
+ [conscript(csコマンド)](https://github.com/n8han/conscript)のインストールが

が必要です。

[ここ(本家README)](https://github.com/n8han/conscript)を参考に、conscriptのインストールを行って下さい

自身はUbuntuLinuxですので

```bash
curl https://raw.githubusercontent.com/n8han/conscript/master/setup.sh | sh
```

でサクッと「csコマンド打てる状態」になりました。

## Webサービス側での用意

ちょーっとこっちが面倒臭いのですが、Webサービス側からの準備として

1. mindmeisterから「JSON入りアーカイブ」のダウンロードと解凍
0. Trelloからの情報取得
	+ 「Developer API Key」の取得
	+ 「」の取得
	+ 「タスクボードのID」の取得

という作業が必要です。(これはプログラムではなんともならんかった…)

### mindmeisterから「JSON入りアーカイブ」のダウンロードと解凍

mindmeisterで「タスクにしたいマインドマップ」を開いて下さい。

![明日やること](/images/2015-11-01-mm-todo.png)

画面右下の (↓) マークをクリックすると、エクスポート先選択のダイアログが現れます。

![エクスポート先選択](/images/2015-11-01-mm-export.png)

最初から選択されている「Mindmeisterフォーマット」をそのままに、
「エクスポート」をクリックして下さい。

`[マインドマップの名前].mind` というファイル名のZipファイルが落ちてきますので、
解凍して `map.json` というファイルを取り出して置いて下さい。

![mindmeisterのエクスポートZipファイル](/images/2015-11-01-mm-archive.png)


### Trelloからの情報取得

#### タスクボードのID

```url
https://trello.com/1/members/<username>/boards?key=<Key>&token=<Token>&fields=name
```

なのですが、ログイン中ならkeyとtokenはケズれるので…

```url
https://trello.com/1/members/<username>/boards?fields=name
```

## ツールインストール

```bash
cs kazuhito-m/mindmeister2trello-importer
```

## コマンド実行

上記で収集した情報をすべて引数にのせて、インポートを実行します。

```bash
m2ti [Developer API Key] [token] [タスクボードのIDの] [タスクリスト名] map.json
```

##

## ライブラリ選定

trello4jとtrello-java-wrapperを迷いましたが…

+ maven-centralに入ってる事(sbtにリポジトリ追加しなくていい)
+ ぱっと見、Usageが簡単そう感をアピってたから

trello-java-wrapperにしました。



# 小並感

個人的には「なかなか便利になった」感じがあるので、複数人での「ブレストからのタスク出し」に活用していきたいと思います。

そして「INとOUTがはっきりしたツール」なので、Webサービス化もあるかも？…とか構想が広がりますね。

ま、気が向けばやってきますね。

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
+ [conscript周り](http://pab-tech.tumblr.com/post/21134862609/scaladispatch%E3%81%A7tumblr%E3%81%AEapi%E3%82%92%E5%8F%A9%E3%81%8Fconscript%E3%81%A7%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%82%92%E4%BD%9C%E3%82%8B%E7%B7%A8)
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
