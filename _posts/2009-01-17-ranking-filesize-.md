---
layout: post
title: ファイル整理時に役に立つコマンド(ファイルサイズランキング)
category: tech
tags: [linux,tips,filesystem]
---

以前、現場で役立つコマンドとして、

```bash
du | sort -nr | head
```

を備忘録として書きました。

が、これではフォルダだけしかわからない上に、対象フォルダ自体も引っかかってしまいます。

---

ということで、「ファイルだけを対象にランキングするコマンド」を、備忘録しておきます。

```bash
find ./ ! -type d -exec ls -alds {} \; | sort -n | tail -50
```

最後の数値で「何位まで表示」が決まるので、そこらへんで調整を。
