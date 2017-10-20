---
layout: post
title: ブラウザ操作(スクレイピング)ライブラリを組み合わせて操作を実現する
category: tech
published: false
tags: [web,scraping,jsorp,selenium,sikuri]
---

ハラたったんで、感情に任せて作ってみました。

__※ちょっとした悪用できそうなので、そんなんしないでくださいね__

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

1. jsorp:スクレイピングライブラリ
0. Selenium:ブラウザコントロールライブラリ
0. Sikuri:画像認識＆画面操作ライブラリ

と、リレーして実現します。