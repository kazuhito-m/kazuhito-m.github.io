---
published: false
layout: post
title: Chromebock "ASUS C300MA" に「生のOS(UbuntuLinux)」を入れる方法
category: study-meeting-repo
tags: [ubuntu,linux,chromebook,chromeos,install]
---

# Chromebookを買ったんですよ

兼ねてから

+ メモリ4GB以上
+ でもMBAよりちょっと重い程度の軽量
+ でもって３万切る

というPCを探していたのですね。

んで「カタログスペックだけはそれを実現している」なノートPC、

「Asus C300MA(メモリ4GB版)」

を買ったのです。(26K円ちょい)


## でもね

当たり前ながらChromebookなのでChromeOSです。

それ自体は了解済みで「これもおもしろいなｗ」と思って買ったし、
実際触ってみると「よく出来てるなー」で面白かったです。

が、

自身の主戦場は「Linux」で、常用は「Ubuntu」です。

やっぱりそれが動かせないと値打ちが半減するので
「ま、いけるやろ」で取り組みはじめました。

# ChormebookでUbuntuを使う一般的な方法

0. chroot環境で動かす
0. (ChromeOSと親和性の高い)専用ディストリ(自体はカーネルはChromeOS)を使ったデュアルブート

があり、それぞれ

0. croutonをインストールしChromeOS上でソフト的に切り替えて使う
0. ChrUbuntuをインストール

という手段があります。

在りますが「本来のスピードは出ない」「切り替える必要」など
やりたいこと(Ubuntu使う)から考えると、足かせor本質的で無いことと戦うこととなります。

# Chromebookを「普通のPCかのごとく」Ubuntuをインストールする

で「第三の選択肢」として「普通のPCのごとくブート可能USBとかからインストール」ということがしたくなります。

しかし、一般的なChromebookには、そういうことが出来ないように、

0. 「ハードウェア書き込み保護機構(ネジ/スイッチ/ジャンパ)」
0. BIOSで「ブートデバイスを選ぶ機能」を用意しない

という２つのロックをかけている事が多いようで、逆に言えば

0. 「ハードウェア書き込み保護機構」を解除にする
0. BIOSを書き換える

が可能ならば「普通のUbuntu」が入れられるわけです。

※副産物として「Linuxに限らずOSが入れられる」ようになります。

## 「Asus C300MA」の場合

さて「なんとかなるだろ…」で買ったものの…

上記のことを知り
「出来ないなぁ…croutonで"なんちゃって"Ubuntuライフかぁ」と意気消沈していたところ…

<blockquote class="twitter-tweet" lang="ja"><p lang="ja" dir="ltr"><a href="https://twitter.com/kazuhito_m">@kazuhito_m</a> ライトプロテクトスクリューの情報はこれね。 <a href="http://t.co/Kfn4YUyBr7">http://t.co/Kfn4YUyBr7</a></p>&mdash; 78tch (@78tch) <a href="https://twitter.com/78tch/status/650233708989972480">2015, 10月 3</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet" lang="ja"><p lang="ja" dir="ltr"><a href="https://twitter.com/kazuhito_m">@kazuhito_m</a> あ、ライトプロテクトスクリューのしたに、Seabiosについても書いてありますな。これでいけるんじゃない？</p>&mdash; 78tch (@78tch) <a href="https://twitter.com/78tch/status/650234350835859456">2015, 10月 3</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

という情報を、 [@78tch](https://twitter.com/78tch/)さんにいただき、
死中に活を見出しました。

具体的には[このページにAsus C300MA独自の情報をハードレベルで書いて](http://www.matws.org/c300/)おり、やりたいことの先駆が全てあった感じです。

※助言をくれた[@78tch](https://twitter.com/78tch/)さんは、
[おそらくChromebookの生OSインストールノウハウを日本で書いてる数少ない方](http://78tch.blog49.fc2.com/blog-entry-79.html)だと思います。

## 結果

まとめると「Asus C300MA」のロック方式は

0. 「ハードウェア書き込み保護機構」 = ネジ(Write-Protect Screw)

    -> 取り去れば解除

0. BIOSで「ブートデバイスを選ぶ機能」 = 無し

    -> Firmware(John Lewis氏改造SeaBIOS)書き換えれば解除

ということで、これを行いUbuntuを入れていきます。

# インストール手順

## ChromeOS普通にセットアップ＆アップデート

## ChromeOSバックアップ

## 分解

### ハードウェア書き込み保護ネジ(Write-Protect Screw)はずし

# 謝辞

[@78tch](https://twitter.com/78tch)さんの根気強いサポートでこの記事は実現されております。感謝。

# 参考

以下の記事を参考にさせていただきました。

+ http://78tch.blog49.fc2.com/blog-entry-79.html
+ https://wiki.archlinuxjp.org/index.php/Chromebook
+ http://www.matws.org/c300/
+ https://github.com/iantrich/ChrUbuntu-Guides/blob/master/README.md#supported-models
+ https://johnlewis.ie/custom-chromebook-firmware/rom-download/

※分解すると保証が切れるます。この記事に書いている作業を試される場合、自己責任でお願いします
