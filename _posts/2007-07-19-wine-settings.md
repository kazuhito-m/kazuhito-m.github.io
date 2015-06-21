---
published: false
layout: post
title: Wineの小さな設定
category: tech
tags: [linux,centos,wine]
---

毎回、設定を忘れしまうWineの備忘録

## 日本語入力

従来のWineではパッチを当てないと日本語を入力できなかったのですが、
Wine-20040121 以降からは普通に（Ctrl+[SPACE]等）で入力できるようになっています。

もし、日本語を入力しようとするとIMがビロビロして入力できない場合は、

~/.wine/user.reg を編集。

```bash
[Software\\Wine\\X11 Driver] 1129995218
"ClientSideAntiAliasWithRender"="N"
"InputStyle"="overthespot"
```

## 参考にした資料

[http://fun.poosan.net/sawa/index.php?UID=1171815292](http://fun.poosan.net/sawa/index.php?UID=1171815292)
