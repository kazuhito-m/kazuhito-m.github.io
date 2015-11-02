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

