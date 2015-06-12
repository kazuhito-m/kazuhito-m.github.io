---
published: false
layout: post
title: jdk5のフォント設定
category: tech
tags: [linux,jdk,font]
---

jdk5をインストール。いろいろ問題あるが、judeで文字が豆腐。これは困る。

どこかに、以下のことがのっていた。

j2sdk1.5.0のリリースノートと睨めっこしていると
jre/lib/fonts/fallback/
下に日本語TrueTypeフォントをインストールしろ、と言うような事が書いてあったので何気なしに
jre/lib/fonts/
下にディレクトリfallback/を作り
/usr/X11R6/lib/X11/fonts/TrueType/
下の
kochi-gothic.ttf、kochi-mincho.ttf
をコピーして入れてみたところ、フォント設定無しでの通常の日本語表示が可能になりました。
これであらゆる面で問題が解決いたしました。

上記を加味して、シンボリックリンクで実現

ln -s /usr/share/fonts/japanese/TrueType/ fallback

読んでないが、以下に詳しくのってる？
http://java.sun.com/j2se/1.5.0/ja/docs/ja/guide/intl/fontconfig.html

