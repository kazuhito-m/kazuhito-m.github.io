---
layout: post
title: Linux用MAME使ってみる
category: tech
tags: [linux,mame,fedora9]
---

甥っ子用にレトロゲー端末を作ってて、「メイン機でもMame使ってみてえな」と思い立って、
LinuxでMame入れて使ってみました。

## やったこと

まず、[ここ](https://web.archive.org/web/20100718023433/http://dribble.org.uk/listrpms7.html)から

Fedora8用のX86_64バイナリの

- qmc2-0.2-0.1.b1.fc8.drb.x86_64.rpm
- sdlmame-0124-1.fc8.drb.x86_64.rpm
- sdlmame-data-0124-1.fc8.drb.noarch.rpm
- sdlmame-data-artwork-0120-1.fc8.drb.noarch.rpm
- sdlmame-data-roms-0120-1.fc8.drb.noarch.rpm
- sdlmame-data-samples-0120-1.fc8.drb.noarch.rpm
- sdlmame-tools-0124-1.fc8.drb.x86_64.rpm

など取ってきて適宜インストールします。

ちょっと、アプリケーション→ゲームのメニューが変わってしまいますが、キニシナイ！w

んで、起動。終了。ゲーム選んで遊ぶべし！

## ハマリ点

途中、ROMを読まないのでハマったが、

`/etc/mame/mame.ini`

のrompathに自分のRom置き場を追記したらいけるらしい…のだが、うまくいかないので、

`/usr/share/mame/roms`

自体をリネーム、自分のRom置き場をシンボリックリンクでromsとしたらいけました。
