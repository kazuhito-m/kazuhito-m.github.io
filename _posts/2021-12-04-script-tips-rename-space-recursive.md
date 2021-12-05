---
published: true
layout: post
title: シェルスクリプト備忘録:再帰的にディレクトリ・ファイルの名前からスペースを置換する
category: tech
tags: [linux, bash, find, tips]
---

## これを読んで得られるもの

- Linuxのディレクトリ・ファイルの名前から半角スペースをアンダースコアに変更を再帰的に行うスクリプトの書き方

## シェルスクリプトで「半角スペースさえなければ…」と思うことの多さ

ファイル整理で、ファイルやディレクトリ名の特定文字を置換したり、連番振ったり…というシチュエーションは多く在ると思います。

そういう時に役立つのが、`find`, `ls` やそれと組み合わせた `rename`,`sed`, `for`, `xargs` などのコマンド群だと思います。

…ですが、forで回す際に「ファイル名に半角スペースが含まれる」場合、多くの場合うまくいきません。

それは、`bash` の「標準の区切り文字」を半角スペースだと認識しているためです。

例えば、 `a b c.txt` を `a`, `b`, `c.txt`  というような分解で、次のコマンドへと送るためです。

これを考慮し「予め半角スペースを含むディレクトリ・ファイル名をなくしておく」という「下ごしらえのスクリプト」を作成しました。


## 前提

- OS: Ubuntu 20.04.3 LTS
- bash: GNU bash, バージョン 5.0.17
- 必要なコマンド: find, pwd, sort, cd, for, rename

## 実装

やりたいことは「自身の居るディレクトリパス以下を再帰的に掘り進んで、ディレクトリ・ファイル名から、半角スペースをアンダースコアに置換したい」だとします。

```bash
#!/usr/bin/env bash

pre_ifs=$IFS
IFS=$'\n'
for i in $(find $(pwd) -type d | sort -r) ; do
  cd ${i}
  rename 's/ /_/g' ./*
done 
IFS=$pre_ifs
```

まず、環境変数の `IFS` ですが、これは「Internal Field Separator：フィールドセパレータ環境変数」と呼ばれるもので、コマンドの解釈として「何を区切り文字にするか」を決めているものです。

これが「半角スペース」になっていることが、半角スペース入りのファイル名を扱えない理由なので、元の値を保存しておいて、改行に変更しています。

### 処理順の考慮

`find` を使って「ディレクトリのみを再帰的に取得」しています。

その際、相対パスでなく絶対パスとなるように、`pwd` で現在パスを指定します。

そして、`sort -r` でそれを逆順にし、`for` に渡ってくるようにしています。

これは、例えばファイル

```
~/a b/
  /c d/
    /e f/
  /g h/ 
```

みたいな構成だった場合、ソートしない場合

```
/home/kazuhito/a b/
/home/kazuhito/a b/c d/
/home/kazuhito/a b/c d/e f/
/home/kazuhito/a b/g h/
```

と渡ってきてしまい、`/c d/` がリネームされた後、`/c d/e f/` をリネームすることとなり「そんなディレクトリはない」ので失敗するからです。

そして、渡ってきたディレクトリパスに移動し、`rename` コマンドにより、直下のディレクトリ・ファイル名を半角スペースからアンダースコアに置換しています。

### renameコマンドは無いことが多いかも？

環境によっては `rename` コマンドが無いかもしれません。

その場合は `sed` や `perl` など、より多くの環境に入っているコマンドで置き換え操作をすれば良いと思います。

`sed` の例

```bash
cd ${i}
# rename 's/ /_/g' ./* これが出来ないので…
for j in $(ls) ; do
  mv ${j} $(echo ${j} | sed -e 's/ /_/g')
done
```

## 所感

できれば「ワンライナーかつシンプルな構成にしたい」と思っていたのですが、自分にはこれが限界でした。

これの「下ごしらえ」さえ済んでしまえば、あとはフツーのワンライナーとかで名前置換が容易なのですが…これを一撃でするコマンドやワンライナーは、(自分の検索力では)見つけることが出来ませんでした。

もっと「こんな簡単にできるよ」や「定石としてはすでにこんなんがあるよ」など、ご存知の方がいらしたら、ぜひお教えいただけるとうれしいです。

## 2021-12-05 追記

記事公開後、Twitterからご助言をいただきました。

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">記事を拝見しましたが、やりたいことはスペースが含まれたファイル名を扱うことですよね？それだけならさほど難しくはないと思います。おそらく変数名をダブルクォートで括ってないのが足りてないピースです<br><br>ファイル名に改行が含まれている場合に対応するとなるともうひと工夫必要ですが…</p>&mdash; Koichi Nakashima (@ko1nksm) <a href="https://twitter.com/ko1nksm/status/1467337687833407488?ref_src=twsrc%5Etfw">December 5, 2021</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">改行文字が含まれたファイル名を考慮しないという前提の場合「for と IFS=$&#39;\n&#39; の組み合わせ」または「while IFS= read -r ...を使った方法」のどちらか使うことになります。どちらでもIFSを使いますが後者であればIFSを保存して戻す作業が不要になります。</p>&mdash; Koichi Nakashima (@ko1nksm) <a href="https://twitter.com/ko1nksm/status/1467347548696616960?ref_src=twsrc%5Etfw">December 5, 2021</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

なるほど、 `while IFS='' read -r ...` でやれば良いんですね。実際に動かしてみましょう。

```bash
#!/usr/bin/env bash

find $(pwd) -type d | sort -r | while IFS='' read -r i; do
  cd "${i}"
  rename 's/ /_/g' ./* 
done
```

これであれば `IFS` の状態を管理したり気にしなくて良いですし、幾分素直なループ文になりますね。

これからは、こちらを常用していきたいと思います。お教えいただきありがとうございました。

## 参考資料


- <http://capm-network.com/?tag=%E3%82%B7%E3%82%A7%E3%83%AB%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88-%E3%82%B9%E3%83%9A%E3%83%BC%E3%82%B9%E3%81%8C%E5%90%AB%E3%81%BE%E3%82%8C%E3%82%8B%E6%96%87%E5%AD%97%E5%88%97%E3%82%92%E6%89%B1%E3%81%86>
  - IFSの解説
- <https://genzouw.com/entry/2020/09/27/231631/2073/>
  - シェバンの一般系がわからなかったので
