---
layout: post
title: '勉強会行ってみた「現場のアーキテクチャの話をしてみませんか？」#Devkan'
category: study-meeting-repo
tags:
  - architecture
  - architect
  - kozake
published: true
---

![会場の様子](/images/2015-09-15-kozakesan.jpg)

「思い知らしてやるわ〜」の人が登壇すると聞いて。(その勇姿は撮り手のせいでピンぼけにぼけてますが…w)

## 情報

+ [申し込みサイト](https://devlove-kansai.doorkeeper.jp/events/29702)
+ ハッシュタグ : [#devkan](https://twitter.com/hashtag/devkan)
+ 何するのか : 著名かつ多様なアーキテクトから経験を聞く…じゃないかな。

## なんで来たん？

上に聞いた通り「こざけさんが登壇すると聞いて！」ではあるのですが…。

最近、「なぜこんなに作りにくいのだろう？」「なぜこんなにメンテしにくいのだろう？」の考えることが多く
「仕組みにメスを入れられたら…」というシチュエーションが目の前に横たわります。

ただし「ソレを司るのには知識足りない」と。

そこで、この勉強会に行き当たりました。

## 内容

### 1コマ目「レイヤードアーキテクチャを意識したPHPアプリケーションの構築 Updateバージョン」

+ 登壇者: 新原 雅司さん ( [@shin1x1](https://github.com/shin1x1) )
+ 資料: 

<iframe src="//www.slideshare.net/slideshow/embed_code/key/srbgfWufMabUu1" width="340" height="290" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="//www.slideshare.net/shin1x1/php-ver2-52828655" title="レイヤードアーキテクチャを意識した PHPアプリケーションの構築 ver2" target="_blank">レイヤードアーキテクチャを意識した PHPアプリケーションの構築 ver2</a> </strong> from <strong><a href="//www.slideshare.net/shin1x1" target="_blank">Masashi Shinbara</a></strong> </div>

残念かつ失礼ながら…遅れてきて終盤あたりしか聞けてませんので、資料が出たらじっくり読みたいです。

ただ…

+ 最近DDDをかじった
+ 最近のいくつかの現場にて(他者による)「何でもかんでもServiceやで！症候群」にコテンパンにされてる

なので、そのあたり「どう調理しているのか」を達人から学びたいですね。

### ２コマ目「とある現場のシステムアーキテクチャー」

+ 登壇者 : 小酒 信一さん( [s_kozake](https://twitter.com/s_kozake) )
+ 資料 : 

<iframe src="//www.slideshare.net/slideshow/embed_code/key/DiBeTquq6FN5rp" width="340" height="290" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="//www.slideshare.net/s_kozake/ss-52758068" title="とある現場のシステムアーキテクチャ" target="_blank">とある現場のシステムアーキテクチャ</a> </strong> from <strong><a href="//www.slideshare.net/s_kozake" target="_blank">Shinichi Kozake</a></strong> </div>

割と詰め込まれていて「多くの重要なことを言っていた」のですが…駆け抜けたので資料を見なおして拾っています。

+ ボックス＆ライン図 - 俺は「これ」をいつも描いていたのか…。
+ "Artifactory"は良いのかな？ "nexus"しかやったこと無いから試したい
+ こんなにUMLをしっかり活用してるのは良いな
+ U/L/Dの三層は、名前が違ったり、もっと盛られたりするけど、普遍の概念になりつつあるな
+ 「ハリウッドの原則」はアジャイルラジオで最近知ったが、すごく説明しやすい話

「立ち上げ期、アーキテクトの情報収集と検討範囲は相当な労力なのだな」と思いました。

制約と要求の綱引きを掻い潜りながらモノを決めていく…俺なら「何が決まってて何が決まってないのか」を把握しとくだけでも大変そうな…。

---

「FWの用意・選定・(場合によっては)作成」の時点…その時点でのアーキテクトの仕事は

_「変化点だけは穴が開いているような、そんな"適切な穴あき問題"を提供する事」_

だと俺は思うのです。

それだけに「HotspotいわゆるオレオレFW」というのが腑に落ちませんでした。

「FWがHotspotになってしまう」ならそれはFWじゃない、もしくはFWじゃなくしたほうが良いのではないかと。

---

でも、「FWが一層挟まる」のは、今度はド賛成で…。

一般的な「構造的な問題を解決するFW」の上に、

_「作りたい業務の"短期変化点(Hotspot)だけ"を穴あき問題にしたFW」_

が抽出される事が多いハズ、と。
(無論、自社とかこのプロジェクト内とか、適用範囲は狭いものですが)

そこら辺、もうちょっと深く聞いてみたく思いました。(…今度聞いてみようw)

しかし…堂々たる発表っぷり、さすが「世界の〜」の冠を頂く方だけはありました。


### 3コマ目「私のアーキテクチャルディシジョン」

+ 登壇者 : 岡 大勝 さん [@OkaHiromasa](https://twitter.com/OkaHiromasa) さん
+ 資料 :

<iframe src="//www.slideshare.net/slideshow/embed_code/key/q59qS6sRJtpylX" width="340" height="290" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="//www.slideshare.net/hiromasaoka/ss-52914432" title="私のアーキテクチャルディシジョン" target="_blank">私のアーキテクチャルディシジョン</a> </strong> from <strong><a target="_blank" href="//www.slideshare.net/hiromasaoka">Hiromasa Oka</a></strong> </div>

※わりかし「口頭で話したこと」も多かったので、 [自作のメモ](/memos/2015-09-14-my-architectural-decision.html)を置いときます。

なんとなく…「人生は一秒も無駄にしちゃいけない！」と思わされるような衝撃のあるセッションでした。

「アーキテクチャは選択の集合体である、
そこで"アーキテクトとしての判断"=アーキテクチャルディシジョンが生きてくる」

と、主題と持論を明らかにした上で、

+ "それアカンやろ！"はアーキテクト魂の発芽
+ "俺の"Decision
+ チームがこの先10年、笑顔で居られるアーキテクチャを…

など、俺好みの「エモい話し」な人！…からの

+ 実現可能かを問いかけろ
+ 常に論理的であれ
+ 合議制は不要、自分で決めろ

という「妥協を許すな」という厳しさ、そして最後に

+ 結論：アーキテクチャは「未来のチームへのバトン」
+ まだ見ぬ後輩達に伝えるために、今、何をすべきか
+ それが私のアーキテクチャルディシジョン

という未来志向な使命を帯びて進むという締め、しびれました。

と、これだけ読むと「抽象論だけ？」と思われたかもしれません。

が、「TOGAF」「Zachman Framework」「4 + 1 View」「ISO/IEC 25010」「ATAM」など
「アーキテクトとして知っておくべきキーパーツ」も散りばめられていました。

ちょっと「超越者の話し」を聞いた感じですが、
明日に生かしていくなら、ここらへんから調べていこうかな？というヒントをもらいました。

## 小並感

自身は「アーキテクチャーを設計すること」は、まだまだ立場的にもスキル的にも出来ないと思います。

ただ、岡さんの言葉をいただいて「それ、あかんやろ！」を感じた時には、
「俺ならこうする」を考える訓練をしていきたいと考えています。
(実際、「あかんやろ」事案に遭遇することは多い)

しっかし、「DDD」といい「インフラ」といい「アーキテクチャ」といい…最近は「構造について想像力を使う」ことが多くて、
単純脳では具象物しか把握できず、偉人様たちの言葉を「理解する」だけでもなんとか…と足掻く日々です。

ちょっと興奮と知恵熱でまとまらない話しが益々まとまりません。失礼♪

## 追記

こちらのブログで、当記事をご紹介いただきました。ありがとうございます！

[現場のアーキテクチャの話を聞いてきた #Devkan - いつブロ](http://k-koba.hatenablog.com/entry/2015/09/18/060315)

相互補完的内容となっていますので、是非ご参考ください。
