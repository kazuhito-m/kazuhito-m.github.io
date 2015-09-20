---
published: false
layout: post
title: 勉強会行ってみた「DDD（ドメイン駆動設計）実践者の話を聞いてみよう」#Devkan
category: study-meeting-repo
tags: [ddd]
---

![会場の様子](/images/2015-09-xx-xxxx.jpg)

重要なのは解る…が、勉強が追いついてない、足り無い！

## 情報

+ [申し込みサイト](https://devlove-kansai.doorkeeper.jp/events/30012)
+ ハッシュタグ : [#devkan](https://twitter.com/hashtag/devkan)
+ 何するのか : 著名人や実践者から「DDDの"実際"」を聞く…のかな。

## なんで来たん？

去年くらいから、DDDの勉強を始めたんです。

全然手探りだったのですが、先日の「[関西DDD.java](http://kansaiddd.connpass.com/event/17737/)」の増田さんの言葉で
「俺、間違って無かったんや…」「俺、これかもしれん…」という確信めいた何かをもらった…気がしておりまして。

最近「関西でDDDと名が付けば」勉強会に参加して行ってる次第で…今回もやって来ました！(その増田さんの来阪ですしね)

## 内容

### 1コマ目「ドメイン駆動設計 思えば遠くにきたもんだ」

+ 登壇者: 増田 亨さん ( [@masuda220](https://github.com/masuda220) )
+ 資料: <iframe src="//www.slideshare.net/slideshow/embed_code/key/BevtPE8jbuRTyY" width="425" height="355" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="//www.slideshare.net/masuda220/ss-52960414" title="ドメイン駆動設計 思えば遠くにきたもんだ" target="_blank">ドメイン駆動設計 思えば遠くにきたもんだ</a> </strong> from <strong><a href="//www.slideshare.net/masuda220" target="_blank">増田 亨</a></strong> </div>

「エリックエバンスのドメイン駆動設計」の書籍を題材に、増田さんの歩んだ道ともに、DDDの勘所をお教えいただいています。

資料は素晴らしくまとめられていますが、「お話」に真骨頂だったと思うので、
箇条書きおいておきます。(少し意訳)

### 「お話」成分補完メモ

+ ドメインモデル
  + 「要は…？」の話しへの切り込み、コアつかみに行く
  + コアがぼやけると、ドメインそのものもボケる
  + 設計やモデルは日々成長するものだ
    + 機能までが今日正しいとは限らない
    + 「完成したものがある…ソレを探し当てる」…では無いのだ
    + 「モデルがキレイ」「コードがキレイ」が「出来た」ではないという懐疑心
+ 「モデル」と「実装」を結びつける
  + 脳内イメージと実装が一致してない…これは違う
+ ソフトウエアの核心にある複雑さ
  + 挑戦し続けている
+ 「適応型」のソフトウェア開発
  + 「新しいことしようぜ」みたいなヒューマニティを維持する
+ 転換点
  + ずっと疑問だったこと
    + アジャイルでの「設計」のやり方
      + XPは最初「だめだこりゃ」と思った
+ 変化を目指すチーム
  + シンプリシティ
    + 「単純」は「要素を絞る」と勘違いしてしまうとダメ
    + 粗結合の追求
    + 「重要な感心事」と「ソレ以外の区別」をしておくこと
  + フィードバック
    + 議論より行動を
  + 勇気
    + 「おかしさを耐え忍ぶ」という忍耐力
  + リスペクト
    + 「お互いのか投げと行動に関心を持つ」のが刺さった
+ 変化に適応しながら成長を続ける
  + ソフトウエアの核心にある複雑さに立ち向かうための開発スタイル
    + チームが成長して良い方向へいく
    + 画面やデータより「コアはなにか？」を追い求めるアプローチを模索中
    + 最初に「コアモデルを作る」というやり方
+ オブジェクト思考と「変更容易性」
  + モジュラープログラミング
    + Erlangなどが「最初にオブジェクト志向が目指した世界」なんじゃないか
+ オブジェクト志向への道
  + オブジェクト指向言語はよくわかって無かった
    + 冗長で遅いものだとしか思わなかった
    + 1998年ごろ、ベターCでしかなかった
+ 転換点 : 大規模(炎上)案件への誘い
  + C#だからというわけではないｗ
  + リファクタリング
    + 面白いように効果が出てくる
+ 手続き型からオブジェクト志向へ
  + 型をつけていくことにより「どこになにがあるか」を把握しやすく成る

### 心に残った事

+ 本質的"でない"モノを削る力

これはわかるのですが…難しいのですよね。人間は「増やす」方のベクトルのほうが強いですし。

でも、これができていると「見た人の理解が早い」
転じて「立場違いの人がレビュー出来そうなモデル」になるかなと…最近の感じです。

+ 抽象データ型・段階的な抽象化、コードを人間に近づけていく

すごくしっくりくる、いつも考えてるのはこういうことなんですよね。

---

増田さんのお話を聞くのは2回目なのですが「あまりにも自然に共感・納得してしまう」ので…
「もしかして…曲解して解ったつもりになってないか？」と自問せねばならず、大変ですｗ


### ２コマ目「」

+ 登壇者 : 尾篭 盛さん( [@ogomr](https://twitter.com/ogomr) )
+ 資料 : [Qiitaの記事](http://qiita.com/ogomr/items/8616ace9f32efc0eecd7)

「ぷ…PlantUMLや…！！」

Graphbiz系から自力でたどりついて、現場でつかってた「[PlantUML](http://yohshiy.blog.fc2.com/blog-entry-152.html)」の話しが出てきたので、それに興奮してしまって…
本編の記憶が飛んでます。(すみません)

話し的には「T字形ER手法(TM)」の話しだったと思うのですが…

「データベース設計の話がDDDのモデリングに？」と、頭の悪い俺にはようわかりませんでした。

## ３コマ目「ドメイン『駆動』『開発』」

+ 登壇者 : 前川 博志さん( [@posaune](https://twitter.com/posaune) )
+ 資料 : (未投稿)<iframe src="//www.slideshare.net/slideshow/embed_code/key/9PIP6SmhYt4Ys" width="425" height="355" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="//www.slideshare.net/Posaune/ss-52982034" title="ドメイン『駆動』『開発』" target="_blank">ドメイン『駆動』『開発』</a> </strong> from <strong><a href="//www.slideshare.net/Posaune" target="_blank">Hiroshi Maekawa</a></strong> </div>

TODO

## ４コマ目「保守とDDDと私」
　
+ 登壇者 : 川辺 卓矢さん( [@kawakawa](https://twitter.com/kawakawa) )
+ 資料 : <iframe src="//www.slideshare.net/slideshow/embed_code/key/jUFc2mKFuzhayy" width="425" height="355" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="//www.slideshare.net/kawakawa__/ddd-52952272" title="保守とDddと私" target="_blank">保守とDddと私</a> </strong> from <strong><a href="//www.slideshare.net/kawakawa__" target="_blank">Takuya Kawabe</a></strong> </div>

TODO

感想：「OOの根幹を成す「」」

## ダイアログ

## 増田さんに聞いてみようディスカッション

## 小並感
