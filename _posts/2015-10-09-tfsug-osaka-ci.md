---
layout: post
title: 勉強会行ってみた「第28回 TFSUG大阪 継続的デリバリーを実現するTeam Foundation Server / Visual Studio Online 特集」#TFSUG
category: study-meeting-repo
tags: [microsoft,vso,tfs,ci]
---

CI/CDと名がつく勉強会って「みんな大好物」ですよねっ！ (そうじゃないわけがない、きっとそうに違いない)

# 情報

+ [申し込みサイト](https://tfsug.doorkeeper.jp/events/31243)
+ ハッシュタグ : [#TFSUG](https://twitter.com/search?q=%TFSUG)
+ 何するのか : 紹介文より「DevOps Hackathon Day」をうけてDevOps周りに重点を置いて、ALM MVPによるTFS/VSOの使い倒しを紹介します。」

# なんで来たん？

俺は「自動化」が好きで、それが「開発の現場に向く」なら、
それは「継続的インテグレーション(CI)」「継続的デリバリー(CD)」になるわけで…。

それに関して「自分の中での手法」ってのは調べるし考えるけれど、
「違う畑で、プロの手法」って全然知識が無いわけで…。

ということで「違う畑＝MS系」の「いまどき」を把握しに来ました。


## 1コマ目「Visual Studio OnlineとAzureで作ってみるDevOps」

+ 登壇者 : 亀川 和史 さん( [kkamegawa](https://twitter.com/kkamegawa) )
+ 資料:
<div style="width: 608px; max-width: 100%; margin-bottom:5px;"><a href="https://docs.com/kkamegawa/3092/visual-studio-onlinedevops" title="Visual Studio Onlineで学ぶDevOps" target="_blank" style="font-family: 'Segoe UI'">Visual Studio Onlineで学ぶDevOps</a><span style="font-family: 'Segoe UI Light'">—</span><a href="https://docs.com/kkamegawa" target="_blank" style="font-family: 'Segoe UI'">kkamegawa</a></div><iframe src="https://docs.com/d/embed/D25195808-1389-4335-3350-000100863436%7eMb9b006b3-e243-28ff-a71f-76fe40f71380" frameborder="0" scrolling="no" width="608px" height="378px" style="max-width:100%"></iframe>

※いつもなら「見なおしてから感想書きます」なのですが…
「遅れてきて一秒もセッション聞いていない話」
は流石に感想も失礼かと思うので…ちょっと吟味します。

## 2コマ目「ポストJenkinsとなれるのか？CIサーバとしてのVSオンライン」

+ 登壇者 : 前川 博志 さん( [Posaune](https://twitter.com/Posaune) )
+ 資料: ※捜索中

事前に、

<blockquote class="twitter-tweet" lang="ja" data-conversation="none"><p lang="ja" dir="ltr"><a href="https://twitter.com/irof">@irof</a> <a href="https://twitter.com/kazuhito_m">@kazuhito_m</a> Visual Studio スライドのラスト5枚にしか入ってない</p>&mdash; Libreぽざうね (@Posaune) <a href="https://twitter.com/Posaune/status/651713186698129408">2015, 10月 7</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

とは言ってらしたのですが…まさか本当にそうだとは(笑)

[こちらの話](http://www.slideshare.net/Posaune/jenkinsci-50411288) の延長線上の

+ もうちょい突っ込んだ
+ 前より進んだところ
+ VisualStudioOnlineにスポットを当てた

話をされておられました。

---

曲解はあるかもしれませんが、言われてたことをメモから書くと…

###「CI as a Service」の良いところ

+ 環境のCleanさと鮮度
+ リポジトリ指定のみ(環境側でなくソース側に持つ)の依存性
+ リポジトリに閉じれる設定
+ リモートとの相性

これは本当に頷ける話しで、期待しているところであります。

特に「環境のCleanさ」については「ぐうのねも出ない冪当」を提供してくれるので、
過去の人間たちの「失敗からの学び」が凝縮されてる気がします。

そういう「サンドボックス」「クリーンルーム」的な意味で、
自分は最近「ビルドにDockerを使う」という
「Drone(CIサービスとしては[Drone.io](https://drone.io/))」が気になってます。

---

超々☆私見を書きますと…

前川さんの「ポストJenkins」の潮流は、確かに今来ていると思います。

「「世の開発」の大部分のCIが、CIサービス系でカバー出来る」というのは真で、
今からの開発はそちらに流れ、徐々にJenkins人口比と逆転するのではないかと。

ただ、勉強会に行って「CIどうしてます？」質問を多く投げるに、
先進的なところでも「Jenkinsで」と言ってるところも一定数あるのです。

その理由を聞くに…

_「CIは、リモートサービス系:近所のマシン系 に 6:4 くらいの二極化」_

するのではないか？と考えて居ます。

1.リモートサービス系

+ 言語体型やエコシステムにより「比較的に定形に」扱えるもの
+ シンプリシティやポータビリティを狙って作られたアプリ

2.近所のサーバ系(Jenkins含むが限定しない)

+ ビルド手段に順序を持つ複雑系
+ ビルドの過程に他/多言語など異なったものを含むもの
+ 著しく環境を選ぶものor物理が必要なもの
+ 「ネットすら見ちゃいかん！」などという隔離環境
+ 通知(XFDなど)
※これが上記の「聞いた答えの理由」です

と「用途別に用いられていく」二極になるかなぁと。

最も「どちらか一方に限定」ということも無いので、
「CircleCIの結果をJenkinsで監視してサイレン鳴らす」
という複合もノウハウ化されてくる可能性もあると思います。

---

後半「Visual Stuio Onlineのデモと解説」がありました。

そこで言われていた、

+ ビルドエージェントという仕組み

	+ ビルドマシンを概念として切り出し
	+ デフォルトが「Windows」というAgent

というのは「何やらMSぽくない(笑)筋の良い設計だなぁ」と思いましたし、

__ポストJenkinsとして使える? -> 非常に使える。__

というのも大変説得力がありました。

# 小並感

結局「30分増量のスペシャル構成」にしていただいたようで、
遅れてきた自分には大変意義のあった勉強会でした。

それだけに「参加者が少なかった」というのは、
平日という条件もあったのでしょうけれど残念でして…。

松岡修造ばりに

__「もっと…熱くなれよ！ -> 世界」__

という"己のエゴ"を、知り合いの参加者にぶつけながら帰りました。
