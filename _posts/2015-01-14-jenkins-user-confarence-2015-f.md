---
layout: post
title: 勉強会行ってみた「Jenkinsユーザ・カンファレンス2015東京」(前編)#juc2015#jenkinsja
category: study-meeting-repo
tags: [jenkins,automation]
---

待ちに待ったこの時がやってきましたよ！

(思いのタケがありすぎるので、二部構成ですｗ)

情報
----

- [申し込みサイト](http://jenkins.connpass.com/event/8763/)
- [概要](http://build-shokunin.org/juc2015/)
- [タイムテーブル](http://build-shokunin.org/juc2015/sessions/)
- 何するのか
  - 日本のJenkins好きが集まって「ワッショイワッショイ」する祭り！
  - …ではありませんし、セッション形式＆ハンズオンのカンファレンスですが、俺の中ではそうですｗ

# なんで来たん？

勉強会に参戦するようになってすぐで、参加しのがした「第一回Jenkinsユーザカンファレンス東京」。

参加出来なかったのを髪の毛が丸坊主に成るくらい悔やんでた２年間…そりゃ参加するってもんです！

---

# 内容

## 着いた！らへんの話

行きたい行きたい言うてるくせに、電源あるとこでダラダラしてしまって…開始時間を間違えたので基調講演を少し聞き逃してしまいました。(12:40くらいかなぁ着いたの)

前回もそうでしたが、大学でやるんすね！広い！！
(法政大学様ありがとうございます。

入り口の出迎えで、ノベルティを大判ぶるまいしてました。ステッカー頂いたっ！

![ステッカー！](/images/2015-01-11-jenkis-stecker.jpg)

早く来たらTシャツとかバッジとか貰えたと聞いてはくやんでも悔やみきれませんw

## 本編紹介…の前に

- 全体まとめ: <http://togetter.com/li/765735>
- セッション別まとめ: <http://togetter.com/li/768921>

基調講演の資料中に含まれてたかどうかは曖昧(遅れていったし)のですが「申し込み時のアンケート結果」が出ているので、貼っときましょう！

<iframe src="//www.slideshare.net/slideshow/embed_code/key/yU1Q2ra1D8BCp4" width="340" height="290" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="//www.slideshare.net/ikikko/jenkins2015" title="Jenkinsユーザカンファレンス2015 前座資料" target="_blank">Jenkinsユーザカンファレンス2015 前座資料</a> </strong> from <strong><a href="//www.slideshare.net/ikikko" target="_blank">ikikko Nakamura</a></strong> </div>

勿論、聞いてる層が「興味を持ってる人」達なので贔屓目は勿論ながら、「Jenkinsは必須？」が７割近いのは個人的に嬉しいところ。

「使う上で難しい点」「良くなって欲しい点」は、「Jenkins運用時にハマりあるある」とも言えるので、Jenkins導入の時に考慮しといたほうが良いところかな、と。

## 1コマ目 基調講演 「Jenkinsプロジェクトの現状とワークフロー」

川口耕介 ([@kohsukekawa](https://twitter.com/kohsukekawa), CloudBees) さん

![風景](/images/2015-01-11-kousukekawa.jpg)

資料:

<iframe src="//www.slideshare.net/slideshow/embed_code/key/5Dmtw9u7xFmf2X" width="340" height="290" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="//www.slideshare.net/kohsuke/jenkins-user-conference-2015" title="Jenkins User Conference 東京 2015" target="_blank">Jenkins User Conference 東京 2015</a> </strong> from <strong><a href="//www.slideshare.net/kohsuke" target="_blank">Kohsuke Kawaguchi</a></strong> </div>

まとめ: <http://togetter.com/li/768907>

基調講演は勿論！我らが川口さん。

評するのもおこがましいのですが…川口さんの講演は「力いっぱいTechな開発の話」の中に「熱い〜」って言う単語が必ず入る、そういう「技術者のエモい感じ」にじみ出てて凄く好きなんです！

また「絶対にデモ見せて唸らせる」というところもたまりませんよね。

内容も「今これに力入れてます」という「これから来るであろうトレンド」のヒントを貰えるので、聞き逃せません。(201312の東京Jenkins勉強会では次の年に「実際使ってく道具」を一杯貰いましたし)

で、お話のメインとなった「[Workflow
Plugin](https://github.com/jenkinsci/workflow-plugin)」は、

- Scriptに寄せるのかPluginでがんばるんか
- Pluginの中でもPlugin積んでつなぎ方をがんばるんか、DSLで実現すんのか
- 人間系で「この人に確認してもらうねん」とかをどうすんのか

という「ビルド/リリースの長大パイプライン組んだ場合の悩みどころ」に一石を投じてくれる、良いプラグインだと思います。

「Build Pipeline Plugin(+その他Plugin盛り)」と「Build Flow
Plugin」の二択に迷う時や、これらでは扱いきれないフローが出た時の選択肢になってくれそうです。

また「Jenkinsのユーザに部長とか人間組み込める」ってのは新しい感覚な気がしました。

自分も「これから人間系と複雑系に当たってく」というところなので、直近のトレンドとして使っていきたいです。

…「チェックポイントからの復帰」っての、どうするんやろう…。(使ってみて自分の目で確かめろ！系かｗ)

他にも「[DotCi](https://github.com/groupon/DotCi)」「受け入れテスト＆ハーネス」の話など「Jenkinserには使える話題」を多く貰いました。

## 2コマ目:S505教室 「はてなにおける継続的デプロイメントの現状と Docker の導入」

信岡裕也 ([@nobuoka](https://twitter.com/nobuoka),株式会社はてな) さん

![風景](/images/2015-01-11-nobuoka.jpg)

資料:

<iframe src="//www.slideshare.net/slideshow/embed_code/key/9G2CqTVukih46E" width="340" height="290" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="//www.slideshare.net/YuNobuoka/docker-43489941" title="はてなにおける継続的デプロイメントの現状と Docker の導入" target="_blank">はてなにおける継続的デプロイメントの現状と Docker の導入</a> </strong> from <strong><a href="//www.slideshare.net/YuNobuoka" target="_blank">Yu Nobuoka</a></strong> </div>

まとめ: <http://togetter.com/li/768897>

(メモから記憶蘇らせてるので間違ってたらすみません)

[とある理由](https://twitter.com/daiksy/status/553764293666029568)により必ず選択する予定だったセッションです(超満員！)。

自分も「全道具をテスト実行する時に用意して終わったら跡形もなくなる環境」(イミュータブルインフラとか言うほど高度じゃない)をDockerで作ろうと(必要ないのにこだわってｗ)やってる身なので、高度さは30倍くらい違うものの「わかるわー」な所がありました。

(ただし、当方Java＆SVN&mvnなので、イージーモードではありますが…)

「スクリプトの構成管理」問題は、

- 標準ジョブに「svnからチェックアウト」仕込み
- 標準ジョブにスクリプトとして「svn export \*」を書く

で「実行時に最新でやる仕組み」取ってるので「はー同じかー」って見てました。

~~「そうか、こうするのか！」と思ったのは「（Webサーバと）DockerAPIを用いたPortの解決」でした。~~

~~自分は「[コンテナ起動時にコマンドで"固定のポート"に変換してる](https://github.com/kazuhito-m/dockers/blob/master/db_and_webapp/build_and_start.sh)」ので「立ち上げてから解決する」という考えをしなかったのですが、なるほどそれが正しくスマートな気がします。~~

~~その後にアドレスで環境を分けたかったらWebサーバ側で、サーバ名で分けたかったらDDNSっぽく装備を付け加えれば良いのですね。~~

~~「Dockerコンテナビルド時間かかり」問題は、よくあると思うのですが「個々パーツとライフサイクルを整理したら分割出来ないかな？」と思いました。~~

~~お話を聞いていると「Dockerイメージとコンテナは同一サイクルで作り直し」を目指されている感じがしたのですが、それでは「立ち上げるのは一瞬」というDockerの利点が失われる気がしました。~~

|性質＼Docker物|イメージ|コンテナ|
|--------------|--------|--------|
|含むモノ|ディストリやミドルなどの”土台”系~|自分たちが作ってるアプリケーション|
|変化するタイミング|おおよそ日単位|秒単位|
|作成タイミング|日の固定時間（+スポットで任意）|commit or pushタイミング（Jenkinsおまかせ）|

~~とか出来れば、良いのかな…とか思ったのですが、おそらく「間違ってる」ので、素人の考えと思ってご容赦を…ｗ~~

(懇親会でわかったのですが「ただ自分(三浦)がDockerの勉強が足らんだけ」で「間違った苦労の仕方している」が多くあるようで…)

で、公開された資料を改て読み返すと、案の定「全面的に間違ってた」のですが…自戒として残しておきます。

---

なんとなく

「本番/ステージング"以外の"『リアルタイム(あるいは数日前とかタイミング限定)ソースが反映されて実際に動く』サーバ環境」

というのは、ヌーラボの事例でもありましたが「絶対に必要」と考えていまして、例えば…

- (集合体作るモノ(Javaならwarなど)に)実際バイナリが作れるか
- (ローカル端末とサーバが異なる場合)OS違い/ミドル違い/設定の違い、による挙動差異は無いか
- 「今作りかけはこんな状態です」を他者に見せる場合の「誰の端末でもない」環境

というのを「ステージングリリース時にどんがらがっしゃんギャー！」やってる場合じゃないので…。

なので、ここんところ色々聞いてみたく思いました。

くっそー、はてな内を見学して実物見たいぜっ！(アカンヤツ)

## 2コマ目:S406教室 「JenkinsとSeleniumの活用事例：試験自動化のプロジェクトへの導入」

近藤 剛(NTTコミュニケーションズ) さん

- 資料: (公開されたら)
- [まとめ](http://togetter.com/li/768883)

※参加出来なかったセッションです。感想できません…が資料公開されれば何か何か書き足します。

---

# 所感

「スタッフさんめっさ働いてた！」のが印象に残っています。

フロントの [@ikkiko](https://twitter.com/ikikko)
さんや、「(大阪から)手伝いにねｗ」って仰ってた玉川竜司([@tamagawa\_ryuji](https://twitter.com/tamagawa_ryuji))さん、あとブートキャンプで張り付きっぱなしだった玉川紘子さん、その他「青Jenkinsシャツ」の皆様…「この人らの頑張りで俺ら祭り参加できんねんなー」ということ思うと「有難うございますm(\_
\_)m」の言葉しか出ませんね。感謝です♪

---

以上、2コマ目までです…が、コレ終わらんかもなぁ？(三部構成になるかもです)
