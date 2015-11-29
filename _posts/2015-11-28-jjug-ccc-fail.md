---
layout: post
title: 勉強会行ってみた「JJUG CCC 2015 Fall」#jjug_ccc
category: study-meeting-repo
tags: [java,jjug]
---

![会場の様子](/images/2015-11-28-irof-in-jjug.jpg)

ついに…あの勉強会の初参加やでっ！

# 情報

+ [申し込みサイト](https://jjug.doorkeeper.jp/events/33514)
+ [タイムテーブル](http://www.java-users.jp/?page_id=2060)
+ [スライド・資料](http://d.hatena.ne.jp/chiheisen/20151128/1448708696) ※無断転載御免！
+ [当日まとめ(Togetter)](http://togetter.com/li/)
+ ハッシュタグ : [#jjug_ccc](https://twitter.com/search?q=%23jjug_ccc)
+ 何するのか : 日本最大のJavaユーザグループ「JJUG」の大規模勉強会？ですかね

# なんで来たん？

自身は「Javaは憧れの言語だが、余り書けない」という立場で…。

日本のJavaUGの総本山っぽい「JJUG」の勉強会に一度は参加したい！と思ってたのですが、
「あんま知らんおれが行ってもなぁ」と思ってまして。

ただ、今回は「[あの人](https://twitter.com/irof)や[あの人](https://twitter.com/backpaper0)が登壇する？」と聞いて、これは良い機会！と思い切って参加してみました。

※俺にとっては勉強会はエンターテイメントで登壇者はスターなんで、ただのファンの追っかけ…といえますねｗ

# 内容

※あんまJavaについては語れるものが無いので、一言感想だけ。

## 1コマ目「基調講演1 : Javaは守りに入らない、これが今のJavaだ」

+ 登壇者 : 谷本 心 ( [@cero_t](https://twitter.com/cero_t) ) さん
+ 資料:

残念ながら間に合わず、前半聞きそびれました…。(なので前半話したらしい「トレンド」の感想無し)

最近のJavaの動向とともに、「本日そのトレンドにあったセッションがありますよ！」という
ツアーガイドのセッションでした。

自分はせろてぃさんの発表を聞くのは二回目なんですが…

「"スベる"という現象が起きようが起きまいが"スベる"というエンターテイメントを提供するゲラゲラ」

というちょっと嫉妬してしまう、そんな素晴らしい(俺好みの)セッションでした(ファンです)。

## 2コマ目「基調講演2：Java EE 8 – Work in Progress」

+ 登壇者 : David Delabassee さん  ( [@delabassee](https://twitter.com/delabassee) )
+ 資料:

JavaEEの「最新のトピック」と「今、エキスパートチームが取り組んでる課題群」の情報が手に入る、そんなセッションでした。

俺の「勝手なイメージ」では

__「再編されてからは、JavaEEはトレンドや議論を呼んだプロダクト・実装のグッドパーツをある程度吟味しながら中央値を取り、それを取り込んでいく集積場」__

だと思っていて「目新しさは無いものの『ほーええんちゃう？』なものが出てくる」印象です。

序盤、初っ端かつ結構時間を割いて説明してた「JSON」というテーマも、そんな印象でした。

---

自身の心にひっかかったのは「現在、シンプル・簡単にすることに取り組んでる」という話。

ライブラリにおいての「シンプル・簡単」は

1. ライブラリのソース自体
0. 使い手にとっての

と2つあると思いますが、両方に取り組んでいるようで…。

「すでにあるもの」を「シンプル・簡単」にする…のはとても難度の高い事(しかも量に応じて二次曲線的に飛躍)…だが重要なことなので「よくぞ…すごい！」と思いました。


---

※ここから選択制です


## 3コマ目  「GH-1 JAX-RS入門および実践」

+ 登壇者 : 浦上 太一 さん ( [@backpaper0](https://twitter.com/backpaper0) )
+ 資料 : [http://backpaper0.github.io/ghosts/jaxrs-getting-started-and-practice.html](http://backpaper0.github.io/ghosts/jaxrs-getting-started-and-practice.html)

個人的興味として「大きな会場でのうらがみさんの発表がどんなもんか」が見たかったのですが…さすがでしたｗ

これ1つきけば、JAX-RSの

+ 基本的使い方
+ イベントモデル
+ 経験からの適用事例・工夫・問題解決

が手に入る！(…かどうかは聞き手の集中力次第)という有難いセッションでした。

惜しむらくは「(ソースなどは)割愛します」が多数「テスト…については時間切れです」と、時間足りなさが顕著に見られたこと。

ま、それも…

<blockquote class="twitter-tweet" lang="ja"><p lang="ja" dir="ltr">関西で再演を約束してくれたので、関西のみんな楽しみに待ってようねー！！ / JAX-RS入門および実践 <a href="https://t.co/WGJRAlsvYH">https://t.co/WGJRAlsvYH</a></p>&mdash; Mitsuyuki.Shiiba (@bufferings) <a href="https://twitter.com/bufferings/status/670767788223541249">2015, 11月 29</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

とのことなので、そちらに期待しましょう♪ ※ただし関西人に限る


## 4コマ目「EF-2 How to speed up your application using JCache」

+ 登壇者 : Greg Luck さん ( [@gregrluck](https://twitter.com/gregrluck) )
+ 資料 :

Hazelcast CTO、Gregさんによる、キャッシュライブラリ「JCache」の解説セッション…のはずだったのですが。

「キャッシュについて」という概念説明で大半の時間を使い、JCacheの説明が「2〜3枚だけ重要なとこを説明」と、凄く「もっと見たい！」な時間でした。

※「英語で聞いている人何人居ます？」で手が少なかったのを怪訝な顔してらしたので、おそらく「通訳の時間が想定以上にで計算狂った」のではないかと…。

---

その「キャッシュの概念説明」ですが、

+ 二回以上のデータ参照はキャッシュの対象
+ CPUからストレージまで、どのレイヤーでもキャッシュを考えられる
+ 適切にやれば1000倍なんて例もある

という「他人に説明する時に必要な事」がすべて詰まっていて「よくぞ言ってくれた！」感じがあっていつまでも聞いていたいものでした。

---

多分、多くのJavaプログラマがそうだと思うのですが…

+ 自前行レベルの内部キャッシュ(ま、Mapとかですけど)
+ 自前メソッドレベルの内部キャッシュ(前後にMap置く、とか)
+ 自前仕込みのAOPでメソッドレベルの外部キャッシュ
+ プロダクトの設定任せでの外部キャッシュ

とか、(キャッシュと呼べない程度のデータ退避も含め)何かしらのキャシュ機構と戦ってると思います。

自身も「なんとかChace」なクラスをシチュエーション別に何回も作った記憶があります。

その「シチュエーション別に何回も」を「どんな風に一般化してんのか」が気になります。

てこってJCacheは、久しぶりに「理解してみたいプロダクト」を見つけました。


## 5コマ目「CD-3 よくある業務開発の自動化事情」

+ 登壇者 : [@irof](https://twitter.com/irof) さん
+ 資料 : <iframe src="//www.slideshare.net/slideshow/embed_code/key/mkCRE8ss0dCb0y" width="595" height="485" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="//www.slideshare.net/irof/jjugccc-ccccd3" title="よくある業務開発の自動化事情 #jjug_ccc #ccc_cd3" target="_blank">よくある業務開発の自動化事情 #jjug_ccc #ccc_cd3</a> </strong> from <strong><a href="//www.slideshare.net/irof" target="_blank">irof N</a></strong> </div>



    

## 6コマ目「EF-4 ソラコムでのJava/AWS活用 – SIM管理やAWS Lambda Javaなど」

+ 登壇者 : 片山 暁雄 さん ( [@c9katayama](https://twitter.com/c9katayama) )
+ 資料 : <iframe src="//www.slideshare.net/slideshow/embed_code/key/Myt7G3fP1JL81I" width="595" height="485" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="//www.slideshare.net/SORACOM/java-jjug-ccc-2015-fall-by" title="日本 Java ユーザーグループ　JJUG CCC 2015 Fall by ソラコム 片山 " target="_blank">日本 Java ユーザーグループ　JJUG CCC 2015 Fall by ソラコム 片山 </a> </strong> from <strong><a href="//www.slideshare.net/SORACOM" target="_blank">SORACOM,INC</a></strong> </div>

本読んでるのに忘れてた「AWS-CloudDesignPattern」の共著者、片山さんのセッションです。

序盤「ソラコムがAWSを使って作成したIoT事業者向けサービス」の話をされていて、
しょーじき「プロダクトの宣伝？」と思ったのですが…。

ところがどっこい！「で、自社用のSIM管理システムにJava使ってるんです」の話が「今どきのハード込のシステムの形」を学ばせて頂いた気がします。

---

自分の偏見では、Javaプログラマって「ソフトウェアオンリーな人」「ギョームな人」が多いと思っています(俺もその一人です)。

もしそうなら「物体を扱う」って少し壁がある…。

その壁を穿つのにワンチャンあるのが、

+ 廉価なデバイス
+ 簡易ライブラリ

だと思ってます。

今回の例で出てきた"javax.smartcardio"の話はもちろん、ラズベリーパイにはGPIOを弄う「Pi4J」、Javaでの技術は特定できてませんがRFIDを扱うライブラリなど「習熟にそれほどかからず、お試しも財布にいたく無い」なら「習得出来る」と。

「習得できた」なら、システム設計に「ソフト➔物理➔物理➔ソフト」みたいな機構が考えられたり「設計の発想の幅が広がる」と思うんですよ。

そういう意味でも、多くの人に刺激を与えるセッションだったと思います。


## 7コマ目「EF-5 これからのコンピューティングの変化とJava」

+ 登壇者 : きしだなおき さん ( [@kis](https://twitter.com/kis) )
+ 資料 :

アニメの話、昨今のコンピュータの話から、それを使った問題解決のトレンド、そしてそれに関連して検討されているJavaの仕様の話を凝縮したセッションでした。




## 8コマ目「GH-6 Java8 Stream APIとApache SparkとAsakusa Frameworkの類似点・相違点」

+ 登壇者 : ひしだま さん ( [@hishidama](https://twitter.com/hishidama) )
+ 資料 :

## 8コマ目「GH-7 てらだよしおの赤裸々タイム」

+ 登壇者 : てらだよしお さん ( [@yoshioterada](https://twitter.com/yoshioterada) )
+ 資料 :


## 懇親会(ビアバッシュ)


# 小並感

運営スタッフの方たちが素晴らしい仕事をしていたと思いました。

特に、多くの方が言われていたのですが「通訳していただいた方(名前の紹介があったのですが失念しましたすません)の努力とクオリティがすごい！」と。

それらを維持している並々ならぬ努力には、感謝するばかりです。

---s

# おまけ
