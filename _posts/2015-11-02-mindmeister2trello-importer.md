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

`「Mindmeisterの末端アーティクル -> Trelloのカード へと転送」`

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

画面右下の (↓) マークをクリックすると、エクスポート先選択のダイアログが現れます。

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
https://trello.com/1/authorize?key=<上で取得したKey>&name=&expiration=never&response_type=token&scope=read,write
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
https://trello.com/1/members/<username>/boards?key=<Key>&token=<Token>&fields=name
```

を指定することで「自身が見られるタスクボード名とIDの一覧」が取得できます。

ですが、ログイン中ならkeyとtokenはケズれるので…

```url
https://trello.com/1/members/<username>/boards?fields=name
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


