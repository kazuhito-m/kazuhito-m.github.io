---
layout: post
title: ブラウザ操作(スクレイピング)ライブラリを組み合わせて操作を実現する
category: tech
published: false
tags: [web,scraping,jsoup,selenium,sikuri]
---

ハラたったんで、感情に任せて作ってみました。

__※ちょっとした悪用できそうなので、そんなんしないでくださいね__

# これを読んで得られるもの

- Javaでのスクレイピングやブラウザ操作のサンプル
- Googleへのサイト登録方法
  - やり方だけ、自動化は不完全
- `jsoup` , `selenium` , `sikuri` の使いドコロとサワリ程度

# 経緯

この弱小ブログも過去記事を移行しまして、一日の閲覧が 30=>60 くらい(二倍)になりまして。

ただ、新記事書いた時には100くらいは行く…と思ったんですが、最新記事がそうならない。

タイトルも「2年前のトレンドくらいをふんだんに入れた」のに…。

ぐぐってみると…「タイトルコピペってんのに引っかからない！(数日立ってんのに)」ってなりまして、どうやらクローリングにひっかかってない様子。

調べてみると「手動で登録する画面がある」模様。

おのれg○○gle! ということで、「みうら、怒りの自動化」です。

# やったこと

## やることの要約(仕様)

1. スクレイピングで自分のブログの記事リンクの一覧を取得
0. ブラウザ開いて、URLを回しながら登録
0. その際「人間が視認でクリック」するところがあるので、それを突破

をしたい(する必要がある)のですが、それを

1. jsoup:スクレイピングライブラリ
0. selenium:ブラウザコントロールライブラリ
0. sikuli:画像認識＆画面操作ライブラリ

と、リレーして実現します。

実現のために `SpringBoot` の `Batch` を使ってますが、やってみたかっただけなので主題と関係ありません。

## スクレイピング部分(jsoupを使った実装部分)

…なんか「自分のサイトをスクレイピングする」って不思議な気分ですね…。

## ブラウザ操作(selenium部分)

## ブラウザ操作(sikuli部分)

## 致命的な問題(できませんでした報告)

# 参考

以下のURLを参考にさせていただきました。感謝。

- <http://kagamihoge.hatenablog.com/entry/2015/02/14/144238>
- <https://stackoverflow.com/questions/45643956/illegalaccesserror-thrown-by-new-chromedriver-on-osx-java>
  - ChromeDriverの動かす方法(Exception回避)
- <http://doc.sikuli.org/faq/030-java-dev.html>
- <https://github.com/sikuli/sikuli-api/blob/master/examples/src/main/java/org/sikuli/api/examples/basic/FindExample.java>

## 今回の本質的じゃない話題

- Jar内のファイル取出:<https://qiita.com/kikuchy/items/e63c670bc37705b6dd5d>
- Javaから権限変更:<http://pilvoj.hatenablog.com/entry/2013/04/09/222849>
