---
layout: post
title: 勉強会行ってみた「第8回大阪Jenkins勉強会」#jenkinsstudy
category: study-meeting-repo
tags: [java,jjug,confarence]
---

参加だけでなく、登壇もしてきましたよ。

# 情報

+ 開催日: 2016/12/10(土)
+ [申し込みサイト](https://connpass.com/event/44408/)
+ ハッシュタグ : [#jenkinsstudy](https://twitter.com/search?q=%23jenkinsstudy)
+ 何するのか : 大阪のJenkins好きが集まってあーだこーだ言う勉強会…なのかな？ｗ

# なんで来たん？

は？Jenkinsデスヨ？行かない理由があるのです？

# 内容

自身が見たやつのみ、一行まとめのあと感想書いていきます。


## 1コマ目「なが～いお付き合いJenkinsおじさん - 僕と会社と Jenkins」

+ 登壇者 : [@srz_zumix](https://twitter.com/cero_t) さん
+ 資料 : [http://srz-zumix.github.io/slide/jenkinsstudy-o8/#/](http://srz-zumix.github.io/slide/jenkinsstudy-o8/#/)

QAエンジニアとして、Hudson時代から「会社で使ってきた」Jenkins、その後「個人的にも使うようになった」Jenkins。

CIしてきて、Jenkinsの使用方法の移り変わり、CIサービスへの移行、組織での使いかた取り組み方などなど「現在までの知見」を凝縮したセッションでした。

---

参加者の興味は「(凄く良く出来ている資料の)CIサービスの網羅表とその知見」のようで、そこに興味があつまり、質問もソコなようでした。

自分の仕事では「超絶閉鎖空間を相手にする」ことが多いので、CIサービスは「使えたらいいけど基本使えない（使ったら殺される）から余り勉強に力が入らない」のですが、 [SnapCI](https://snap-ci.com/) は久しぶりに凄く興味が湧きました。

「Groovyを使うとなんでもデキル」の言葉が気になって質問してみたのですが…「プラグインで気に入らないとこあったから、Groovyで内蔵引きずり出して好きなようにコール」みたいなことでした。みんなそういうのやってんですねー。

## 2コマ目「JenkinsとDockerって何が良いの？ 〜言うてる俺もわからんわ〜」

+ 登壇者 : 三浦 一仁 ( [@kazuhito_m](https://twitter.com/kazuhito_m) )
+ 資料 :

<iframe src="//www.slideshare.net/slideshow/embed_code/key/oxTCsShB3Y2unv" width="340" height="290" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="//www.slideshare.net/miurakazuhito/jenkinsdocker" title="JenkinsとDockerって何が良いの？ 〜言うてるオレもわからんわ〜 #jenkinsstudy">JenkinsとDockerって何が良いの？ 〜言うてるオレもわからんわ〜 #jenkinsstudy</a> </strong> from <strong><a href="//www.slideshare.net/miurakazuhito">Miura Kazuhito</a></strong> </div>

（自分でまとめるのも変なはなしですが）「JenkinsとDocker」という組み合わせについてググった＆それっぽいの作ってみた結果発表。

---

ちゃんと言い訳しときたい。ええしときたいｗ

今回、やんごとなき理由にて、主催者の方から「You,やっちゃいなYO！」での登壇でした。（そうでないとDockerとかもっと詳しい人だらけの中でしゃべらないすよ警察恐いしｗ）

で、調べものが思いの外時間がかかり…まーた資料作成とかの時間足りなくなり、結局資料/デモともに未完成ですよええ。（正直「こんなん失礼やろ」「発表…”ごめんなさい”しようかな」と迷ったくらい）

これで「なんか高度なことやってる」ならまだマシ…なのですが「誰でも出来ること」なんですよね、これ。(考え方によっては「今からやる人にはとても共感出来た」とも言えますが、それも資料のクオリティのせいで帳消しとｗ)

でも、「聞かせたかった人からのフィードバック」「ギークの人の興味を(内容のたった一部ですが)引いた」という、”二人”にはリフレクトしたので、申し訳なくも「やって良かったかな」と。

また、「資料は更新」「その中のでの発見はブログ」と、ちょっとちょっとやってきますので、勘弁してくださいまし♪


## 3コマ目 「組み込みソフト開発（カーナビ）とJenkinsの活用について、あとAGLについて」

+ 登壇者 : 日下部雄一 with 後輩の方
+ 資料 : ※おそらく世にでません

仕事で取り組んでおられる[Automotive Grade Linux(AGL)](https://www.automotivelinux.org/)でやってることと、基盤＆プログラムの成績取りにJenkinsを使っている話、またそのデモ(後輩の方による)をご披露いただきました。

---

どこまで書いて良いのだろう…まいっかｗ

なんというか…「見たことのないJenkinsの画面（でも黒帯Jenkinsなので古いからとかではない)」を見ました。

「オレが勉強足らないだけで、知っている人はこんな画面になるのを知ってるのかも？」と思ってたのですが、質問と答えから「(自分たちでメンテしてる)プラグインを盛るとそんな感じになる」ようで。

※全部自社製なのか、「業界や所属団体が標準で出してる何か」なのか、はたまたOSSなのか、それらの組み合わせかはわかりませんでした。

(オレの理解と記憶が信頼できるなら)どうやら、Jenkinsの使い方としては「基盤と”自身たちがOSSに当てたパッチ”のパフォーマンス計測と致命的な破壊の検出に使っている」ようでした。

終わった後、個別に話す機会（後述）があったのですが「私達は多くの皆さんが出会うような"CI/CDのためのJenkins"として出会っていません。そこもやっていきたい。」とおっしゃっていて「そこ！そこっすよなんならオレがやりたいｗ」とか思いました。

「ドイツ人は仕様書書くのが好き」というの、わからんけどなんとなく「そうかもなぁ」と思いましたｗ

## LT大会

募集枠3つ、飛び入りで1つのクオリティ高いヤーツでした。（内容のまとめは短いので要らないですね）

### Jenkinsでやってみてよかったこと・やめておいたほうが良かったこと

+ 登壇者 : くんすと ( [@kunst1080](https://twitter.com/kunst1080) ) さん
+ 資料 :

<iframe src="http://www.slideshare.net/slideshow/embed_code/key/nX6BdRQLh87ME9" width="340" height="290" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="http://www.slideshare.net/kunst1080/8jenkinslt-jenkins" title="第8回大阪jenkins勉強会LT Jenkinsでやってみてよかったこと・やめておいたほうが良かったこと">第8回大阪jenkins勉強会LT Jenkinsでやってみてよかったこと・やめておいたほうが良かったこと</a> </strong> from <strong><a  href="http://www.slideshare.net/kunst1080">kunst1080</a></strong> </div>

「スキーマ比較」以外はやったことあったので「みんなやるねんなぁ」という感じがしました。

「DBデータの世代管理 & 流し込み & サーバ選択発射」システムは「Jenkinsで作る」のが一番「安くてウマイ」気がしますね。
(もっというと中身はスクリプト化しといて引数で制御、あと「今生きてるDBサーバを何らかの手段で取って」コンボとかに出して…この辺にしとこか)

「スキーマ比較」はやってみたいですね…良いアイデアをいただきました♪

### 現場でJenkinsサーバのプロビジョニングをAnasibleでAsCodeした話（題名は失念しましたすみません）

+ 登壇者 : おぎあり ( [@kunst1080](https://twitter.com/kunst1080) ) さん
+ 資料 :

（若干他人事でもないのですが）Jenkinsのプロビジョンを「ソレすら自動化するよね」という話です。

JenkinsのAsCodeは「サーバのセットアップ・インストール」以降に

- (2.0以降は)アクチベーション的なやつ突破
- システム設定
- プラグインインストール
- (場合によっては)アカウント設定
- ジョブ設定（2.0になっても「ジョブ自体を作るトコ」は残る)

が「敵」「自動化しにくいところ」なのですが「[プラグインインストールをシェルスクリプトにした](https://github.com/exemplary-buildpipeline-projects/studyosaka8-jenkins-docker-env/blob/master/src/server/jenkins-aws/scripts/setup_jenkins.sh)」り、「XML自体をバックアップして流し込んだ」り、「$JENKINS_HOME丸コピした」り、いろいろするのですが、柔軟性や「〜ごと設定をどうするか(個別な依存性)」など悩ましいですね。

今まだ「これが定番や！」に達してないのですが、誰かおしえてください。

…「アクチベーション的なヤーツ」を突破する方法考えよっとｗ

### 巨大不明ビルドと戦う

+ 登壇者 : 奥 清隆 ( [@kiy0taka](https://twitter.com/kiy0taka) ) さん
+ 資料 : ※これも出ない気がします

「ビルド中に音を流す」を「Websocketなどハイレベルな方法」で実現しつつ「シン・ゴジラネタでまとめる」という…なんともハイクオリティなLTを見ました。毎回すげーなkiy0takaさん。

オレも「[ビルド中ではなくビルド後（つまり結果）をXFDと音楽と音声合成で](http://www.slideshare.net/miurakazuhito/yukamu02-jenkins)」とかやってたのですが、なんとなく「楽しい」上「(リモートでなくば)必須だなあ」と思うので、この流れもっと流行れ！

### iOS（iPhoneアプリ）ビルドと戦った話(こちらも題名失念しましたすません)

+ 登壇者 : 前川 博志 ( [@Posaune](https://twitter.com/Posaune) ) さん
+ 資料 :

iOSのビルドと長くつきあってきて「いろいろ手段は得た」「が、”金で殴る”のが一番早いわ」にたどり着いた話…というのは少し語弊がありますが。

自分も仕事のため勉強する必要が在るのですが、(取り組むのは少し先なのもあって)「クロスコンパイルやLinuxでなんとか出来ないか」ばーっかり探して「絶望」というループを繰り返しているので、レベルは違えども共感がありました。

---

# 小並感

最近は「Jenkinsはもうええんちゃう？」「CIサービスと選択肢の1つとしてJenkinsかな」「メインの話にJenkinsが出てこない」などのセッションが増えてきました。

でも「それも自然な流れかな」と思っていて、(自分も探していますが)「CI/CD勉強会が無い」ということから、「その話したい」「その話聞きたい」人らが、唯一の「ソレ系でプロダクト名が売れてる」Jenkins勉強会に集まってくるのかなと。

そういう意味でも「カタチにとらわれず広い話を扱う場」となれば良いな、と期待は広がります。

…「純然たるJenkinsファン」としては少しさびしくもありますがｗ


# おまけ

終わった後、主催、スタッフ、登壇者の皆さんとお食事に行きました。

そこで、

1. 日下部さんが「ToBe」「AsIs」を語る
0. [@Posaune](https://twitter.com/Posaune)さんが「ギーク的に」分析する
0. [@kiy0taka](https://twitter.com/kiy0taka)さんが「シン・ゴジラのセリフ」でうまいこと言う

という「新型コント&大喜利」をみてゲラゲラしました。

…これこそ、発表してエンタメにできんやろかなーｗ

皆様、ありがとうございました。
