---
layout: post
title: SonyVAIOの「バッテリーの充電が完了しました」音声ファイルを取り出す
category: tech
tags: [windows, salvage]
---

多分ニーズないだろうけれど…ｗ 自分的に苦労したので記録しときます。

## 経緯

知人がメールの着信音を、SonyVAIOの"消したい音声"でおなじみ「バッテリーの充電が完了しました。」にしてて笑ったので、自分の携帯の充電完了音をそれにしたくて探しました。

(無論、俺の携帯はW-ZERO3、Sony製ではないｗ)

あと、 [ココ](http://ascii.jp/elem/000/000/329/329874/)見て感動したり、「茂木さん美人さんだなぁ」とか色々…

で、音声ファイルを捜すが、Google先生は無いの一点張り。
ここで、Sony公式の「ドライバダウンロードサイト」にユティリティが転がってないか探してみると…ビンゴでした。

# やること

## 前提

- マシンの用意
  - どうなっても良いWindowsXPマシン

## やったこと

※レジストリやProgramFiles内を汚すので、どうなっても良い環境でやるのが吉です。一番賢いのは、使い捨ての仮想OS内かも？

1. [ココ](http://dlv.update.sony.net/pub/vaio/download/winxp/PowerPanel_410S009XA.exe)から `PowerPanel_410S009XA.exe` をダウンロードし、解凍。
0. フォルダができると思うので、 `Disk1\Setup.exe` 実行。
0. エラーメッセージが出まくると思うが、OK押しまくる。
0. `C:\Program Files\PowerPanel\Program` (デフォルトなら) というフォルダが出来ていたら、そこに `FULLBAT.WAV` 、 `LOWBAT.WAV` が出来てれば成功。

…ただ「セットアップ失敗するユティリティの中から残骸取り出している」だけですけどねｗ

少し足りない作業があるかも？「"SnyUtils.dll"が無い」的なメッセージで、インストーラが進まない人は、 [ココ](http://esupport.sony.com/US/perl/swu-download.pl?mdl=PCGC1XS&upd_id=374&os_id=4&ULA=YES)から `SUDLLME.EXE` をダウンロードしてインストールしてみてください。


---

# 小並感

必要ないし、作業としてもレベルの低いものですが、 [欲しかったので人の実機から取り出した人](http://d.hatena.ne.jp/chicadside/20100329#p2) も居るみたいなので、もちょと簡単なのを取りあえず記録してみました。

これで、Sharp製の我が携帯もSonyStyle（パチもん)へと、よりウサン臭くなれたのではないかとｗ
