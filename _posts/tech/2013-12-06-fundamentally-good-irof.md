---
layout: post
title: 「性善説いろふさん」登場！#irof_history
category: tech
tags: [irof, irof_history, Jenkins, jenkins-plugin]
---

皆様、ぐーてんたろふ！

昨日の [@megascus](https://twitter.com/megascus) さんの「[>゜) #irof_history](http://d.hatena.ne.jp/megascus/20131205)」に続きまして、
[いろふ Advent Calendar](https://atnd.org/events/44814) ６日目を担当致します [@kazuhito_m](https://twitter.com/kazuhito_m) と申します。

さて、今年のいろふアートは...

いろふさんといえば、

__「多重インスタンス持ち」「増殖可能」「青山インスタンスこそ至高…」__

というふうに、概念であり、距離も空間も時空も超えた存在…。

1960年台、アメリカで牧師をしつつ「テスト/ビルドの重要性を説く運動」をしていた…
そんな"数世代前のいろふインスタンス"は、今際の際「名演説」をし、エンジニアの胸を打ったといいます。

その言葉が今も語り継がれています。

<span style="arial, sans-serif; font-size: 22px; font-weight: bold; line-height: 38.875px;">”Test and Build" of the Irof, by the Irof, for the Irof...</span>

_(いろふの、いろふによる、いろふのためのテスト/ビルド)_

…これ…「心に訴える」というより若干「自己中な主張」な感じもする名言ですが、
コレに心打たれた不詳ミウラ、

「いろふさんを自宅に招き、いろふさん自身が『テストしたい』『ビルドしたい』と思った時に、自らテスト・ビルドを行う」

そんな「いろふさんインスタンス」を自宅に住まわせたいと思います。
（「去年と一緒じゃねーか！」って？ え、気のせいですよハハハ…）


# いろふさんを我が家(現場)のPCにお呼びしよう！

…このタイトル、結局 [去年と全く一緒](/tech/2012/12/08/irof-build) やないか…。

ということで、さくっと端折ります。

Jenkinsをインストールします。
（今回は [Debian@仮想機](http://pkg.jenkins-ci.org/debian/) です。)

そして、去年作ったIrofkinsプラグインをインストール。

うむ、安定のいろふさん画面ですね。

![はー、やっぱり落ち着きますな（うっとり](/images/2013-12-06-irofkins-sample.png)

「インスタンスのカタチは問わない」でお馴染みいろふさんです。

ここに「八尾インスタンス on Jenkins」が立ち上がったわけですね。

# ”いろふさんの意思”を尊重しよう！

さて、いろふさんは連れてきて見ました…ので！ つぎは「意思によるテスト・ビルド」をしたいと思います。

しかし、「いろふさん自身が『テストしたい』『ビルドしたい』と思った時』というのが難しい。

なぜなら、俺達は「いろふさんの心」は読めない…

というより！「人の心」なんてたとえコンピュータでも読めないでござるよ！

でも「あっ…（察し」くらいのことは出来るかも知れない！

いろふさんの意思が色濃く出るのは、「Twitter上インスタンスさん」かと思うんですね。
じゃ、ツイートを拾えば…って、これ去年誰かさんがやってたな…。

[@irof ビルドして。#irof_history](http://d.hatena.ne.jp/kiy0taka/20121215/1355568984)

そりゃもちろん天下の「ミニ四駆鬼軍曹」@kiy0taka先生のプラグイン、
そのまま使うのも、移植するのも憚れるのですが…

<blockquote class="twitter-tweet" data-lang="ja"><p lang="ja" dir="ltr"><a href="https://twitter.com/kazuhito_m">@kazuhito_m</a> あとは頼んだ！</p>&mdash; Kiyotaka Oku (@kiy0taka) <a href="https://twitter.com/kiy0taka/status/279982922998616064">2012年12月15日</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

なんと！ もう去年の年末の段階でコレを予見して、
俺に託していてくれたのですね！

さすが「ミニ四駆エスパー」、展開の読みが凄い！

ただ、「意思で」っていうのがまだ曖昧ですね。

では、まあ…てきとーに「ビルド」「テスト」「build」「test」と、
あとは運要素として「い」「ろ」「ふ」が入ったツイートが入ってたら、
ってことにでもしましょうか！

TwitterIDまで弄えてしまうと、もういろふさん関係ない感じになりますが…。

![TwitterIDまで弄えてしまうと、もういろふさん関係ない感じになりますが…](/images/2013-12-06-irofkins-setting.png)

- plugin本体 : [https://www.dropbox.com/s/np0vhzrjvgoubts/irofkins.hpi](https://www.dropbox.com/s/np0vhzrjvgoubts/irofkins.hpi)
- source : [https://github.com/kazuhito-m/irofkins](https://github.com/kazuhito-m/irofkins)

# いいわけ＆Take

えっ？

- 絵が少ないね…
- そんな「ビルドされてますよ」つっても見れなきゃわからんよ…

ですと？

へっへーんだ！ じゃあそのJenkinsを公開しちゃうもんねーｗｗ

[http://irof.orz.hm:1623/](http://irof.orz.hm:1623/)

※年内公開期限の予定です。

昔「性善説サーバ」ってあったんですけど、今回は「性善説Irofkins」です。

いろふさんも、そのまわりにも悪い人なんていないよ！…たぶん。

ビルド実行だけは、未ログイン一見さんでも可能にしております。

えっ？

- 去年とあんま変わらないね
- 結局、他人のパクってガッちゃんこしただけじゃん
- おまえ、やれんのか！そんなもんなんか！！

しゃーーらっぷ！ 予定の時間が取れなかったんじゃ…

このままで終わってやらんからな！ 見とれよー！ｗ

(つづく)

---

一日遅れましたすみません…。

明日…ちゅーか今日は [@sue445](https://twitter.com/sue445) さんの「[irofさんをJUnitで走らせてみた #irof_history](http://sue445.hatenablog.com/entry/2013/12/07/000002)」です。
