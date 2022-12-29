---
layout: post
title: debianでsamba-vscan/vscan-clamav を使ってのリアルタイムスキャン設定
category: tech
tags: [clamav, debian, samba, samba-vscan, tips, windows, security, file-share ]
---

![検出](/images/2010-09-05-debian-realtime-virusscan.jpg)

偉い長い時間ハマった上、希望を満たせなかった…ので記念で記事にします。

---

少し古い技術ですが、「SAMBAでファイルアクセスされた瞬間にウィルススキャンする機構」であるsamba-vscanを導入します。

ウィルススキャンソフトはフリー定番の　`clamav` 。

# 前提

- Linux debian 5.0 (lenny) 2.6.26-2-686 ※安定版の現在最新
- samba clamav 導入済　
  - `apt-get install samba clamav clamav-daemon`
- sambaは、他機からファイルを読み書き出来る状態まで持ってってる
- clamav はclamscan clamdscan くらいテストしてOkな状態
- 方針は基本「楽をする」パッケージで行けるとこはソレで、無理ならビルドとか自前とか
- 作業は、2010/09/05 時点のみ有効

# やったこと

## 前提

1. 作業はすべてrootで行っている体で（良い子は真似しちゃだめ
0. 作業場は `/home/tmp` とします


## ビルド済みのsambaソースを用意

`./configure` , `make` まで終わったsambaが必要らしいので、パッケージの元となったソースを取得しコンパイルします。

```bash
apt-get install gcc
apt-get source samba
cd ./samba-3.*/source
./configure
make proto
```

## samba-vscan の取得・展開

