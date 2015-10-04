---
layout: post
title: Chromebock "Asus C300MA" に「生のOS(UbuntuLinux)」を入れる方法
category: tech
tags: [ubuntu,linux,chromebook,chromeos,install]
---

![どこからみてもUbuntuですね](/images/2015-10-04-top.jpg)

# Chromebookを買ったんですよ

兼ねてから

+ メモリ4GB以上
+ でもMBAよりちょっと重い程度の軽量
+ でもって３万切る

というPCを探していたのです。

んで「カタログスペックだけはそれを実現している」なノートPC、

「Asus C300MA(メモリ4GB版)」

を買ったのです。(26K円ちょい)


## でもね

当たり前ながらChromebookなのでChromeOSです。

それ自体は了解済みで「これもおもしろいなｗ」と思って買ったし、
実際触ってみると「よく出来てるなー」で面白かったです。

が、

自身の主戦場は「Linux」で常用は「Ubuntu」です。

やっぱりそれが動かせないと値打ちが半減するので
「ま、いけるやろ」で取り組みはじめました。

# ChormebookでUbuntuを使う一般的な方法

0. chroot環境で動かす
0. (ChromeOSと親和性の高い)専用ディストリ(自体はカーネルはChromeOS)を使ったデュアルブート

があり、それぞれ

0. croutonをインストールしChromeOS上でソフト的に切り替えて使う
0. ChrUbuntuをインストール

という手段が在ります。

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

<blockquote class="twitter-tweet" lang="ja" 
  data-conversation="none"><p lang="ja" dir="ltr"><a href="https://twitter.com/kazuhito_m">@kazuhito_m</a> ライトプロテクトスクリューの情報はこれね。 <a href="http://t.co/Kfn4YUyBr7">http://t.co/Kfn4YUyBr7</a></p>&mdash; 78tch (@78tch) <a href="https://twitter.com/78tch/status/650233708989972480">2015, 10月 3</a></blockquote>
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

## 分解

