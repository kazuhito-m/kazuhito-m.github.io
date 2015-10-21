---
published: false
layout: post
title: LinuxデスクトップでディレクトリをCLIから英語名にする方法
category: tech
tags: [linux,ubuntu,desktop,howto,tips]
---

Linuxには「デスクトップ運用する場合のユーザのホームディレクトリに最初からあるディレクトリと意味」が決まっています。

(freedesktop.org で提唱されている概念っぽい。[サイト](http://freedesktop.org/wiki/Software/xdg-user-dirs/)では「"well known" user directories」と解説している。ツール等では「xdg-user-dirs」と表現されていることが多い。)


それは「概念的なディレクトリ」であり、初回ディレクトリ時に「言語ロケールごとに実ディレクトリ名がローカライズされ」ます。

![こんな感じのです]()

しかし、日本語だと「コンソールから移動するのに入力が面倒」という理由から「ロケールを英語圏にしてアルファベットに変えてしまう」という知見が、
[世では多く在り](https://www.google.co.jp/search?sourceid=chrome-psyapi2&ion=1&espv=2&ie=UTF-8&q=ubuntu%20%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%20%E8%8B%B1%E8%AA%9E%E5%8C%96&oq=Ubuntu%20%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%20%E8%8B%B1%E8%AA%9E&aqs=chrome.1.69i57j0l5.12343j0j7)ます。

## 一般的な変更方法。

コンソールから、

```bash
LC_ALL=C xdg-user-dirs-gtk-update
```

とやると、ダイアログが表示されるので…

![xdg-user-dirs-gtk-updateリネーム確認ダイアログ]()

# 参考

以下を参考にさせていただきました。ありがとうございます。

+ [http://freedesktop.org/wiki/Software/xdg-user-dirs/](http://freedesktop.org/wiki/Software/xdg-user-dirs/)
+ [https://ja.wikipedia.org/wiki/Freedesktop.org](https://ja.wikipedia.org/wiki/Freedesktop.org)
+ []()
+ []()
+ []()
+ []()
+ []()
+ []()
+ []()
