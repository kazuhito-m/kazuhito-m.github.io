---
layout: post
title: 勉強会行ってみた「第２回 関西golang勉強会」#KUG2
category: study-meeting-repo
tags: [golang,programing]
---

GO言語を習いに勉強会に来たら…カラアゲだった。

# 情報

+ [申し込みサイト](http://kug2.connpass.com/event/20271/)
+ ハッシュタグ : [#KUG2](https://twitter.com/search?q=%23KUG2)
+ 何するのか : プログラム言語「GO」を学びたい人が、勉強会を企画するに「とりあえず好きなことを喋ってみる」みたいなことですかね…。

# なんで来たん？

# 内容


## ２コマ目

シナジーマーケティングでのgolangの導入事例のお話でした。


DroneIO使ってるとか暑いですね！

go-bindateがコンパイルに時間かかったらしい。ちゃんと知りたいな。

### レビュー

+ gofmt,golintは瑣末な部分は回避
+ メンバー間のスキル差が顕著
  + GOクイズとかしといた
+ Goらしさはgolangから雰囲気掴んでる
+ Gin最強！みたいな記事、でも…ほんとにメンテしてるの？
+ Package管理
  + SCMにはGitlab
+ Gom
  + マスターに問題があるとブランチの切り替えができない
+ データベース関連
  + database/sqlとlib/pqで頑張ってる
  + 自作でコードジェネレータ作った
+ テスト関連
  + testify
+ 学習コスト高くない
  + syncパッケージでだいたい解決する

## ３コマ目

はたじょーさん

### 内製フレームワーク

+ modelsレイヤー
  + datasoudce - スタティックデータ
  + master - マスタデータ構造体(ARっぽいORM)
  + member - に会員データ構造体(ARっぽいORM)
+ serviceレイヤー

### パッケージ名悩む

+ Package Names というブログの記事
+ Effective GOとかに書いてある(サイト)
+ 新しくでた本

### 完成ではない

+ ４度ほどフルスクラッチで書きなおしている

### モデルにビジネスロジックを入れない

+ 同じ階層に入れてしまうと循環参照で積むことがある
+ 解決法: サービスにインターフェイス経由で渡す

### gieneridsが必要な部分は自動生成

+ go-generate & gen
  + ヘッダコメントに書くと、その構造体のスライス型のパッケージが自動生成される

### margen

+ margen


### map[string]interface{} は避けたい

+ 型の恩恵を受けられない

### protocolbuffersd , flatbuffers

+ fbはシリアライズ、デシリアライズでアロケーションしないので早いらしい

## ４コマ目

堀内 辰(ににた難しい字)彦
@hiro_horiuchi

+ 自己紹介
  + お掃除ｗ
+ GOでWebAPPを作るメリット
  + ミニファイできるツールがある
+ 僕が考えた最強のディレクトリ構成
+ Ginでbindaを配信
+ fleshでビルドしながら開発

## ５コマ目

のぼのぼさん

+ JavaScriptのつらみ
  + 暗黙の型変換
  + 並列処理の方式多様さ
  + 最新技術の追いがつらい
  + AltJSの誕生しまくり
+ BNF300行以下で簡単なやつでJSライブラリ作ったら…がGopherJSなのです
  + 100%Go記述をJS記述に変換
  + JSアーキテクチャとしてGOPATH共有
  + IO周りはかなり依存がある
+ GopharJS
  + ブラウザにのってるツールでGOのソースをデバッグできる
+ 使えないパッケージ
  + cgo依存パッケージ
  + os,syscall
  + net/cgi,net/pprof
+ インストール
  + GOの環境があればワンライン
+ 使い方麺
  + js.Object.* がすべてのJSレイヤーとのやり取りをする

# 小並感


