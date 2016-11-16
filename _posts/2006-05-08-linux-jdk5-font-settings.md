---
layout: post
title: jdk5のフォント設定
category: tech
tags: [linux,jdk,font]
---

Linuxでjkd5をインストール後、Judeでブラウジングをします。

しかし、双方パッケージインストールしたにも関わらず文字が豆腐。

文字化けてては観たい情報も見れません。

## 対策


どこかに、以下のことがのっていました。(どこやねんｗ)

j2sdk1.5.0のリリースノートと睨めっこしていると

```jre/lib/fonts/fallback/```

下に日本語TrueTypeフォントをインストールしろ。

と言うような事が書いてあったので何気なしに


```jre/lib/fonts/```

下にディレクトリ ```fallback/``` を作り

```/usr/X11R6/lib/X11/fonts/TrueType/```

下の

```kochi-gothic.ttf,kochi-mincho.ttf```

をコピーして入れてみたところ、フォント設定無しでの通常の日本語表示が可能になりました。

これであらゆる面で問題が解決いたしました。

## キレイにする

上記を加味して、シンボリックリンクで実現

```bash
ln -s /usr/share/fonts/japanese/TrueType/ fallback
```

読んでないが、[ここ](https://docs.oracle.com/javase/jp/6/technotes/guides/intl/fontconfig.html)
に詳しくのってる？
