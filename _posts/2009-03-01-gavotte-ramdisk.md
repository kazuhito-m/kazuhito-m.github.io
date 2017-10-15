---
layout: post
title: OS管理外メモリを利用可能にする「Gavotte Ramdisk」
category: tech
tags: [windows,ramdisk]
---

![gavotte](/images/2009-03-01-gavotte-ramdisk.jpg)

今回は旧機復活とは何の関係もないのだけど…

まあ、Winの話なんで、ここにまとめとく。

母親のノートを新しく購入後、メモリを4GBほどに増設したので、その顛末記。

# 調べたこと

## OS管理外メモリとは

WindowsXPないしVistaでの32bit版は、物理的に3ギガ以上積んでも、3ギガ前後までしか認識しない。

## RamDiskとは

メモリをHDDのドライブのように、「ユーザが使うファイルの保存場所」として扱うこと。
あたり前ながら、メモリって電気を流している間中の揮発性のものであるため、電源おとしゃー消える。

## ほんで「Gavotte Ramdisk」とは

OS管理外メモリをRamDiskとして扱ってしまおう、というツール。

# やりかた

ここ参照 : [http://www10.atwiki.jp/gavotterd/pages/11.html](http://www10.atwiki.jp/gavotterd/pages/11.html)

## やったこと

- bcdeditを弄ってPAEをオンに。

XPまではboot.iniを弄れ！だったらしいが…

[http://www.atmarkit.co.jp/fwin2k/win2ktips/1125paeon/paeon.html](http://www.atmarkit.co.jp/fwin2k/win2ktips/1125paeon/paeon.html)

コマンドラインから、以下を実行。

```msdos
> bcdedit /set pae forceenable
```

…と、書いてみたものの、システム情報は最初から4.00GBだったし、VistaSP1以降はデフォルトでOnだったのかもしれない。分からん。

あとは、まとめサイトのコピペになるけど…

1. ram4g.regを実行　（続行確認が数度表示されるので、はい、ＯＫ　とかクリック）
0. ramdisk.exeを実行（Vistaは右クリックから「管理者として実行」）
0. [Install Ramdisk]ボタンをクリック　（２０秒程度掛かります）
0. FixedMediaを選択　16MBなり適当に設定　（デフォルトでそうなっていますが、念のため確認のこと）
0. [ＯＫ]ボタンをクリック　（「Success」と表示がでるのでＯＫをクリック）
0. 再起動

おー！R:ドライブにRamDisk-PAEが出現！(添付ファイル参照)

そう仕込んだのだから、あたり前だけどw

## 使い方

とりあえず、自身のマシンなら、

「各種"早くなったら嬉しい系ファイル郡"を、RamDiskに置いてー、んで、終了時に退避、起動時にNTFSフォーマット後に復元してー♪」

とか、考えるんだけど(実際まとめWikiには多く例がある)、他人のマシンだし、何に使えば効果的かわからないので…

- ページングファイルに最大割り当て

の１択でw

(そもそも、動機は「メモリ最大使いたい」という願望なのだから、原点に立ち返り、です。)

Fat32だけどキニシナイ！

(先輩が「Fat32のほうが要らん事しないから早いはず」って言ってた気がするが、今となっては眉唾だな)

# 小並感

しっかし、Winってなんでそんな仕様なんだろう？

UNIX系って昔からメモリつみ放題だったような…
