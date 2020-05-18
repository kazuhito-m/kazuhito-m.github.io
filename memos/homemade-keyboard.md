自作キーボード
===

今回買ったのは…

__Iris FR4 Plates Set__

です。

https://yushakobo.jp/shop/iris-fr4-plates-set/

- ほぼ組み立て済み
- キーキャップとキースイッチ程度の買い物さえあれば、組み立てられる

 ## 組み立て

- Iris Rev. 3 & 4 Build Guide
  - https://docs.keeb.io/iris-rev3-build-guide/
  - ほぼ、コレだけで行ける（はず）

## ファームウェア書き込み

- QMKfirmwareをビルドする
  - http://tech.synchro-food.co.jp/entry/2018/03/05/164342
  - 少しことなるところもあるが、「基本、このやり方」で踏襲する
  - 「書き込む順番」にも言及している
- qmk-firmewareを使う方法
  - https://qiita.com/not13/items/d2ec93b27bcd4d890dcc
  - GUI版なのだが、なぜかLinuxがない
  - 余談(Linxu無いの？)のイシュー
- ”Iris" 特化ページ
  - https://github.com/qmk/qmk_firmware/blob/master/keyboards/keebio/iris/readme.md
  - 以前とは位置が新調されているが、ここが正だと思われる
- Iris rev.4 でビルドしている例
  - https://qiita.com/KZ2/items/e8f2d5a14cfedc628b8a
  - なんか「デザインするUI」みたいなのがある
- Irisで初めて自作キーボードを作りました
  - https://blog.yfuku.com/entry/iris_build
  - 「ファームウェア」の部分に「書き込み順」がある

## キーキャップ塗装

基本、元々持ってたキャップを使うので黒なのだが「意味が違うもの」をそのまま使うのは、自分が混乱しそうなので、「黒で消す」したい。

- キーキャップを塗り替えてみる
  - https://reactionarycraft.hateblo.jp/entry/2019/07/29/012138
  - ガンダムマーカーで「指で剥げないものができる」「他の黒と違う感じにならないか」は疑問


## Iris(rev.4)の固有の問題

- Iris: はじめての自作キーボード〜失敗談とその解決方法〜
  - https://techracho.bpsinc.jp/ohno/2018_12_20/67127
- ぼくがかんがえたさいきょうのiris keyboard Keymap （2018.9版）
  - https://yamatomura.blogspot.com/2018/09/iris-keymap-20189.html
  - ただ「コードがダダはりしてあるだけ」なので…読むのだるい

## QMKまわり

- カスタムキーマップで自作キーボードを自分の分身とする
  - https://ascii.jp/elem/000/001/645/1645504/
  - 良くよく読むと、わかりやすく、やりたいことにつながることが書いている
- QMK Firmware で Raise/Lower と変換/無変換を同じキーに割り当てる
  - https://okapies.hateblo.jp/entry/2019/02/02/133953
  - Raise/Lowerのハナシが知りたくて調べたが…なんか難しそう
- プログラマーではない人向けのQMK Firmware入門
  - https://qiita.com/cactusman/items/ac41993d1682c6d8a12e
- はじめてのQMKキーマップ編集
  - https://qiita.com/marksard/items/9317949ce1da327f7436
- QMK Firmwareのすすめ
  - https://scrapbox.io/list-memo/QMK_Firmware%E3%81%AE%E3%81%99%E3%81%99%E3%82%81
  - 章立てが不思議…なんかの日本語翻訳なのかな？
- https://www.youtube.com/watch?v=-imgglzDMdY
  - 書き込むまでの懇切丁寧な動画


## キーボードを迷う部分

- 無切り替えで必要だと思われる特殊キー
  - ALT,SHIFT,CTRL,ESC,BS,DEL,ENTER,WIN,SPACE

### キーマップ参考

- https://www.codesuji.com/2019/05/12/Iris-Keyboard/
  - 右側端っこらへんが足りないな…
- https://www.reddit.com/r/olkb/comments/933xjk/help_im_using_qmk_config_qmk_toolbox_on_my_iris/
  - 2つ目のレイヤーを「どういうテーマでキーを集めるのか」だよなぁ
- https://blog.deltabox.site/post/2018/10/iris_keymap_now/
  - 図は無いが「なにを重要視すべきか」の参考になる
- https://blog.yfuku.com/entry/corne_keymap
  - こちらも「人としての傾向」というところに言及している
  - 「数値入力をワンレイヤー当てはめてしまう」「中央段に配置してしまう」というのは、なかなかのアイディア


---

## 作業

### はんだ付け

下記のqmkを流し込まなくても、最初から「USBに繋げば動く」ので、「はんだ付けがしっぱいしてないか」「ハード的に動くか」は、この時点でPCに接続し、確認したほうがよいと思います。

### qmkビルド・流し込み

```bash
git clone --recurse-submodules --depth 1  https://github.com/kazuhito-m/qmk_firmware.git
cd qmk_firmware
./util/qmk_install.sh
make keebio/iris/rev4:default
```

上記をやると、以下のエラーが起こり続ける。

```bash
QMK Firmware 0.9.5
Making keebio/iris/rev4 with keymap default and target flash

avr-gcc (GCC) 5.4.0
Copyright (C) 2015 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

Size before:
   text    data     bss     dec     hex filename
      0   27000       0   27000    6978 .build/keebio_iris_rev4_default.hex
Checking file size of keebio_iris_rev4_default.hex                                                  [OK]
 * The firmware size is fine - 27000/28672 (94%, 1672 bytes free)
dfu-programmer: no device present.
ERROR: Bootloader not found. Trying again in 5s.
dfu-programmer: no device present.
ERROR: Bootloader not found. Trying again in 5s.
dfu-programmer: no device present.
ERROR: Bootloader not found. Trying again in 5s.

...(以下繰り返し)
```

[ここ](https://makotophotography.blog/2019/05/02/elite%E2%88%92c-qmk/) の情報に「Elite−C にはオンボード・リセットボタンがあるので…」という記述があり、一体型であるこのボードの裏に「ボタンは無いか？」を調べた結果、あったので上記エラーが出ている最中に押しました。

```bash
...

dfu-programmer: no device present.
ERROR: Bootloader not found. Trying again in 5s.
dfu-programmer: no device present.
ERROR: Bootloader not found. Trying again in 5s.
Bootloader Version: 0x00 (0)
Validating...
27000 bytes used (94.17%)
```

おそらく、書き込めたのではないか？と思います。

### qmkで「自分のキーマップを作る」

以下のサイトで「自分のキーマップのデザイン」を行う。

https://config.qmk.fm/#/keebio/iris/rev4/LAYOUT


設定ができたら、右上の「COMPILE」ボタンを押し、ビルドが終われば右下の「FIRMWARE」ボタンでhexファイルをDLします。

また、バックアップのためjsonのダウンロードも行っておきます。


### qmkで「自分のプロファイル」をキーボードに書き込む

上記で取得したHexファイルを、キーボードに書き込む。

前述でCloneしたリポジトリには、一度ビルドを行っていることから、 `./build` ディレクトリができているはずです。

ここに先程DL済みのHexファイルをコピーした後、キーボードの接続を確認したら、以下のコマンドで書き込みます。

```bash
make keebio/iris/rev4:kazuhito_m:flash
```