[先のページ](http://www.matws.org/c300/)を元に分解していきます。

### カバー外し

内部に手を入れるため、上部カバーを開きます。

底面の11個のネジを外します。(なんだかゆるくしめてありました)

![ネジ外してる写真](/images/2015-10-04-ura.jpg)

次に画面を開き、キーボードが載ってる天板を開きます。

ネジを取れればパカッと開く…わけではなく
「天板と本体は絶妙な硬さの爪で閉じてある」
ため、タッチパッド側の隙間にマイナスドライバーを恐る恐る入れて、パキパキ剥がします。

![こわいこわい](/images/2015-10-04-kowai.jpg)

外すととこんな感じ。

![天板がはずれた状態](/images/2015-10-04-hazushi.jpg)

### ハードウェア書き込み保護ネジ(Write-Protect Screw)はずし

天板を開くと、左端の「SDカード端子」の上に「小さく平たい銀ネジ」があります。

それが「ハードウェア書き込み保護ネジ(Write-Protect Screw)」です。

![書き込み保護ネジの場所](/images/2015-10-04-negi-pos.jpg)

プラスドライバーで外します。

![書き込み保護ネジの外し方](/images/2015-10-04-negi-hazusi.jpg)

単体じゃこんな感じ。

![書き込み保護ネジ](/images/2015-10-04-neji.jpg)

(とりあえず万が一の時のために保管しておきましょう。)

##  Firmware(SeaBIOS)書き換え

[先のページ](http://www.matws.org/c300/)の最後の方に

_「John LewisさんがC300用のSeaBIOS用意してくれたよ！３ステップで普通のPCをみたいになるよ！」_

と書いてくれてるのでそのとおりにします。

### Chromebookを「ChromeOS Developer Mode」に移行し「OS確認機能」をOFF

※ここらへんの作業は [@78tchさんのブログ](http://78tch.blog49.fc2.com/blog-entry-79.html) のが詳しいので参考下さい。

キーボード最上段の「esc」「ぐるぐるマーク」「電源」の３つのボタンを同時押しして下さい。

「Chrome Os is missing or ...」と表示された白い画面が表示されます。

ここで、Ctrl+D 後で Enter 押下でデータ削除。

この時に「OS確認機能(OS verificationx)」がOFFになります。

しばらくほっとくと「デベロッパーモードに移行する準備を行っています。」とでてまた待たされます。

(上に地味に文字でのインジケータが表示されてますけどｗ)

終わると、短く元の画面が出た後、電源断 -> ロゴ -> デベロッパーモードでの起動で「ようこそ！」画面になります。

### ネットワーク(だけ)設定

ようこそ！画面で「ネットワークを選択」で、無線LANの設定だけします。

その画面から進まないで、次の作業に入ります。

### BIOS書き換え実行

Ctrl + Alt +「→」を押して「Developer Console」を出します。

(ちなみに、Ctrl + Alt +「→」 or Ctrl + Alt +「←」WindowManagerの行き来、Ctrl + Alt +「ぐるぐる」で
新たなコンソールを生む模様。)

"root"でログインし、適当なとこへ移動してファイルをダウンロード＆解凍します。

(ホームディレクトリの /root は、書き込み専用ファイルシステムにあるようなので。)

```bash
mkdir /tmp/work
cd /tmp/work
wget http://www.matws.org/c300/lewis-fw-c300.tar.gz
tar xzf lewis-fw-c300.tar.gz
cd lewis-fw-c300
```

続いて、「BIOS書き換えスクリプト」を実行します。

```bash
bash ./flash_chromebook_rom.sh
```

途中の選択肢は"2"を選びました。

また、途中で「本当にFlashしたいなら、この文字を繰り返して打ちなさい！」みたいなのがきたので、

'If this bricks my quawks, on my head be it!'

を手打ちしました。

最後に「〜successfully. You can hopefully, safely reboot!」とか出たため、

```bash
shutdown -r now
```

して、再起動。

画面の最上部に「SeaBIOS ...」と出ていれば、書き換え成功です。

## UbuntuをUSBメモリからインストール

通常のPCへのインストールよろしく、ブータブルUSB作ってUbuntuをインストールしてきます。

### Ubuntuインストイール用ISOイメージダウンロードとUSBメモリへの書き込み

現時点で最新の「Ubuntu日本語リミックス」をダウンロードしUSBメモリに流し込みます。

Chromebookとは別のマシン(Linux想定)で、以下のコマンドを叩きます。

```bash
wget http://cdimage.ubuntulinux.jp/releases/15.04/ubuntu-ja-15.04-desktop-amd64.iso
sudo dd if=./ubuntu-ja-15.04-desktop-amd64.iso of=/dev/「USBメモリのデバイス」
```

※一度目は「unetbootinを使ってメモリ書き込み」しましたが、
それではブート時に「Failed to load COM32 file menu.c32」のエラーが出るためやめました。

### ブータブルUSBメモリからUbuntuをインストール

Choromebookの電源を入れると、先の作業でSeaBIOSが立ち上がるように成ってると思います。

Esc連打して「ブートデバイス選ぶ」状態にし、

#### インストール中に行ったこと

+ サードパーティのパッケージを有効
+ 元のパーティションは_全破壊_してUbuntuの標準的パーティションに変更

つまり「もうChromeOSに戻れない」ということですｗ

※一度目は「ChromeOSに戻れるようにしよう」と
「一番大きなパーティション(11GB)から少し切り出して」Ubuntuの領域にしようとしてたのですが、
「インストーラがパーティション切り直し時にエラーを吐いて死に、インストールが中断」するので、
全削除にしました。

# 現行の課題

+ 音が出ません
+ サスペンド復帰でキーボードが打てなくなります

---

以上、振り返ってみたら「盛大に人柱」な感じになりましたが
「2.6万で頃合いのUbuntuマシンが手に入る」と思えば、全然ありかなと言う値頃感ですね。(人件費度外視なら)

しかし…購入数時間で「ChromeOSとおさらば」「保証無しになる」とは…ｗ

もうちょっと整備していきます。興味在る方は続報に期待！

# 謝辞

[@78tch](https://twitter.com/78tch)さんの根気強いサポートでこの記事は実現されております。感謝。

# 参考

以下の記事を参考にさせていただきました。

+ [http://78tch.blog49.fc2.com/blog-entry-79.html](http://78tch.blog49.fc2.com/blog-entry-79.html)
+ [https://wiki.archlinuxjp.org/index.php/Chromebook](https://wiki.archlinuxjp.org/index.php/Chromebook)
+ [http://www.matws.org/c300/](http://www.matws.org/c300/)
+ [https://github.com/iantrich/ChrUbuntu-Guides/blob/master/README.md#supported-models](https://github.com/iantrich/ChrUbuntu-Guides/blob/master/README.md#supported-models)
+ [https://johnlewis.ie/custom-chromebook-firmware/rom-download/](https://github.com/iantrich/ChrUbuntu-Guides/blob/master/README.md#supported-models)

※分解すると保証が切れるます。この記事に書いている作業を試される場合、自己責任でお願いします
