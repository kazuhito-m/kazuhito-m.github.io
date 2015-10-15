---
layout: post
title: 勉強会行ってみた＆登壇してみた「第01回 関西golang勉強会」#KUG2
category: study-meeting-repo
tags: [golang,programing]
---

![画面はコラです](/images/2015-10-12-karaagematsuri.jpg)

関西で正式にGO言語の勉強会が始まった…はずなんだがやっぱりカラアゲだった。

# 情報

+ [申し込みサイト](http://kug2.connpass.com/event/20497/)
+ ハッシュタグ : [#KUG2](https://twitter.com/search?q=%23KUG2)
+ 何するのか : プログラム言語「GO」を学びたい人が、わいがやでセッション聞く勉強会…でしょうかね…。

# なんで来たん？

[このはなし](/study-meeting-repo/2015/09/21/golang-study-01/)の延長線上にあって、
「やっとこさ正規開催となった」golangの勉強会に、自分もアンテナ張って、ある程度見識・知見を広めようと来ました。

…まぁ「自身がゼロ回目(企画会議)の際に安請け合いしたLT」を「なんとかこなす！」ってのも、
自身の参加する目的の部分で大かったわけですが…。


# 内容

## 1コマ目「GoでGoのプラグインを書く・・けなかった話」

+ 登壇者 : Yusuke Hatanaka さん( [@Hatajoe](https://twitter.com/Hatajoe) )
+ 資料 : [こちら](http://go-talks.appspot.com/github.com/hatajoe/go-plugin-example/index.slide)

golangで「C言語のshared libraryを書く」という話しをメインに、golang用のプラグインを書こうとした奮闘記でした。

__「ゲーム開発者ってのは、開発の事だけを考えたい…なんなら開発もしたくなくて、ずっとゲームだけしてたいもので…」__

---

自分はCも昔ちょっと触った程度ですが「他言語製のモジュール連携」は、C->Other,Other->Cともに、労が多かった記憶があります。

それが「コメント活用も合わせこの程度で書ける」というのは、隔世の感がありました。

---

プラグインの話しは、おそらく「感心事の分離」を「どんな手段でやるか」だと思います。

その一つが「プラグイン」であり、その一つが「サーバを小さく分ける(マイクロサービス化)」なのだろうと思います。

そういう意味では「golangのAOP周りってなんかキテるやつあるのかな？」という興味がわきました。

---

golang-nuts、是非活用したいなぁ。 (英語が９点とか取る勢の戯言)


## 2コマ目「Go初めて2ヶ月くらいの初心者がソシャゲっぽいのを作ってみた(仮」

+ 登壇者 : 藤井 陽介 さん( [@syo_sa1982](https://twitter.com/syo_sa1982) )
+ 資料 : [こちら](http://syo-sa1982.github.io/KUG2/)

ご自身が「GOの初めて３ヶ月でゲームサーバを作った時の経験からの知見」を語って頂いています。

  (クライアント/スマホ)Unity実装 <--HTTP/json--> (サーバ)golang実装(lib:goji,gorm)

というかカタチのゲームシステムを想定しているそうです。

---

やはり「Cのラッパーとしてgolangはコードが簡単で記述量少なくてすむ」の話しをよく聞きますね。

あとJson議論、自分は「かつてMapに親を殺された」感あるので、自分に任せるとstructをきっちり実装するコードスタイルになると思います。

---

自分のちょっと先にいる初心者という話しですが…とても先進的かつ目標のあることをやられていて凄いなと思いました。


## 3コマ目「PHPerがgolangでもがいてる話」

+ 登壇者 : うつみ けいすけ さん( [voidofglans](https://twitter.com/voidofglans) )
+ 資料 :
<iframe src="//www.slideshare.net/slideshow/embed_code/key/lbvjhv73gS2E3P" width="425" height="355" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="//www.slideshare.net/voidofglans/phpergolang-golang" title="PHPerがgolangでもがいてる話@第１回 関西Golang勉強会" target="_blank">PHPerがgolangでもがいてる話@第１回 関西Golang勉強会</a> </strong> from <strong><a href="//www.slideshare.net/voidofglans" target="_blank">Keisuke Utsumi</a></strong> </div>


ゲーム制作に際してツールをgolangでバリバリ実装している、うつみさんからの「どのように選定されたか」「適用したか」のお話しです。

(資料中の「質問タイム」とは「登壇者から参加者へ」の質問タイムですｗ)

---

golangを「利点だけ並べたら採用確定」なのに「会社/現場がNOという」という話しは、少ないが何例か聞きます。

そういう議論を

__「新しいもの/新しい環境に当たる？じゃ"ビギナー"という点では一緒だね」__


という一点押しで突破してるのはすごくロックでかっこいいですね。


C++との比較で「開発環境の調達が簡易」という観点の「利点」を出してきてるのは、
ひょっとすると、他の比較対象(言語でも技術選定でも)にも使える「利点のアピールポイント」なのかもしれませんね。

「推すときのヒント」を頂いたきがするので、これから活用して行きたいと思います。

---

golangは「言語仕様側でいくつかの問題と宗教戦争を解決済み」っていうところ、評価されてる方が多いですね。

その反面「強烈な利点で霞むが、この考慮が手薄」というものが割とある印象で…

+ go get -> バージョン・依存性管理

などは代表的なところかと。ま、それも今後に期待できるので「悩むにゃ早い」対象かもしれませんが。

---

インターフェイス(interface)については、他のセッションの質疑の議題にも上がっていたと思うのですが、
「扱いかたにあぐねている」方が一定数居るようで…他言語を知ってる方からは頭を切り替える必要がある…のかな？

---

__goに入らばgoに従え__

は名言ですね。(ずるいけどｗ)

全体的に「GOの関西での普及を！」「勉強会推進しましょう!」という前向きな気持ちが垣間見れるセッションでした。


## 4コマ目「周回遅れのgolang」

+ 登壇者 :  [オレ](https://twitter.com/kazuhito_m)
+ 資料 : [こちら](http://kazuhito-m.github.io/presentations/2015-10-12-golang-study)

いや…ほんっとすんませんでした m(_ _)m

[い](https://twitter.com/bouzuya/status/653460765194608640) 
[ろ](https://twitter.com/White_Raven777/status/653463340602167296) 
[い](https://twitter.com/Kuchitama/status/653463822557032448)
[ろ](https://twitter.com/White_Raven777/status/653465156630917120)
と「なんでやねんｗ」をたまわりまして…反省はしております。

ただ「勉強会をぐんにゃり」させたかったんではなくですね…。

+ (低レイヤーかつシンプルがよくウリっぽくされるけど)開発環境はモダーンだよ
+ それを手に入れるのも簡単だよ
+ 言語自体もそうハードル高くないよ
+ オレでも出来るねんもんw それが証左ですねっ♪

って言いたかっただけなんすよw

~~あと「渾身のコラ」を見せたかっただけっていうか~~


## 5コマ目「Google App Engine/Goを触ってみた」

+ 登壇者 : まつもと まさひろ さん( [massan_77](https://twitter.com/massan_77) )
+ 資料 : 
<iframe src="//www.slideshare.net/slideshow/embed_code/key/4YKDSQmF3e71Uv" width="425" height="355" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="//www.slideshare.net/masahiromatsumoto589/google-app-enginego" title="Google App Engine/Goを触ってみた" target="_blank">Google App Engine/Goを触ってみた</a> </strong> from <strong><a href="//www.slideshare.net/masahiromatsumoto589" target="_blank">Masahiro Matsumoto</a></strong> </div>

golangの入門で「Google App Engine」で自分の書いたもの動かす…をやられた経緯と利点と知見を共有する、そんなLTでした。

お話ぶりを聞いているとそうは思えなかったのですが…「開始１ヶ月」「新しい言語を身に着けたかった」という、俺とちょっと近い状況なのでしょうか。

--- 

どうも最近、自身の周りで「Google App Engine」の話しをよく聞く…と同量の「困ってる」も聞くのですがｗ

+ 起動時間の遅さの解消
+ Googleという限りは親和性高そう(感じ

という理由でgolangの話しが出てくる感じがします。(本当のところはどうなのでしょうか？)

---

「goroutinは…」という話しは、

__「GAEはCPUが一個が固定されているため、動きには問題ないが『マルチCPU時の並列処理の恩恵』みたいなものは得られない」__

というのを直感的に想像したのですが、どうなのでしょうか。(読めってなｗ)


## 6コマ目「Goでモバイルアプリを作ろう！」

+ 登壇者 : nobonobo さん( [nobonobo](https://twitter.com/nobonobo) )
+ 資料 : [こちら](http://golang.rdy.jp/GoMobileStrategy.svg)

golangでモバイルアプリを作る方法を「PlanA〜C」という選択肢で紹介する、というそんなセッションでした。

それにしても…プレゼン資料クオリティが凄いなと思いました(今も思ってます）。※不勉強なのでどうやってるのか解らん

---

雑なまとめをすると…

+ PlanA : モバイル用プログラムから呼ぶモジュールをgolangで書く
	+ OS機能使えず、単一ソースクロス環境は無理
+ PlanB : golangでgomobile-APIを使うプログラムを書く
	+ OS機能は限定的、単一ソースクロス環境可能
+ PlanC + golangで書いたプログラムをGopherJSでjsに変換ハイブリッドSDKでOS機能呼び出し
	+ OS機能は限定的、ブラウザ機能がほぼすべて使える

でしょうか。

---

PlanCのGopherJSの…

__「コンパイルすると「AMDなどと並ぶ"JSというアーキテクチャ"」としてコンパイル結果にソースが出る」__

という話、聞いてると「その発想はなかったわーｗ」な匠のアイディアっぽいものを感じました。

---

最近、自分は、ビジネスアプリ畑にもかかわらず「クライアントサイド苦手克服月間」中なので「使う道具の組み合わせ選定」とか考えるわけです。

今回、GopherJSの話しを聞いて「JS吐けんなら、クライアント/サーバともにgolangで…とかできんじゃね？」という素人夢想に思いをはせました。

---

nobonoboさんは、「とにかくなんでも出来る」The エンジニアな人で「レイヤーの垣根無く」「深く広い見識」「全然知らん情報ばかりや…」と収支

# 小並感

テーマ別に書こうかなぁと。

## 登壇者の絶妙な配分

<blockquote class="twitter-tweet" lang="ja" data-conversation="none"><p lang="ja" dir="ltr">今日の <a href="https://twitter.com/hashtag/KUG2?src=hash">#KUG2</a> 、Go知らない人からそこそこ触ってる人までそれなりに聞ける話があったんじゃないかなと思う。僕は楽しかった！</p>&mdash; Yusuke Hatanaka (@Hatajoe) <a href="https://twitter.com/Hatajoe/status/653563075249868800">2015, 10月 12</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

そうなんですよ。自分が聞いてて思ったのは6人の登壇者中で…

+ ジャンルは完全には重ならないが2〜3くらい重なってる人らが居る
	+ 低レイヤー、C畑、IoT畑、環境、言語、etc...
+ 習熟度も完全には重ならないが2〜3くらい同じとこに居そう
	+ 初心者、常用者、豪の者...


という「ベン図の重なり方」がすごかったなぁと。

ま「運営が登壇した」という事情なだけで、狙っていませんし再現性も無いのですけどｗ


## プレゼンテーションツールについて

なんとなく…「プレゼンテーションツールの見本市」のような様相を呈していましたｗ

そして「公開しました」まで「皆さんほぼノータイムで」されているので「最初からそれができるような道具を選んでるのだなー」と。

最終的には「ぜんぶWebで公開する」のですが、その元が

+ デスクトッププレゼンテーションツールベースなもの
+ Web系
  + Markdownを整形系(オレ、少佐さん)
  + ソレ以外(オレが知らないだけです)

に分かれてるのだろなーと。

ここも「この勉強会の特色かな」と。

## gofmtと宗教戦争とありがたみと「ほんとに？」と

多くの方が「コードフォーマットの宗教戦争を言語仕様側で解決した」のを評価していました。

かくいう自分もそうですが、「過去、さまざまなアカンヤツに出くわし揉めた」経験からだろうと思います。

でも、参加お一方のツイート…

<blockquote class="twitter-tweet" lang="ja"  data-conversation="none"><p lang="ja" dir="ltr">今日の発表をみていると gofmt をありがたがる人が多いようなので、もっと決まった書きかたしかできないけど楽に書ける言語が求められているんじゃないかな。</p>&mdash; bouzuya (@bouzuya) <a href="https://twitter.com/bouzuya/status/653471375458340864">2015, 10月 12</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

がずっと引っかかってて「うーん、そうだよなぁ。それは正しいしなぁ…」とも思いつつ。

自分は「コード書いている時に思ってる事」が、

0. 常時は「コードのカタチはどうでもいい」から「意思の通り」を保って"よしなに"やってくれ
0. 改行,配置,カンマなど「コードのカタチに意味を持つ」から崩さんとってくれ

という２つの思いがあって、それが「デキすぎてわちゃわちゃなる」「デキなすぎてなんも表されへん」ってのに揺らされてきたのだなぁと。

そういう意味で「オフサイドルール」も自分の中では「2.を害するもの」だったりします。(もっかい言うときますが個人的に、です)

と来て、golangですが、

+ 使うかどうかは任せるが「自動コードフォーマッタ」を中核ツールとして仕込んだ
+ その「フォーマットルール」も頃合いで良い感じ

ってのが自分にささったのだろなと。

で、最初のツイートに戻ると「楽に書ける言語は求めてるけど、golangより定形だと嫌だ」が自身の見解かなと。


---

個人的には「超初心者」視点での参加でしたが、golangについての幅広い知識が拾えて満足度の高かった勉強会でした。

うわさによると[次回登壇者も控えてる](https://twitter.com/kazuhito_m/status/653558897328787456)らしいので、これからも楽しめそうだなと期待しています。


# おまけ

<blockquote class="twitter-tweet" lang="ja"  data-conversation="none"><p lang="ja" dir="ltr"><a href="https://twitter.com/hashtag/KUG?src=hash">#KUG</a> のKはカラアゲのK！ <a href="http://t.co/cUIO8YYPC1">pic.twitter.com/cUIO8YYPC1</a></p>&mdash; 三浦カズヒト(意識低い系筆頭) (@kazuhito_m) <a href="https://twitter.com/kazuhito_m/status/653497826400317441">2015, 10月 12</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

これ、「前回で流れ決まった」感あるけど…定例になるんやろか？ｗ

