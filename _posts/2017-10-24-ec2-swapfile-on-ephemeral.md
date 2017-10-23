---
layout: post
title: EC2インスタンスの起動時にEphemeral DiskへSwapファイルを設定・有効化する
category: tech
published: true
tags: [aws,ec2,linux,swap,tips,ansible]
---

完全に備忘録なTipsですな。自分用。

# 経緯

AWS EC2の `Ephemeral Disk（揮発性ディスク）` はイマイチ使い方をあぐねています。

「インスタンス種によっては付いてくる」ので、知らないで立てた->後で気付いた、という状況で、最初から企画してたわけじゃない数GBのドライブが手に入る…からスタートしまして。

ちょうど「EC2インスタンスを同構成で立て直す」という期会があったので、その際に設定しmountしてみた…ものの「アプリごとのキャッシュファイルやフォルダここへ設定」した程度で、そんなに活用できていない…。

今回、「アプリがメモリ不足で突然死する」ようになったので、Swapを設定しようと思いました。

LinuxのSwapの設定方法は

- パーティションをまるごと
- 特定の固定容量のファイルを `mkswap` でスワップファイル加工

を

- `/etc/fstab` などでswap指定mount

という方法がありますが、「パーティション運用」は「もうすでにEphemeral Diskにファイルを置く設定(前述のアプリごとのキャッシュ)」なのでできない…。

なので「スワップファイル運用」をしたいのですが「再起動時にEphemeral Diskはクリアされる」ので、マウント時にファイルがない状態…になるはず。

そこで「起動時に作って、置いて、有効化」という設定をしてみました。

# やったこと

## 前提

以下のものを前提とします

- EC2インスタンスはRedhat系Linuxディストリビューション(AmazonLinux,CentOS含む)
- `Ephemeral Disk` は4GBで、インスタンス生成時に `/ephemeral` にマウント
- 作業用端末には予め `Ansible` がインストールしてあり、EC2には鍵等でログイン出来る

## やることの要約(仕様)

起動時にシステム全体でのスタートアップをに仕込むには、 `/etc/rc.d/rc.local` に処理をbashで書くことが確実かつ一般的です。

ただ「自身で足したスクリプトがとっちらかる」「責務がわからなくなる」ので、 `startup.sh` のようなスクリプトを蹴り、そこで処理をすることにします。

`Ansible` のplaybookでAsCodeすることとし、以下の構成とします。

```
├ main.yml      # 操作をするAnsiblePlaybook
├ hosts         # 対象サーバのhost名orIPを記載したファイル(Ansible参照)
└ resources
  └ startup.sh  # 実際の操作をするスクリプト
```

## main.yml でやること

以下のような内容にしてみました。

```yaml
# coding:utf-8
- hosts: all
  tasks:
    - name: add line on /etc/rc.local
      lineinfile: >
        dest=/etc/rc.d/rc.local
        line='/var/local/startup/startup.sh >> /var/log/startup_scripts.log 2>&1'
    - name: make directory for startup
      file: path=/var/local/startup/ state=directory owner=root group=root mode=777
    - name: deploy startup script
      copy:
        src: ./resources/startup.sh
        dest: /var/local/startup/startup.sh
        owner: root
        group: root
        mode: 0755
```

`/etc/rc.local` ファイルの末尾に、`/var/local/startup/startup.sh` を実行しログに吐く、という一行を追加しています。(冪等考慮で二度目以降は書き込みません)

それ以降は、 `/var/local/startup/startup.sh` を配置するためのディレクトリ作成・ファイル転送を行っています。

対象サーバへのログインが、一般ユーザ前提(AmazonLinux等)なら、ファイル初めの `hosts` 表記を以下に変更してください。

```yaml
- hosts: all
  sudo: yes
```

## startup.sh でやること

実際に「マシン(再)起動時に実行されるスクリプト」である `startup.sh` の処理はこんな感じです。

```bash
#!/bin/bash
echo "execute date:`date`"
# Swapfileを作成＆有効化(swapon)
SWAP_FILE=/ephemeral/swapfile
rm -f ${SWAP_FILE}
dd if=/dev/zero of=${SWAP_FILE} bs=1024K count=3700
mkswap ${SWAP_FILE}
swapon ${SWAP_FILE}
```

作る先が `Ephemeral Disk(/ephemeral)` である以外は、よく在る「Swapファイル作成＆有効化」のスクリプトです。

他の「キャッシュ系」のファイル/ディレクトリを考慮して「ちょっと少なめ(3700MB)」にしてあります。

## Ansilbeでのプロビジョニング実行 & 再起動

Ansibleがインストールされてることを前提に、以下の感じで実行します。

```bash
ansible-playbook --private-key=XXX.pem -i hosts -u ユーザ名 main.yml
```

その後、`shutdonw -r now` か「EC2のコンソール操作」で再起動します。

再起動の直後、ログインし、

```bash
watch 'df -h /ephemeral && swapon -s'
```

を打つなどして「徐々に容量が増え、最後Swapが有効になる」のが確認できればOKです。

![増えて最後に有効になる様子](/images/2017-10-24-make-and-on-swapfile.gif)

# 所感

「揮発性ディスク」と言う名前から「RAMディスクみたいなものである程度早いIOなんじゃ…」と期待したのですが、上の画像を見る感じでは、そんなに早く無いご様子。

本来、「インスタンスは使用用途により選び、特性は予め把握しているもの」であるべきなので、今回の自分は「特殊な例(好例でもなさそう)」なのですが、まニッチ過ぎて忘れそうなので、記事にしました。

# 参考

以下のURLを参考にさせていただきました。感謝。

- <http://tipspc.blogspot.jp/2008/09/linux.html>
- <https://qiita.com/wmx/items/631222f2e5a9e7a59fb4>
- <http://kazmax.zpp.jp/linux_beginner/mkswap.html>
- <https://qiita.com/hit/items/3d5419fe56d0d123cb95>
