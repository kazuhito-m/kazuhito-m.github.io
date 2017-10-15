---
layout: post
title: btrfsでの診断と復旧(できるだけダンプ)
category: tech
tags: [btrfs, linux, ubuntu, datarescue, recovery]
---

ノートPCをSSDに換装するのに「せっかくだから…(デスクリ風)」と「メモリディスクと相性が良い(という喧伝)」がウリのファイルシステム"btrfs"をルートFSにして、Ubuntu11で使用していました。

しかし、起動時に"error: sparse file no allowed"など、「死にはしないが不穏な感じ」は醸していました。
(これは「回避不能なバグ」として報告されていました。)

で、とうとう、Ubuntu12にアップグレードする際、起動不能になってしまいました。

どうも見ていると、grubは通過しており、Ubuntuロゴで「ファイルシステムが読めずmount出来ない」で止まっている模様。
(ログ取得は失念しました、サーセン)

で、「いつか未来の技術で修復できたら…」と「コールドスリープ」よろしく塩漬けてたのですが、 __「未来の技術でなんとかなった」__ ので備忘として書いておきます。

# 参考

- [http://lapismoon.tumblr.com/post/2730839833/btrfs](http://lapismoon.tumblr.com/post/2730839833/btrfs)
- [http://japan.internet.com/webtech/20120522/2.html](http://japan.internet.com/webtech/20120522/2.html)

# 使う道具

- Ubuntu 13.14 をインストールしたPC
- 破損したbtrfsフォーマットのHDD(上記PCに接続)

# やったこと

※以下の作業はすべて"sudo su - "でrootになって行っています。

まずは「認識しているか」確認。

```bash
ls  /dev/sd*
/dev/sda  /dev/sda1  /dev/sdb  /dev/sdb1  /dev/sdc ...
```

/deb/sdb1 でそのHDDを認識した様子。

次にチェックを行います。

```
btrfsck -s 1 /dev/sdb1

checking extents
checking fs roots
root 256 inode 134434 errors 400
root 256 inode 141903 errors 400
(以下、このerrors表示が35行)
found 28013846528 bytes used err is 1
total csum bytes: 26610968
total tree bytes: 731906048
total fs tree bytes: 654274560
btree space waste bytes: 195829544
file data blocks allocated: 41893093376
 referenced 26841923584
Btrfs v0.20-rc1
```

どうやら、inodeが35箇所に渡り壊れている模様。

mountしてみてもダメ(mountコマンドで固まる)で、修復手段はやはりみつかりませんでしたが、
「Linux3.4以降では "btrfs-restore" コマンドが使える」とのこと(上記参考サイト)なので、それを利用して「復旧」ではなく「生きてる奴だけサルベージ」することに。

```bash
mkdir dump
btrfs-restore /dev/sdb1 ./dump/

Root objectid is 5
We have looped trying to restore files in ./dump/@[元のDir構造] too many times to be making progress, stopping
(同じような出力が10行くらい)
We seem to be looping a lot on ./dump/@[元のDir構造] do you want to keep going on ? (y/N):
(同じような出力が20形くらい、全部Enter連打)
btrfs-restore: extent_io.c:602: free_extent_buffer: Assertion `!(eb->refs < 0)' failed.
中止 (コアダンプ)
```

間違い無く「変な終わりかた(死にかた？)」してますが、結果を見てみます。

```bash
ls -l ./dump/

合計 8
drwxr-xr-x 22 root root 4096  5月  4 01:16 @
drwxr-xr-x  4 root root 4096  5月  4 01:24 @home
```

うお、何か出てる。
`@home` の中には、元 `/home` だった中身が、 `@` の中には `/home以外(/bin /usr /lib とか)` が入っていました。

---

# 小並感

おそらく「全量はサルベージ出来ていない」と思われますが、欲しかったファイルはほぼ復旧出来たので、良かったです。

「未来の技術に任せる作戦」は普通「元のものに取っとく価値が無くなる」で終了することも多いですが、時には「うまくいく」のでバカにできませんね。
