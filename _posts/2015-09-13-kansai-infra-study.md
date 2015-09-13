---
layout: post
title: 勉強会行ってみた「第一回 関西ITインフラ勉強会」#kistudy
category: tech
tags: [infrastracture,study_meeting_repo]
---

![会場の様子](/images/2015-09-13-kistudy.jpg)

噂によると…仕事で「インフラ出来る人」みたいに思われてるらしくって…。

こいつはヤバイ！ヤバイから勉強会行かなくては！！

…という恐怖からの逃避行動としての勉強会参加…もアリですやん？

## 情報

+ [申し込みサイト](http://kansai-itinfra.connpass.com/event/18858/)
+ [当日まとめ(Togetter)](http://togetter.com/li/873319)
+ ハッシュタグ : [#kistudy](https://twitter.com/search?q=%23kistudy)
+ 何するのか : インフラ知識を「ジャンル限定せず」勉強する？勉強会…かと。

## なんで来たん？

_「大阪にはインフラの勉強会、無いですからね…」_

勉強会に顔を出すようになってから3年くらいでしょうか、事あることにこのセリフを聞きました。

サーバソフトとか特定プロダクトの勉強会はあっても、「インフラ」という名の勉強会は無い…。

「探しているんですよ」と言われてた、[@snowoy0113](https://twitter.com/snowoy0113) さん。

「やろうと準備してます」と言われてた、[@shige2313](https://twitter.com/shige2313) さん。

そのお二人が「主催」「登壇」で「インフラの」勉強会となれば、行くのは決まってたようなものです。

## 内容

### オープニング 「関西ITインフラ系勉強会( [#kistudy](https://twitter.com/search?q=%23kistudy) )発足について」

+ 登壇者 : Yuki Okuno ( [@snowoy0113](https://twitter.com/snowoy0113) ) さん
+ 資料: <iframe src="//www.slideshare.net/slideshow/embed_code/key/9wm0nJnFh0BaKq" width="425" height="355" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="//www.slideshare.net/yukiokuno0113/it-kistudy" title="関西ITインフラ系勉強会 (ハッシュタグ #kistudy) 発足について" target="_blank">関西ITインフラ系勉強会 (ハッシュタグ #kistudy) 発足について</a> </strong> from <strong><a href="//www.slideshare.net/yukiokuno0113" target="_blank">Yuki Okuno</a></strong> </div>

アカン…そのパロディでは、インフラエンジニアはみんなゾンビになってまう…ｗ

実際「関西のインフラ勉強熱」ってのはやり場なく焦燥してたんだと思うんです。

サーバプロダクト個別の勉強会をやればそこそこ集まりますし、その中に [@snowoy0113](https://twitter.com/snowoy0113) さんもお見かけしました。

そういう「インフラ勉強したい人々」を一同に集められる「場所」を作ったのは、素晴らしいことだと思います。感謝！

### 1コマ目「Ansible使ってさくらのクラウド上にサーバ作れるようにした<del>い</del>件」

+ 登壇者: [Koji Nakayama](https://github.com/knakayama) さん
+ 資料: [※おそらくこれが原稿](https://github.com/knakayama/LT-2015-09-13/blob/master/slide.md)

登壇者は「SAKURAの中の人」なのですね。

話された内容は

+ オンプレ→クラウド移行とかの時にデファクト厨の人はすーぐAWSとか
+ AWSの強みは「周辺ツールのエコサイクル」「勝手に便利なもの作られる」事
+ なので「Ansibleでさくらのクラウドにサーバ作れるツール」作ってみた

で、そこからAnsibleで作成されたものの具体的な説明をされました。

自身「プログラム畑」なもので「基本的に"infra as code"やろ」という考えは"根底に"あります。

インフラ本職の人もきっちり「プロビジョニングツール使って」「冪等性で」とやられてるのは
すごく参考になりましたし嬉しくなりました。

しかし…インフラの方々は見識広くそして深いですね。

あ、結論は「さくらのクラウド、使いましょう！」でした。


### ２コマ目「LinuxコンテナとLXC入門」

+ 登壇者 : 加藤泰文さん( [@ten_forward](https://twitter.com/ten_forward) )
+ 資料 : <div style="width: 65%"><script async class="speakerdeck-embed" data-id="71f0fe44770b4a1e8755469e6aaa5104" data-ratio="1.33333333333333" src="//speakerdeck.com/assets/embed.js"></script></div>

個人的には「[OSC京都で登壇されてたLXCの中の人](https://speakerdeck.com/tenforward/osc-2015-kansai-at-kyoto)」という、
まだ記憶に新しい前登壇を見ていましたので「前セッションとの差異」を中心にウォッチしていました。

今回は「LXCのコマンドレベルでの具体的なところ多め」だったのかな？

双方変わらず伝えてらっしゃったのは

+ 「コンテナ」という単一機能ではなく、コンテナ以外でも単体で存在できる機能の集合でできてる

ということ。

自身が今回、収穫としてもらったのは

+  LXCはUbuntu(Canonical社)が実質で牽引・開発してきたもの
+ コンテナに使うディストリは「ホスト側と同じもの」が無難

ということと、あと質疑応答で出てた

+ Q : LXDってなんですか？
+ A : LXCは「そのサーバ内のコンテナを弄う」コマンド群、LXDは「ネットワーク中のサーバ内のコンテナを弄う」コマンド群。

でしょうかね。

自身はコンテナとしてはDockerを手に馴染む道具として使ってるので、それとの差異や強みを聞いてみたいな、と思いました。

これまでも大阪・東京で「コンテナの勉強会」をされており、俺は「知りつつ行けない」状況ばかりだったので、今度は行きたいですね。

### 3コマ目「インフラエンジニアに必要なスキル」

+ 登壇者 : [@Anubis_369](https://twitter.com/Anubis_369) さん
+ 資料 : <iframe src="//www.slideshare.net/slideshow/embed_code/key/KEhLS4Ut3ywYjD" width="425" height="355" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="//www.slideshare.net/anubis_369/ss-52717237" title="関西インフラ勉強会 スライド" target="_blank">関西インフラ勉強会 スライド</a> </strong> from <strong><a href="//www.slideshare.net/anubis_369" target="_blank">anubis_369</a></strong> </div>

「インフラエンジニア」の意味、つまり「人間系のロールの話し」なセッションでした。

まー知り合いなこともあって[Twitterでいちゃもんつけまくった](http://togetter.com/li/873319?page=2)のですが、
反省し「何が言いたかったのか」をまとめてみると…。

+ 「現場」で「操作」と言ってるものが、コンテキストを広く取り過ぎていておしなべられない気がする
+ 「読む」「書く」が「エンジニアの基本姿勢」くらいの一般化なら良いが「手動推奨」と取られかねない
+ 「ソフト」というのが「ネイティブGUI」や「機材の」以外は「道具や仕組み」で補助すべき
+ この話しを「本職のインフラエンジニア」の見解と照らしあわせたい

と「自動化」「Infra as code」を推す者としては「逆方向の啓蒙になってたらヤダなー」という思いでした。

とはいえ「一番質問と議論が白熱した」ので、多くの人を引き込んだセッションであったことは間違いないでしょう。

### 4コマ目「イベント会場ネットワーク」

+ 登壇者 : Fumihisa Shigekane さん ( [@shige2313](https://twitter.com/shige2313) )
+ 資料 :  

「"cat myself.ldif" するとこうなります」という自己紹介すげぇｗ

主に、ご自身が所属されているNCS(Network Skills Competition)のお話で、具体的には直近カンファレンスのネットワーク設営である「CMS関西夏祭り2015」の詳細を。

「とてつもなく労力を惜しまない、勉強会・カンファレンス界のネットワーク屋台骨」っぷりが…なんというか漢過ぎて感動しました。
(他人のために善意の第三者としてネットワークを設定したことある方はわかると思うのですが)

そして、当たり前のように「この勉強会の会場のネットワーク設営」もされています。

「このアドレスで現在の"NSCが設営したこの会場"のトラフィックが見れます」と言いつつ、自作のシェル芸で出力させたサイトを紹介するのはしびれました。

上手く言えないのですが…

+ 本当に実際の「催し物会場のネットワーク設営」でしか体験出来ない、生々しい失敗やリカバリ知見がいっぱい
+ 本来なら「仕事かつ一社かつ秘伝のタレ」になるノウハウや体験談、しかも想像できる程度の頃合いの規模

というのが「とてつもなく貴重で有用な情報」に思えたので、Shigekaneさんに聞いてみたのです。

+ Q : NSCはセッション形式の勉強会ってやってないのですか？
+ A : 「学生に実地で体験して学んでいただきたい」という目的があるので、やるべきはそれじゃない

なるほど、動機が明確ですね。

### 5コマ目「ディスカッションとか突発ライトニングトーク大会とか」

0. 「tmuxの改行まわりプラグインの話し」 [Koji Nakayama](https://github.com/knakayama) さん
0. 「本日話しきれなかった話し」 [@Anubis_369](https://twitter.com/Anubis_369) さん
0. 「Mozillaの開発ドキュメントの訳し方」 [@Uemmra3](https://twitter.com/Uemmra3) さん

tmux って「ティーマックス」って言うんですね…初めて知りました。(Byobu派)

## 小並感

「インフラ」と総称した勉強会、その「インフラ"と名のつくもの"総じて」な、ジャンルを限定しないアラカルト感が、いかにも俺得でした。

自分がそうだ、というだけかもしれませんが「皆、待望の勉強会」だったのでは？と感じました。

自身の見てきた世界の中で「あの勉強会と、あの勉強会と、あの勉強会に来てたあの人が来てる！」という感じで、
いろんな「個別論のインフラの人ら」が一同に会した感じの50人超え。

その上「[今回スルーした関西の強靭インフラ技術者の登壇](https://twitter.com/sawanoboly/status/642950109110505472)」というのもまだありそうですし、
主催の方の言葉で「定期的にやっていきたい」という意欲も聞けましたし…。

これから続けてほしく、かつ発展が期待出来る勉強会に思えました。

## おまけ

![こんなお手軽パスワードじゃ危ないぜ](/images/2015-09-13-ipa-password.jpg)

会場外の廊下に「IPAの"パスワード"啓蒙ポスター」がコンプされてました…。
