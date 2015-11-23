---
layout: post
title: 勉強会行ってみた「第02回 関西ITインフラ勉強会」#kistudy
category: study-meeting-repo
tags: [infrastracture]
---

![会場の様子](/images/2015-11-24-art.jpg)

こういう「インフラ」なんていう
「ワード自体ビッグワードだが、その中は広い」というものに
「立場違いの人の話を多く聞ける」という勉強会、ありそでなかったなぁ。

# 情報

+ [申し込みサイト](http://kansai-itinfra.connpass.com/event/21416/)
+ [当日まとめ(Togetter)](http://togetter.com/li/903959)
+ ハッシュタグ : [#kistudy](https://twitter.com/search?q=%23kistudy)
+ 何するのか : インフラ知識を「ジャンル限定せず」勉強する？勉強会…の二回目かと。

# なんで来たん？

間違いなく「意図せず」なのですが…俺、「インフラの人」になったみたいで…。

「こうしちゃおれん！ 付け焼き刃だ！ 勉強会だ！！」ってことで、インフラ系勉強会に来た次第…
なのですが、ついていけるかなぁ。

# 内容

## オープニング

+ 登壇者 : Yuki Okuno ( [@snowoy0113](https://twitter.com/snowoy0113) ) さん

※今回は(前回のように)ネタはないです…とのこと。

## 1コマ目「セキュリティ系？インフラエンジニア」

+ 登壇者 : Fumihisa Shigekane さん ( [shige2313](https://github.com/shige2313) )
+ 資料:

「また、寝てないエンジニアが生まれたのか…」

毎度おなじみ「関西の勉強会・カンファレンスで活躍のネットワーク構築集団」NSCの長、ふみはらさんのセッションです。

### 内容

「インフラエンジニアもセキュリティ系コンテストにチャレンジにできるんでは？」という内容のセッションです。

内容のメモを取ってたのですが、以下な感じ。

+ 「ネットワークが"飛ぶ"のがたのしみｗ」って言うてるｗ
+ セキュリティっておいしいの？ → クックパッドが出てくる
+ 最近のセキュリティ系協議会
  1. SECCON
  0. Hardening Project
    + 脆弱性のあるサイトが構築してあるのでそれに対応する
  0. CTF
+ CTF - Capture The Flag
  + 「フラグ」という「何らかの答え」を探す
    + バイナリ系
    + フォレンジック系
    + WEb系
  + インフラエンジニアの出番は？ → ネットワーク系問題
    + pcapを解析する問題
    + 問題の内容「ftp ...」
      + Responseパケットしかない
      + Requiestが無い…
      + FTP読もう
        + ログイン、ls、flag.tar...
      + ftpでの実バイナリはftp-dataプロトコルで送る
      + 分割されてるけど
        + Wiresharkでくっつける
      + Tarの中にflagありそう → 展開
      + tarの中にtar
      + 後ろに== → Base64だろう → デコード
  + 必要な知識
    + プロトコル(ftp)
    + Wireshark
    + base64

### 会場に対する「宿題」

上記の通り「CTF」の例題を一つ説明したうえで、
会場の皆さんに出題がありました。

__[このファイル](http://www.nsc.gr.jp/kistudy2/162-basic.pcap)を元に「フラグ」を解明せよ！__

「このセッションは二部制、あとで回答編ね！」ということで、
会場が「wiresharkのインストール」からスタートする人続出でした


## ２コマ目「Network Namespace について」

+ 登壇者 : 加藤泰文さん( [@ten_forward](https://twitter.com/ten_forward) )
+ 資料 : <script async class="speakerdeck-embed" data-id="5946c8cfc0244079ba82d58f4ad6aec8" data-ratio="1.33333333333333" src="//speakerdeck.com/assets/embed.js"></script>

「豆知識のようなセッションなんですけど…」とかいう導入ですが…そんなことはないセッションです。

### 内容

加藤さんというと「コンテナの人」「LXCの人」なのですが、
今回は「コンテナの要素技術」である「Network Namespace」
のセッションです。

とったメモを共有しときます。

+ Linuxコンテナ実現のための機能
  + プロセスをグループ化して他のグループと隔離
    + OSリソース隔離 → Namespace
+ Namespace
  + リソースごとにネームスペースを別にできる
  + Mount,UTS,PID,User,Network
  + Userだけ毛色が違う
    + ホストとコンテナ上のユーザをマッピングできる機能
  + 今日の対象は「Network Namespace」
+ Network Namespace
  + 他と独立したネットワークを作れる
  + 作りかた
  + 何に役に立つ？
    + コンテナの仕組み理解
    + 単一ホスト上で気軽に複数のアドレスからのテスト
    + ネットワークが不要なコマンドを安全に実行する
      + おそらく「Mocking」の類だと思う
  + コンテナで使うネットワーク機能「veth」
    + OpenVZ/Vituozzo 由来の機能
    + 対になるインターフェイスを作成し、インターフェイス間で通信を行う
    + デモ

---

ネットワーク苦手なのですが、
"veth"の話とかは「Docker好きなら避けて通れない」ので、
暇があったらおさらいしていきたいなと思います。

(コンテナ情報交換回、関西の番早くこないかなぁ)

## 3コマ目「イマドキなWebサーバー「Hiawatha」の紹介」

+ 登壇者 : 四方八方 さん ( [@4for8pow](https://twitter.com/4for8pow) )
+ 資料 : <script async class="speakerdeck-embed" data-id="ef7d4c1eeed64b89a743540a43855a0c" data-ratio="1.33333333333333" src="//speakerdeck.com/assets/embed.js"></script>

資料見たら解かるのですが…「ドン引き」か「突き刺さる」か、
みたいなヤーツなのですがけど…
「俺に突き刺さった」「ロックでキャッチーな」気に入ったセッションでしたｗ

---

セキュリティの高い…のかもしれない「Hiawatha(ハイワサ)」のお話でした。

なんとなく…

+ 大事なこと
+ そんだけ割り切ったらそりゃできるわなｗ

が入り混じった面白い話でした。

---

### セキュリティのアプローチについて

この話、概念として

1. 「ハナから開かない」アプローチ
0. 「後から閉じる」アプローチ

であれば前者。

また、違う観点として、

1. 下位互換のための機能は脆弱性は設定で閉じる
0. 下位互換をぶっち切るから古い機能での脆弱性を滅殺

は後者、という感じがしました。

---

### Webアプリのセキュリティは「ソフトウェアエンジニアの仕事」だから？

その答として…

+ 否、インフラからもアプローチできるもの
+ インフラ部分での防御も組み合わせるべき

という「資料の論(俺の解釈)」に関しては大賛成で、持論としては

+ そもそも分けるようなものではない
+ DevOpsの重要性

なのですが、
「DevOps」がなんかバズってしまってるからなぁ…
という「現場のスタンダードにならない残念感」を感じています。

## 4コマ目「VMware的インフラ仮想化の世界」

+ 登壇者 : 萩原 隆博 さん ( [@shadowhat](https://twitter.com/shadowhat) )
+ 資料 : 捜索中  

語り口が素晴らしい、VMWare社の方である萩原さんのセッションです。

### 内容

メモを取りましたものを、置いておきます。

(資料が見つかれば淘汰)

+ VMwareの考える仮想化「SDDC」
  + Software Defined Data Center
    + データセンターのすべてをソフトウェアへ
  + One Cloud, Any Application, Any Device
    + 一つのクラウドで、すべてのアプリケーションと、すべてのデータにアクセス
+ VMwareの仮想化カテゴリ
  + サーバ仮想化 - ｖSphere/ｖCloudシリーズ
  + クライアント仮想化 - Horizonシリーズ/AirWatch
  + アプリケーソション仮想化 - ThinApp,AppVolumes
  + ネットワーク仮想化 - NSXシリーズ
  + ストレージ仮想化 - VSAN
  + 仮想化の管理 - vRealizeシリーズ
+ 各カテゴリをOn/Off(早かった)
+ VMwareのパブリッククラウド
  + ｖCloud Air
    + ただのvSphia基盤提供
  + AWSと何が違うのか
    + 固定料金で「枠内自由」という「非従量課金」
    + 月額でハードを押さえることができる
    + トラフィックの課金が無い
      + マネタイズの仕組みを作るのがしんどいｗ
    + 「リメイク」ではなく「リプレイス(Move)」でカタがつく！
    + 管理アプリから見るのなら「クラウドとオンプレ」を意識しない
    + ネットワーク設計の自由
      + オンプレと同じ感覚のネットワークが作れる
      + ある程度複雑性を持ったもの
    + BIOS/Bluescrean(コアダンプ)が見える
+ HorizonViewの特徴
  + Blastプロトコルのブラウザ操作
  + vShield/NSX利用でAgentレスなウィルススキャン
  + 「LinuxUbuntu仮想デスクトップ」の提供
+ ThinApp(シンアップ)とは
  + アプリケーションの仮想化
+ AppVolumesとは
  + エピソード：Windows7上でWindows3.1のアプリが動く
  + デモ
  + 「アプリケーションをカプセル化したもの」を管理する
  + 「仮想マシン(VMDK/VHDも)」で「アプリケーションを配信する」という考え方
+ NSXとは
  + Niciraを買収して手に入れた機能
  + マイクロセグメンテーションとは
    + PCごとにFW置くとコストバッキバキ
    + NSX for vShpirｔで一律FW同様のものをかける
    + 当たり前ながら「トンネリング」には弱い
+ vROps
  + 管理ツールの違い
    + 「普段の振る舞い」を解析し「異常検知」と「アドバイスしてくれる」仕組み
+ Dockerとの連携
  + PHOTHON

いろいろ琴線に触れまくったので、感想書きます。

### 「VMwareの仮想化カテゴリ」の図

これに「自力では辿りつけなかったが、この勉強会で見つけた」ことに、感謝しています。

俺は「理解しやすい」「用途別に体系が解かる」というのは、凄い重要なことだと思っています。

これを手に入れたから「さらなる深堀が出来る」ようになった気がして…持って帰ります。

### NSXについて

無論、上のカテゴリ図を知らなかったので、NSXもここで知ったのですが…

__「(VDI前提となるが)仮想化するとFW(セキュリティ対策)すら外だしできて管理できる」__

というアプローチのようで「ほー、そりゃすげーなー」と思いました。

### vROpsについて

実際、インフラ一年生の俺が現場で「問題意識はあるものの後手後手になり実現されない事」として見聞きすることに、

+ 有効活用出来てないリソース(サーバでも可)の成績取りと改廃
+ 運用経験からの「いつもと違うけど…これええのん？」解析やルール引き

がありました。

出来てない背景としては「最初に考え難い」「人間の経験に依存して体系化しづらい」などあり、
それは結局「やらなければならなくなった時のコスト」に跳ね返ります。

それを「ドンピシャで解決してくれる」のがvROpsっぽく聞こえました。

さらに「物体買い切り」でなく、「日々、有用性を測って止めたい」クラウド系にこそ、
必要なソリューションじゃないか？と直感したのですが…。

### 俺とVDIとv2p/p2vとVMwareと過去の夢

俺は、「VMwareワークステーション」が出た時に真っ先に飛びついてためしましたし、
「vSphere ESXi」も実務で使ったもんで、この潮流が来た際に、

+ p2v/v2pによる物理⇔仮想を行き来するマイグレーション
+ VDIによる「開発環境の」仮想化管理

が「世界の常識になる未来」を夢見てた人で…
その潮流が「あまり流行った感じがしなかった(自身が仕事で需要が無かった事が根拠)」ので、
しばらくVMware系から離れてた時代があっての今なのですが…。

※それは[以前の記事](http://kazuhito-m.github.io/study-meeting-repo/2015/10/26/nawa-tech-3/)でも書きました

このセッションを聞いて「浦島太郎で戻ってきて」も、

+ 正当進化してる
+ なんならCloudを巻き込んで進化している
  + HorizonViewの話しのラインナップにUbuntuクライアントがあったりね

というのを見て

「これ…何でもかんでもA○S言うてんと、適材適所でVMware系プロダクトが活きるとこもあるよなぁ」

と自身の「いつかの提案材料」として活かしたく思いました。

(なお、この記事の説明は [@p52_rocca](https://twitter.com/p52_rocca) さんに教えてもらいました。ありがとうございます。)

## 5コマ目「マニアックツール紹介、マネジメントのKnife-Zero(Chef)とテストスイートInSpec」

+ 登壇者 : Yukihiko Sawanobor さん ( [@sawanoboly](https://twitter.com/sawanoboly) )
+ 資料 :  <iframe src="//www.slideshare.net/slideshow/embed_code/key/ioBNX4BwvAXb0M" width="595" height="485" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="//www.slideshare.net/YukihikoSawanobori/knifezerochefinspec" title="マニアックツール紹介、マネジメントのKnife-Zero(Chef)とテストスイートInSpec" target="_blank">マニアックツール紹介、マネジメントのKnife-Zero(Chef)とテストスイートInSpec</a> </strong> from <strong><a href="//www.slideshare.net/YukihikoSawanobori" target="_blank">Yukihiko SAWANOBORI</a></strong> </div>

自身にとっての「インフラエンジニアの理想像」、[@sawanoboly](https://twitter.com/sawanoboly)さんのセッションです。

### Knife-Zeroについて

Knife-Zeroは「世界のプロダクト」ながら [@sawanoboly](https://twitter.com/sawanoboly) さんの作品です。

自身はこのプロダクトを勘違いしていて

+ SSHで(プロビジョニングする)相手にインストールせず(ChefClientは要るけど)に実行するもの

という特性が解って無かったので、現在「簡易性」の一点でAnsible/Fabricを検討している俺は、
俄然選択肢に入ってくるなーと(多分)早合点していますｗ

### 新しめのテストスイート「InSpec」について

+ 基本ServerSpecと似てる
+ 監査向けの強化
+ Specにスコアをつけて影響度を合算、のような結果を出せる

という特徴を持つ、新しい「テストスイート」InSpec。

「仕事で『プロビジョニングして作った環境ができてるか』テストが要る」という必要性がある自分は、質問してみました。

```
自身は「プロビジョニング系のテストツール」の習得を「今から始める」人なのですが、
その場合はInSpecのほうが良いですか？
```

その場の質問、また終わってからも丁寧にお答え頂いたきました。

+ 基本的に用途による
+ InSpecはServerspecの領域を侵さないように気を使っている

ということから、自分的には「やりたいことから考えればServerspecか…」と結論を落としかけたのですが、
その質問時も終わってからも、最後の一言は…

「どちらとも触ってみてから、考えたらよいと思います」

はい、ごもっともですw

## 6コマ目「Cent7@zabbix2.4を試す」

+ 登壇者 : 白石 雅義 さん ( [@m_46 ](https://twitter.com/m_46 ) )
+ 資料 : <iframe src="//www.slideshare.net/slideshow/embed_code/key/sKhZT30bKivoTh" width="595" height="485" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="//www.slideshare.net/masayoshishiraishi/cent7zabbix24" title="Cent7@zabbix2.4を試す" target="_blank">Cent7@zabbix2.4を試す</a> </strong> from <strong><a href="//www.slideshare.net/masayoshishiraishi" target="_blank">Masayoshi Shiraishi</a></strong> </div>

「インストールと基本的な構成」についてのセッションです。

ここのセッションで得て「絶対忘れないでおこう」と思ったのは…

「ZabbixのCentOS(RH系ディストリ)へのインストール時は、絶対この資料を思い出そう」

ということです。 (それくらいまとめ具合がありがたい)

---

「クラウドサーバ管理者若葉の会」って気になるなぁ…。

## 7コマ目？「セキュリティ系？インフラエンジニア - 答え合わせ」

1コマ目の宿題の答え合わせです。

走り書きしたメモを列挙しておきますと…

+ 騙しているパケットがある
  + BASIC認証を通ってるのがわかる
  + IDとパスワードがある…はず
+ 直前のRequestパケットを見る
  + 暗号化が解ける機能がWiresharkにある
+ 暗号化説いたのに…ユーザとパスワードにならない！なんか変！
  + Wiresharkの表示の特性も利用してフェイントかけてる
    + ユーザ名とパスワード名の区切り文字は":"
    + ユーザ名 ":" パスワード → http ":" //〜

結局、俺は挑戦しなかったのですが…多分わかりませんでしたｗ

## 懇親会

会場をそのままに、ケータリングを駆使してのビアバッシュっぽい懇親会が行われ、参加してきました。

終わり際に「 [@Anubis_369] (https://twitter.com/Anubis_369) 氏が 即席LTしてた」ので、
それについて [@sawanoboly](https://twitter.com/sawanoboly) さんにたしなめられながら、
ヤカラな質問かましてたのですが…。

ま、資料出てきたらまた書きますわ。

# 小並感

[一回目の記事](http://kazuhito-m.github.io/study-meeting-repo/2015/09/13/kansai-infra-study/)にも書いたのですが、
この勉強会には「関西で別のコミニュティやプロダクト界隈の人が"インフラ"という名で集まってる」という、いわばオールスター感があります。

俺にとっては「壇上で見た/ブースで見かけた人らが一同に会している」わけです。

どこの話しを聞いても興味あって楽しいのですよ。

---

毎回ながらNSCの皆様、ネットワーク設営ありがとうございました。

(最後のカーテンコールみたいなご挨拶、メンバーの顔が見れて、すごく良かったです。)
