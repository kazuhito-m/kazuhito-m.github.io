---
published: false
layout: post
title: CentOS5.6でDRBD(ディスク冗長構成)を作る
category: tech
tags: [Linux,CentOS,DRBD,reprication]
---

俺は「冗長構成」とか「レプリケーション」とかは、「死ぬとき死ぬ」と思ってるので、あまり力を入れていないのですが…。

今回、必要があり「DRBD」というプロダクトを試し「他のマシンのディスクを絶えず同期し続ける」という構成を試したので、
自身の備忘録として記しておきます。

# 環境作成

## 下準備

以下を満たしていること

- CentOS5.6をインストール済みの二台があること(仮想でも可能)
- yum がインターネットに出れる(proxyあるならしこんでる)
- コンソールにhttp_proxy,httpd_proxyが仕込んであること

## CentOSにDRBDをインストール


```bash
sudo rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
sudo rpm -Uvh http://www.elrepo.org/elrepo-release-6-6.el6.elrepo.noarch.rpm
sudo yum install -y drbd84-utils kmod-drbd84
```

```bash
sudo cp -a /etc/drbd.d/global_common.conf /etc/drbd.d/global_common.conf.org
sudo vi /etc/drbd.d/global_common.conf
```

ファイルの内容

```
global {
        usage-count no;
}

common {
        handlers {

        }

        startup {
        }

        options {
        }

        disk {
                resync-rate 50M;
        }

        net {
                protocol C;
                csums-alg sha1;
                verify-alg sha1;
        }
}
```

BRBD側の設定ファイル設定・

```bash
sudo vi /etc/drbd.d/r0.res
```

ファイルの内容

```
resource r0 {
        meta-disk internal;
        device /dev/drbd0;
        disk /dev/xvdf;

        on ip-10-147-201-209.ap-northeast-1.compute.internal {
                address 10.147.201.209:7788;
        }
        on ip-10-147-201-208.ap-northeast-1.compute.internal {
                address 10.147.201.208:7788;
        }
}
```

BRBDデバイス作成。


```bash
sudo drbdadm create-md r0

# -- 以下結果 --
initializing activity log
NOT initializing bitmap
Writing meta data...
New drbd meta data block successfully created.

```

ここまでの作業を両サーバで行う。

## 起動

以下を、両サーバで叩く。

```bash
drbdadm up r0
cat /proc/drbd #確認
```

## 初期動機

二つのサーバを仮に1号機、2号機とし

+ 1号機 - 同期する側
+ 2号機 - 同期される側(仮想ディスクは削除されちゃう)

とする。

2号機で以下を実行。

```bash
sudo drbdadm invalidate r0
# 以下でプログレス風に見える
watch cat /proc/drbd
```

## 昇格

以下を1号機で実行。

```bash
sudo drbdadm primary r0
```

## BRDBディスクを使う

この後は /dev/drbd0 がただのディスクになる。

ふっつーに使ってみる。

1号機で実行

```bash
sudo mkfs.ext4 /dev/drbd0
sudo drbdadm primary r0
sudo mkfs.ext4 /dev/drbd0
# マウントして確認
cd /mnt
sudo mkdir drbd0_test
sudo mount -t ext4 /dev/drbd0 ./drbd0_test/
sudo chmod 777 drbd0_test/
cd ./drbd0_test
echo 'これはテストのためのファイルです。' > test.txt
```

2号機に行って、同じようにテスト。

```bash
cd /mnt
sudo mkdir drbd0_test
sudo mount -t ext4 /dev/drbd0 ./drbd0_test/
# リードオンリーなので書き込みでけへんと怒られる
```

(今知ったが)セカンダリになるものは「マウントすらもできないディスク」になるよう。

つまり「書き込まれてるデータをセカンダリ側からは覗けない」ということである。

無論、1号機をプライマリからセカンダリに降格、セカンダリ＆セカンダリになったとこから2号機をプライマリ昇格すれば見れる。



# 参考サイト

- [yumインストール自体(ハッシュがないからあきらめた)](http://packages.linbit.com/rhel_repo.html)
- [yumインストール(若干古い)](http://qiita.com/takehironet/items/c90cd89fb621e570571f)
- [DRBDのみの設定の話](http://qiita.com/takehironet/items/13518725ee7c694efe90)
