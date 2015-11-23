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

+ 登壇者: [](https://github.com/shige2313) さん
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

## 3コマ目「イマドキなWebサーバー「Hiawatha」の紹介」

+ 登壇者 : Fumihisa Shigekane さん ( [@shige2313](https://twitter.com/shige2313) )
+ 資料 :  

## 4コマ目「VMware的インフラ仮想化の世界」

+ 登壇者 :  さん ( [@shadowhat](https://twitter.com/shadowhat) )
+ 資料 :  


## 5コマ目「ディスカッションとか突発ライトニングトーク大会とか」

1. 「」 [](https://github.com/) さん
0. 「」 [](https://github.com/) さん
0. 「」 [](https://github.com/) さん


# 小並感


# おまけ
