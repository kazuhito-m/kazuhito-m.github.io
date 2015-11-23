---
published: false
layout: post
title: 勉強会行ってみた「第02回 関西ITインフラ勉強会」#kistudy
category: study-meeting-repo
tags: [infrastracture]
---

![会場の様子](/images/2015-09-13-kistudy.jpg)

こういう「インフラ」なんていう
「ワード自体ビッグワードだが、その中は広い」というものに
「立場違いの人の話を多く聞ける」という勉強会、ありそでなかったなぁ。

# 情報

+ [申し込みサイト](http://kansai-itinfra.connpass.com/event/21416/)
+ [当日まとめ(Togetter)]()
+ ハッシュタグ : [#kistudy](https://twitter.com/search?q=%23kistudy)
+ 何するのか : インフラ知識を「ジャンル限定せず」勉強する？勉強会…かと。

# なんで来たん？

間違いなく「意図せず」なのですが…俺、「インフラの人」になったみたいで…。

「こうしちゃおれん！ 付け焼き刃だ！ 勉強会だ！！」ってことで、インフラ系勉強会に来た次第…なのですが、ついていけるかなぁ。

# 内容

## オープニング

+ 登壇者 : Yuki Okuno ( [@snowoy0113](https://twitter.com/snowoy0113) ) さん


## 1コマ目「セキュリティ系？インフラエンジニア」

+ 登壇者 : Fumihisa Shigekane さん ( [shige2313](https://github.com/shige2313) )
+ 資料:

「また、寝てないエンジニアが生まれたのか…」

+ 「飛ぶのがたのしみｗ」って言うてるｗ
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
  + やってみよう
    + http://www.nsc.gr.jp/kistudy2/162-basic.pcap

## ２コマ目「Network Namespace について」

+ 登壇者 : 加藤泰文さん( [@ten_forward](https://twitter.com/ten_forward) )
+ 資料 :

「豆知識のようなセッションなんですけど…」とかいう導入ですが…そんなことはないセッションです。

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

ネットワーク苦手なのですが、
"veth"の話とかは「Docker好きなら避けて通れない」ので、
暇があったらおさらいしていきたいなと思います。

(コンテナ情報交換回、関西の番早くこないかなぁ)


## 3コマ目「イマドキなWebサーバー「Hiawatha」の紹介」

+ 登壇者 : 四方八方 さん ( [@4for8pow](https://twitter.com/4for8pow) )
+ 資料 :  

セキュリティの高い…のかもしれない「Hiawatha(ハイワサ)」のお話でした。

なんとなく「大事なこと」と
「そんだけ割り切ったらそりゃできるわなｗ」が入り混じった面白い話でした。

普通なら敬遠されたり否定する人が湧きそうですが…
俺は「ロックでキャッチーな」大好きなセッションでしたｗ

「非対応だからセキュリティ強い」という話。

まあ、そうなんですが…

+ Webアプリのセキュリティは「ソフトウェアエンジニアの仕事」だから
  + 否、インフラからもアプローチできるもの
  + DevOPSの重要性・

## 4コマ目「VMware的インフラ仮想化の世界」

+ 登壇者 : 萩原 隆博 さん ( [@shadowhat](https://twitter.com/shadowhat) )
+ 資料 :  

語り口が素晴らしい、VMWare社の方である萩原さんのセッションです。

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
  + ｖShield/NSX利用でAgentレスなウィルス
  + 「LinuxUbuntu仮想デスクトップ」の提供
+ ThinApp(シンアップ)とは
  + アプリケーションの仮想化
+ AppVolumesとは
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


エピソード：Windows7上でWindows3.1が動く。

NSXについては

「VDIするとFW(セキュリティ対策)すら外だしできて管理できる」

という捉え方したのだけど、合ってるのかな？

## 5コマ目「マニアックツール紹介、マネジメントのKnife-Zero(Chef)とテストスイートInSpec」

+ 登壇者 :   さん ( [@sawanoboly](https://twitter.com/sawanoboly) )
+ 資料 :  




## 5コマ目「ディスカッションとか突発ライトニングトーク大会とか」

1. 「」 [](https://github.com/) さん
0. 「」 [](https://github.com/) さん
0. 「」 [](https://github.com/) さん


# 小並感


# おまけ