[http://www.openantivirus.org/](http://www.openantivirus.org/) のサイトからソースを落とします。

```bash
wget http://www.openantivirus.org/download/samba-vscan-0.3.6c-beta5.tar.gz
tar -xvzf samba-vscan-0.3.6c-beta5.tar.gz
mv samba-vscan-0.3.6c-beta5 samba-vscan
```

※後述のパッチが上記の"samba-vscan"というディレクトリ名を期待しているため、リネーム

## パッチを当てる

善意の方が作ってくれた野良パッチを当てます。

```bash
wget http://www.maxxer.it/wp-content/uploads/2010/04/samba-3.2.5_vscan-0.3.6c-beta5.patch.gz
gunzip samba-3.2.5_vscan-0.3.6c-beta5.patch.gz
patch -p0 < samba-3.2.5_vscan-0.3.6c-beta5.patch
```

さらに、samba-3.Xに対してインターフェイスが古い(らしい)ので、以下を参考にパッチを作成、当てます。

[http://www.mail-archive.com/samba@lists.samba.org/msg98075.html](http://www.mail-archive.com/samba@lists.samba.org/msg98075.html)

```bash
cd samba-vscan
vi ./global_h_extend.patch
```

```bash
 1 ===================================================================
 2 --- include/vscan-global.h.orig 2004-10-05 21:47:54.000000000 +0200
 3 +++ include/vscan-global.h      2008-12-09 15:55:04.000000000 +0100
 4 @@ -69,6 +69,17 @@
 5   #endif
 6  #endif
 7
 8 +/* Patched by T. Wild, 9.12.2008, because pstrcpy removed by samba.org */
 9
10 +#define PSTRING_LEN 1024
11 +typedef char pstring[PSTRING_LEN];
12 +#define pstrcpy(d,s) safe_strcpy((d),(s),sizeof(pstring)-1)
13 +#define pstrcat(d,s) safe_strcat((d),(s),sizeof(pstring)-1)
14 +
15 +/* Furthermore init_module changed to init_samba_module */
16 +
17 +#define init_module(void) init_samba_module(void)
18 +
19 +/* end of patch by T. Wild */
20
21  #endif /* __VSCAN_GLOBAL_H */
22 ===================================================================
```

```bash
patch -p0 < ./global_h_extend.patch
```

## samba-vscan のコンパイル

先程コンパイルしたsambaのソースをやりやすい場所に移動します。

(作業ディレクトリに移動した前提)

```bash
cp -r ./samba-3.*/source ./samba-vscan/samba-source

configファイルを改造。(オプションで指定しても良いが、全自動で行きたいので)

cd ./samba-vscan
vi ./configure
```

```
   3675 SAMBA_SOURCE="./samba-source"
   3676 SAMBA_INSTALLPERMS_BIN="0644"

   4302 SAMBA_VFSLIBDIR="/usr/lib/samba/vfs"

   6907 s,@SAMBA_INSTALLPERMS_BIN@,$SAMBA_INSTALLPERMS_BIN,;t t
```

※細かいことは、内容読んで「お察し下さい」

```bash
./configure
```

(省略、以下出力)

```bash
** Configuration summary for samba-vscan 0.3.6c beta5 :

 Compile samba-vscan for Samba      : "3.2.5"
 Compile samba-vscan with sources in: ../samba-3.2.5/source/
 Compile samba-vscan backends       : oav sophos fprotd fsav trend icap mksd kavp clamav nai antivir
 Use GLOBAL_LIBS                    :
 Use libmksd as                     : builtin
 Use libkavdc as                    : builtin

Now type "make" to build all mentioned backends.
Or "make {}" to build only specific backend(s).
On *BSD systems please use GNU make (gmake) instead of BSD make (make).
```

と、出る。

```bash
make
```

お、エラーなし？拍子抜けだがうまく行った。(その前に試行錯誤で半日吹っ飛んでるがｗ)

```bash
make install
```

これで、 `/usr/lib/samba/vfs/` に `vscan-*.so` なファイルが10個以上コピーされている…はず。
必要なファイルは `vscan-clamav.so` だけなので、 `make install` せずにファイルコピーでも良いです。

## vscan-clamav の設定

リアルタイムスキャンを行うため,設定ファイルを記述。

### samba側

```bash
vi /etc/samba/smb.conf
```

```bash
 5 [global]
    ～
26 vfs objects = vscan-clamav
27 vscan-clamav: config-file = /etc/samba/vscan-clamav.conf
```

### vscan-clamav側

```bash
vi /etc/samba/vscan-clamav.conf
```

```bash
 1 [samba-vscan]
 2 max file size = 10485760
 3 verbose file logging = yes
 4 scan on open = yes
 5 scan on close = yes
 6 deny access on error = yes
 7 deny access on minor error = yes
 8 send warning message = yes
 9 infected file action = quarantine
10 quarantine directory  = /var/tmp/clamav/quarantine
11 quarantine prefix = vir-
12 max lru files entries = 100　
13 lru file entry lifetime = 5
14 exclude file types =
15 clamd socket name = /var/run/clamav/clamd.ctl
```

再起動

```bash
/etc/init.d/clamav-daemon restart
/etc/init.d/samba restart
```

これで、完了。eicar.com とかテストファイルを置いてみて、アクセス出来ないならOK。

## 既知の問題(っていうか、要望通りで無い点)

### 「ファイルをコピーしに行った時点」で拒否ってくれない

vscan-clamav.confに「発見したらどうするか」の設定があるくらいなので、「ファイル置く→即時に拒否」してくれるのかと思いきや、「ファイルは置ける」「置いた後アクセス不能」という挙動。

たしかにこれなら「外の人には迷惑かけない」仕組になるが、「ウィルスファイルを溜めるサーバ」になっちゃう気が…

設定ファイルとログを観察する限りでは、

1. ファイルコピー時
0. ファイルオープン時
0. ファイルクローズ時

にスキャンしているようですが、そのうち 1. のタイミングの時だけ「発見しても何もしない」ようです。

これは、多分「仕様の動きとは違う」と思われますが…他環境や旧モジュールの組み合わせで検証するほど時間はないので、知っている方が居たらどうか教えてください。

### ウィルススキャンに引掛っての「アクセス拒否」かどうかがわからない

これはきっと仕様。

ウィルススキャンにより異常がおこってもメッセージボックスからではわかりません。

ウィンドウズ上のファイル操作(ウィルスファイルをコピーするとか)なら「指定されたネットワーク名は利用できません」、アプリとかなら「アクセス権がありません」と表示されます。

まあ、仕組を考えればそれが限界な気もするが、なんとかできるならなんとかしたいなぁと。

---

# 小並感

以上、問題ありまくりながらも導入完了し、なんとなくええ感じに。

他サイトでよく言われている、「CPU負荷」「遅い」などは、そもそもネットワーク＆マシンが遅い我が家では「きにならない」→「問題はない」としときましょっかねー。

気になってきたらもう全面廃止でウィークリー全ファイルチェックとかに切り替えようと思います。
