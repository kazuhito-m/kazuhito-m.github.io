---
layout: post
title: 「MindmeisterからTrelloのカードを作成するツール」をScala作ってみた
category: tech
tags: [mindmeister,trello,conscript,scala,trello-java-wrapper,json4s]
---

自身は「何かどうやっていいかわからないこと」や「ゴールへの道筋がわからないもの」に当たる時、「マインドマップツール」を使用します。

この時の使い方は「タスク分解機」であり「放射状アウトラインエディタ」だったりします。(マインドマップ書いてませんw)

最近は「複数人で同時編集出来る」という理由で「[Mindmeister](https://www.mindmeister.com/)」というWebサービスを使うことが多いのです。

で、そのタスク分解したものは「[Trello](https://trello.com)」という、
タスクボードのコレまたWebサービスに転記して整理・Todo消化とかしていくわけです。

がっ！当たり前ながらその転記がめんどい…ので！

`「Mindmeisterの末端アーティクル →  Trelloのカード へと転送」`

するバッチを作りました。

# 使い方

## 前提

+ Scala/conscriptが動くOS環境であること(筆者はUbuntu Linux)
+ Mindmeister, Trelloにはアカウントを持っていること

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

1. Mindmeisterから「JSON入りアーカイブ」のダウンロードと解凍
0. Trelloからの情報取得
	+ 「API Key」の取得
	+ 「API Token」の取得
	+ 「タスクボードのID」の取得

という作業が必要です。(これはプログラムではなんともならんかった…)

### Mindmeisterから「JSON入りアーカイブ」のダウンロードと解凍

Mindmeisterで「タスクにしたいマインドマップ」を開いて下さい。

![明日やること](/images/2015-11-02-mm-todo.png)

画面右下の「下向き矢印マーク」をクリックすると、エクスポート先選択のダイアログが現れます。

![エクスポート先選択](/images/2015-11-02-mm-export.png)

最初から選択されている「Mindmeisterフォーマット」をそのままに、
「エクスポート」をクリックして下さい。

`[マインドマップの名前].mind` というファイル名のZipファイルが落ちてきますので、
解凍して `map.json` というファイルを取り出して置いて下さい。

![MindmeisterのエクスポートZipファイル](/images/2015-11-02-mm-archive.png)

### Trelloからの情報取得

[こちらのページ](http://qiita.com/isseium/items/8eebac5b79ff6ed1a180)と同じことをするのですが、ちょいちょい説明していきます。

#### 「API Key」の取得

Trelloにログインした状態で、

[https://trello.com/1/appKey/generate](https://trello.com/1/appKey/generate)

にアクセスして下さい。

画面、上側ｎ表示されている「Key:」の文字列がAPI Keyです。記録しておいてください。

#### 「API Token」の取得

今度は、取得した「API Key」を使って「Cardの投稿が出来る権限」を持った「API Token」を取得します。

以下のURLを組み立てて、アクセスして下さい。

```bash
https://trello.com/1/authorize?key=[上で取得したKey]&name=&expiration=never&response_type=token&scope=read,write
```

確認画面が出るので「Allow」をクリックして下さい。

クリックすると「シンプルな白地テキスト」以下のような感じの表示がなされます。

```
You have granted access to your Trello information.
To complete the process, please give this token:
  XXXXXXXXXXXXXXXXXXXXXXXX
```

この「XXX...」の部分が「API Token」です。記録しておいて下さい。

#### タスクボードのID

タスクボードへは「タスクボード名」でも「日頃見てるURL」でもなく、内部で使用している
「タスクボードのID」とでも呼ぶようなものでタスクボードを特定します。

そのため、対象と成る「タスクボードのID」を取得しましょう。


```url
https://trello.com/1/members/[username]/boards?key=[Key]&token=[Token]&fields=name
```

を指定することで「自身が見られるタスクボード名とIDの一覧」が取得できます。

…が、ログイン中ならkeyとtokenはケズれるので…

```url
https://trello.com/1/members/[username]/boards?fields=name
```

で取得できます。指定すると…

```json
[
    {"name": "テスト","id": "XXXXXXXXX..."},
    {"name": "日常","id": "XXXXXXXXX..."}
]
```
のようなJSONが帰ってきます。(実際は改行無し)

"name"で「今回カードを作りたいタスクボード」を探し、"id"を記録しておいて下さい。

## ツールインストール

ここで、やっと「準備」で用意した「conscript(csコマンド)」を使います。

コンソールから、以下を実行して下さい。

```bash
cs kazuhito-m/mindmeister2trello-importer
```

最後に

```
Conscripted kazuhito-m/mindmeister2trello-importer to ...
```

とか出ていればインストール完了です。



## コマンド実行

上記で収集した情報をすべて引数にのせて、インポートを実行します。

以下をコンソールから実行して下さい。

```bash
m2ti [API Key] [token] [タスクボードのIDの] [タスクリスト名] map.json
```

「タスクリスト名」というのは「タスクボード中のリストの表示名」です。(よく"Doing","Done"とかにしてるアレです)

今回の情報を元にすると…

```bash
m2ti XXXX... XXXX... XXXX... 'To Do' map.json
```
という感じになりました。(割と長いコマンドになりますね)

---

実行すると目的のタスクボード、タスクリストに"-"(ハイフン)区切りで要素名をつなげたカードが出来上がります。

![こんな感じ](/images/2015-11-02-mm-exported.png)

Trelloを表示しながらコマンドを実行すると「カードがみるみる足されていく」ので面白いですね。

## 実装面

[こちらのリポジトリ](https://github.com/kazuhito-m/mindmeister2trello-importer) にソースがあります。

基本構成は、

+ Scala
+ [sbt](http://www.scala-sbt.org/0.13/tutorial/ja/)
+ [conscript](https://github.com/n8han/conscript)
+ [giter8でテンプレ作成](http://qiita.com/asmasa/items/68f90db705bd44f4e590)
+ github-pagesをリポジトリにして配布

な[昨年末クローラ作った時の構成](http://natural-born-minority.blogspot.jp/2014/12/bot-irofhistory.html) です。

実現機能のために、

+ [json4s](https://github.com/json4s/json4s)
+ [trello-java-wrapper](https://github.com/bywan/trello-java-wrapper)

を追加しています。

## ライブラリ選定

trello4jとtrello-java-wrapperを迷いましたが…

+ maven-centralに入ってる事(sbtにリポジトリ追加しなくていい)
+ ぱっと見、Usageが簡単そう感をアピってたから

trello-java-wrapperにしました。

# 小並感

いやーScalaはなというか…「加減考えんといかんくらいリファクタングが出来る」のが凄いですね。

数えて見ると…「賞味のロジックが１ファイル20行満たない」「でも頃合い」というのは凄い。

---

ツールとして、個人的には「なかなか便利になった」感じがあるので、複数人での「ブレストからのタスク出し」に活用していきたいと思います。

そして「INとOUTがはっきりしたツール」なので、Webサービス化もあるかも？…とか構想が広がりますね。

ま、気が向けばやってきますね。

# 参考

以下を参考にさせていただきました。ありがとうございます。

+ [http://qiita.com/isseium/items/8eebac5b79ff6ed1a180](http://qiita.com/isseium/items/8eebac5b79ff6ed1a180) これがキモ
+ [https://github.com/bywan/trello-java-wrapper](https://github.com/bywan/trello-java-wrapper)
+ [https://github.com/ForNeVeR/trello4j](https://github.com/ForNeVeR/trello4j)
+ [https://github.com/n8han/conscript](https//github.com/n8han/conscript)
+ [http://qiita.com/ha_g1/items/d41febac011df4601544](http://qiita.com/ha_g1/items/d41febac011df4601544)
+ [http://mocobeta-backup.tumblr.com/post/123266618477/100-2015-scala-3](http://mocobeta-backup.tumblr.com/post/123266618477/100-2015-scala-3)
+ [https://gist.github.com/takuya71/4025974](https://gist.github.com/takuya71/4025974)
+ [https://github.com/json4s/json4s](https://github.com/json4s/json4s)
+ [http://d.hatena.ne.jp/Kazuhira/20140419/1397895464](http://d.hatena.ne.jp/Kazuhira/20140419/1397895464)
+ [conscript周り](http://pab-tech.tumblr.com/post/21134862609/scaladispatch%E3%81%A7tumblr%E3%81%AEapi%E3%82%92%E5%8F%A9%E3%81%8Fconscript%E3%81%A7%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%82%92%E4%BD%9C%E3%82%8B%E7%B7%A8)
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
	+ [http://qiita.com/asmasa/items/68f90db705bd44f4e590](http://qiita.com/asmasa/items/68f90db705bd44f4e590)
