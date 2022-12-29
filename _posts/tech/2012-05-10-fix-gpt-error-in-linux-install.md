---
layout: post
title: Linuxディストリのインストール時に「… cannot boot using GPT」で続行出来ない場合の対処(忙しい人向け)
category: tech
tags: [centos, gpt, linux, mbr, trubleshoot, partition, bootloader]
---

CentOSなど、昨今のディストリビューションのインストール時に、以下のようなエラーが出て、続行できない場合があります。

```bash
You boot partition is on a disk using the GPT partitioning
scheme but this machine cannot boot using GPT
```

その場合の手っ取り早い対処を方法を備忘として書きます。

# 方法

１CDLinuxやディストリの"linux rescue"起動など、

「インストール対象のHDDを未マウントでコンソールを打てる状態」

を作り、以下を実行。

```bash
dd if=/dev/zero of=/dev/「対象HDD(sda等)」 bs=512 count=1
```

# 説明

このエラーは、インストール対象HDDが、それ以前にブートがGPT方式で使用されてた際に起こります。

インストーラが対象HDDのパーティションを変更する際、従来どおりのMBR方式でインストールしたいが、「すでにGPT方式であるの
で変更できない」と言っています。

## 参考

- [MBR(マスターブートレコード)](http://ja.wikipedia.org/wiki/%E3%83%9E%E3%82%B9%E3%82%BF%E3%83%BC%E3%83%96%E3%83%BC%E3%83%88%E3%83%AC%E3%82%B3%E3%83%BC%E3%83%89)
- [GPT(GUIDパーティションテーブル)](http://ja.wikipedia.org/wiki/GUID%E3%83%91%E3%83%BC%E3%83%86%E3%82%A3%E3%82%B7%E3%83%A7%E3%83%B3%E3%83%86%E3%83%BC%E3%83%96%E3%83%AB)

従来のMBR方式も、GPT形式も「MBRを使うことは変わらない」ので、OSのインストーラはMBRの状態を検査して、上記のエラーを検出していると思われます。

なので、ddコマンドを使って「HDDのMBRを破壊」します。(入力元の /dev/zero は"0"データを吐き続ける特殊なデバイス)

※上記例ではddでMBR分ちょうど(512byte)書き込んでいますが、破壊さえできれば良いのでこれより多くても少なくても良いはずです。

破壊(bitを0埋め)できれば、インストーラによりGPT方式だと判定されなくなるので、従来どおりインストールが出来るようになります。

---

ネットを見渡すに、多くは対処として「ツールをダウンロードして…」などですが、Linuxに慣れているなら、割合簡単に回避出来ます。
