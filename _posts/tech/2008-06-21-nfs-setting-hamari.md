---
layout: post
title: NFS設定でなにげにずるずるハマる
category: tech
tags: [linux,fedora9,nfs]
---

サブマシン側がメインマシンのファイルをまったく見えない状況では、なーんにも作業ができないので、nfsを設定します。

※特に指定しなければ、以下rootでの作業

## やること

### サーバ側

まず、サーバON(サーバはデフォルトで入ってた)

```bash
chkconfig --level 35 nfs on
service nfs start
```

[/etc/exports]の編集。home以下は全晒しでいっかー

```bash
vi /etc/exports

/home 192.168.1.0/255.255.255.0(rw)
```

※Lan内マシンのすべてに大公開

```bash
service nfs restart
```

`/etc/hosts.allow, hosts.deny` を気にする。

※自身の設定は無問題でした。

`iptables` を気にする。

ファイアーウォールに穴をあける必要があります。

`/etc/sysconfig/iptables` に以下を追加。(左端のルール名は人によって違います)

```bash
-A RH-Firewall-1-INPUT -m state --state NEW -m tcp -p tcp --dport 2049 -j ACCEPT
-A RH-Firewall-1-INPUT -m state --state NEW -m udp -p udp --dport 2049 -j ACCEPT
```

```bash
service iptables restart
```

### クライアント側

ここからは、クライアント側の設定。まず、mountしてテスト

```bash
mount -t nfs 192.168.0.110:/home/ ./hoggeeee]

mount.nfs: internal error
```

あれ？おかしい。ポートが開いているかをテスト。(よゐこはnmapとか多用しちゃだめよ♪)

```bash
nmap -v -sT 192.168.1.110 -p 2049

PORT STATE SERVICE
2049/tcp open nfs
nmap -v -sT 192.168.1.110 -p 111
PORT STATE SERVICE
111/tcp open rpcbind
```

うーん、開いている。クライアントから詳細情報をだして、mountコマンドを発行してみる。

```bash
mount -v -t nfs 192.168.1.130:/home ./fugeeeee/

mount.nfs: trying 192.168.1.130 prog 100003 vers 3 prot TCP port 2049
mount.nfs: trying 192.168.1.130 prog 100005 vers 3 prot UDP port 44408
mount.nfs: mount to NFS server '192.168.24.130' failed: timed out, retrying
```

何？ポート44408？調べてもそんなウェルノンポートないし…

と思ったら、ここに回答。

[http://rewse.jp/fukugan/article.php?id=934](http://rewse.jp/fukugan/article.php?id=934)

nfsは不定のポートを使う仕様らしい。設定ファイルを変更し、固定にする。

```bash
vi /etc/sysconfig/nfs

STATD_PORT=11081
STATD_OUTGOING_PORT=11082
MOUNTD_PORT=11083
LOCKD_TCPPORT=11084
LOCKD_UDPPORT=11085
RQUOTAD=no
```

※なんかどこぞのウェルノンとかぶっている気もするけどキニシナイw

最終的に、 `/etc/sysconfig/iptables` はこんな感じに。

```bash
-A RH-Firewall-1-INPUT -m state --state NEW -m tcp -p tcp --dport 2049 -j ACCEPT
-A RH-Firewall-1-INPUT -m state --state NEW -m udp -p udp --dport 2049 -j ACCEPT
-A RH-Firewall-1-INPUT -m state --state NEW -m tcp -p tcp --dport 11000:11099 -j ACCEPT
-A RH-Firewall-1-INPUT -m state --state NEW -m udp -p udp --dport 11000:11099 -j ACCEPT
-A RH-Firewall-1-INPUT -m state --state NEW -m tcp -p tcp --dport 111 -j ACCEPT
-A RH-Firewall-1-INPUT -m state --state NEW -m udp -p udp --dport 111 -j ACCEPT
```

mount でテスト

```bash
mount -v -t nfs 192.168.1.110:/home ./user_name_home/

mount.nfs: timeout set for Sun Jun 22 16:36:01 2008
mount.nfs: text-based options: 'addr=192.168.1.110'
192.168.1.110:/home on /media/user_name_home type nfs (rw)
```

はぁ、やっとだw　疲れた…

起動時に接続するように。fstab設定。

```bash
vi /etc/fstab

192.168.1.110:/home /media/user_name_home nfs soft,intr 0 0
```

再起動後、期待どおりの接続に♪やた。
