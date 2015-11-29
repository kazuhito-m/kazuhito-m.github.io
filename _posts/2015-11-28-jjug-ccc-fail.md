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

## 1コマ目「基調講演1 : Javaは守りに入らない、これが今のJavaだ」

+ 登壇者 : 谷本 心 ( [@cero_t](https://twitter.com/cero_t) ) さん
+ 資料:

残念ながら間に合わず、前半聞きそびれました…。(なので前半話したらしい「トレンド」の感想無し)

最近のJavaの動向とともに、「本日そのトレンドにあったセッションがありますよ！」という
ツアーガイドのセッションでした。

自分はせろてぃさんの発表を聞くのは二回目なんですが…

__「"スベる"という現象が起きようが起きまいが"スベる"というエンターテイメントを提供するゲラゲラ」__

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

+ 登壇者 : うらがみ さん ( [@backpaper0](https://twitter.com/backpaper0) )
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

もうプログラム分野では多彩すぎて「関西住みのJavaのすごい人」としか言いようがない、[@irof](https://twitter.com/irof) さんのセッションです。

「自身が見聞きしてきた直近のいくつかの現場における、ギョームアプリ開発の自動化」についての知見…をJava視点でまとめたものですかね。

※この記事のトップ絵は、このセッションのものです。超満員！！

---

感じたのは「発表巧者だなー」と言うところ。

俺は、勉強会の技術系のセッションでも「上手い人の発表はエンターテイメント」だと思ってる人です。

そういうエンタメ目線で行くと、お客さんの「注目を維持する」ってのは、かなり難しくて

+ つかみ重要
+ 全編平坦はだめ、全編テンション高でもだめ
+ つかみはOK、でもその後盛り上がりがなければ「期待したけど…そんなか」の印象を与えかねない
+ 要所要所にお客さんが盛り上がるトコがあるのが重要

などを(ある程度)考えないと、「後半睡眠者続出」とかになりかねない…。

と！言うところを「(上に書いたこと)全部うまいことやってた」のでそこに感動しました。
    

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
+ 資料 : <iframe src="//www.slideshare.net/slideshow/embed_code/key/A9IgZIp9cRBwnB" width="595" height="485" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="//www.slideshare.net/nowokay/javahacker-tackle" title="これからのコンピューティングとJava(Hacker Tackle)" target="_blank">これからのコンピューティングとJava(Hacker Tackle)</a> </strong> from <strong><a href="//www.slideshare.net/nowokay" target="_blank">なおき きしだ</a></strong> </div>

アニメの話、昨今のコンピュータの話から、それを使った「機会学習」など問題解決のトレンド、そしてそれに関連して検討されているJavaの仕様の話を凝縮した、手書きの図がかわいげなセッションでした。

内容ももちろん上質だったのですが、すごい！と思ったのは「そのセッションの構造」で、「これだけの広く距離のあるパラダイムをシームレスにつないで50分におさめている」ところ。

無理なく興味の質を失わせず、自然に聞かせる…という事を感じつつ、口あけながら聞いていました。



## 8コマ目「GH-6 Java8 Stream APIとApache SparkとAsakusa Frameworkの類似点・相違点」

+ 登壇者 : ひしだま さん ( [@hishidama](https://twitter.com/hishidama) )
+ 資料 : <iframe src="//www.slideshare.net/slideshow/embed_code/key/23yOyPJaKS8ZIr" width="595" height="485" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="//www.slideshare.net/hishidama/java8-stream-apiapache-sparkasakusa-framework" title="Java8 Stream APIとApache SparkとAsakusa Frameworkの類似点・相違点" target="_blank">Java8 Stream APIとApache SparkとAsakusa Frameworkの類似点・相違点</a> </strong> from <strong><a href="//www.slideshare.net/hishidama" target="_blank">hishidama</a></strong> </div>

「日本全国のJavaプログラマの"入門"や"ググれ"を一手に支えてる」のではないか？
といっても過言ではないと思われる、ひしだまさんによる「分散データ処理機構の比較」のセッションです。

内容は

+ Java8 Stream API
+ Apache Spark(Apache Hadoop)
+ Asakusa Framework

の目的/方針や構造、特性や「使う時の構文」の違いと実用した結果についての考察でした。

「DAG(有向非循環グラフ)」を知っている事が前提っぽく、俺は知らなかったので、それを知ったうええ見返したく思います。


上に同列に書きましたが「Asakusa Frameworkで書いて実行基盤をSparkに」など出来るので、
「Asakusa Framework + Apache Spark」が結論としてベスト、という感じがしました。

Asakusa Fremeworkの思想「バッチアプリケーションを作成するため」ってのが「どのようなところに対応されているのか」というところ、俺はギョームプログラマで「提案の種」なので、きっちり知りたくなりました。

また「バッチのため」といえども「世の大半のギョームアプリはRDBMSにデータを貯めている」というところから「分散DBにする設計と事例」も興味を持ちました。

…まぁ…「世の中には情報ある」だろうし、調べてないだけなので、自分の問題ですがw


## 8コマ目「GH-7 てらだよしおの赤裸々タイム」

+ 登壇者 : てらだよしお さん ( [@yoshioterada](https://twitter.com/yoshioterada) )
+ 資料 : (恐らく無いんじゃないかなーw)

てらだよしおさんによる「台本の無い？」セッションです。

7月にMSに電撃移籍をされたその理由や自身の思いを語ってらっしゃいました。

中盤に質問コーナーがありまして、

+ MS入社したて一発目であった「ニコニコ生放送」の事情(質問は俺でしたすみませんw)
+ 今「一番聞かれたく無い質問」はなんですか？
+ 転職において重要なこと(人の見方？)はなんですか

に答えてらっしゃいました。(内容は書きません、参加者のみの特典、ということでw)

---

最後の質問の答えで「自分の言葉ではない」と言いつつ、

__「オールマイティな人より、ピンが尖ってる人をあつめ、その横のつながりを強化していったほうが良いのではないかなと…」__

っておっしゃられたのは、すごい納得なのと「じゃあ、俺にそういうもんは？…うーん」と考えさせられる言葉でした。


## 懇親会(ビアバッシュ)

朝の時点で「無料になりました」「申込者以外も自由になりました」嬉しいサプライズもあり、盛況でした。

LT大会や「それが聞こえない程みなコミニュケーション取ってる」「ところどころ人だかりが自然発生」という状況、みんな楽しんでたんだろうなーと思います。



# 小並感

運営スタッフの方たちが素晴らしい仕事をしていたと思いました。

特に、多くの方が言われていたのですが「通訳していただいた方(名前の紹介があったのですが失念しましたすません)の努力とクオリティがすごい！」と。

それらを維持している並々ならぬ努力には、感謝するばかりです。

---

恐らく「多くの人がそう思ってる」とおもいますが…

__くっそー、あの「横でやってた話」すっげーききたかったぜー！！(泣__

という感覚。

なんか伝聞で

+ あのうらがみ氏がマイクを持った
+ Dockerの話おもしろかった
+ 「技術的負債」の話、超満員だった
+ 「Reactiveの話」はいろいろと勉強になった
+ ヤンク氏会場どっかんどっかん揺らす

とか「そんなんおもろいにキマってるやんｗ」を見逃したものが多かった。(とくに泣く泣く切ったものに限ってw)

まーそれだけ「JJUG-CCCは魅力的なコンテンツを集約できている」という証左でもあります。

---

すーごく「雑な纏め」をすると


__すげぇ楽しかった！また来たいぜ！__


てな感じでした。参加された方もそうでない方も、またお会いしましょう！

---

# 感謝の意

まぁ、正直な話「Javaにはあんまり縁はない」「ほっとくとボッチまっしぐら」な俺に対して、

+ まさかの受付にて「なんできたん？」対応してくれた @ihcomega さん
+ 心細かったとこに耐えずどっかにおって声かけてくれた関西勢のみなさん( @s_kozake さん , @yukeen さん , @irof さん , bufferings さん)
+ 会話が「あ、みうみうおつかれー。探してんねん炭水化物！炭水化物！！」だけだった @backpaper0 さん
+ 邂逅一番「もー落ち込んでるって聞いて心配してたんですよー！」つって肩脱臼するくらいバンバン殴打してくれた ビルの主 ( @syobochim さん )
+ 久々でも「おひさ♪」くらいの気軽さで話しかけてくれた @zer0_u 嬢、@ngsw_taro さん 、 @kis さん
+ そちらからお声をかけて(俺なら勇気が要ります！)いただいた @PoohSunny さん
+ やっと相互認識いただいた(こちらもできた) @mike_neck さん 、 @peko_kun さん、@mame_pika さん、@kazuhira_r さん、@soudai1025 さん
+ 初対面で気さくにはなしていただいた @takesi_yosimura さん、@i_takehiro さん  
+ ニアミスからやっと相互認識頂いた @cero_t さん
+ 酷い質問したけど「相互認識いただいていた」 @yoshioterada さん
+ 「ナンパしたことになってる」 @dahlia_cocoa さん (すみません)
+ (見てないけど)会場どっかんどっかんだったらしい @yy_yank さん(見てないけど)
+ リアルに会ってもきっちり「そゆのもったいない！がんばれよ！」の言葉をくれはった @yusuke さん
+ 「この人としゃべるでしょ！紹介するよ！」って連れてってくれた @kotomacontact さん、@haljik さん、@chiroito さん、@soudai1025 さん
+ 何が何でも「会ってくれなかっ」た @hijireee さん
+ 要所要所いーかんじでちゃちゃいれてきた @tonymorrisjp
+ その他相手してくれたみなさん

な皆様、本当にありがとうございました。 




