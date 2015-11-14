---
published: false
layout: post
title: Puppy Linuxへのsshd導入
category: tech
tags: [linux,puppy,sshd,install]
---

昨日インストールした、超非力PuppyLinuxマシンに、SSHサーバをインストールしていきます。

# やったこと

以下のページから、パッケージファイルをダウンロードします。(無断転載御免！)

[http://www.murga-linux.com/puppy/viewtopic.php?p=89755#89755](http://www.murga-linux.com/puppy/viewtopic.php?p=89755#89755)

ここから、Sshd-sftp.pup をダウンロードし、それをファイルブラウザからクリック起動...

しようとすると、dotpuphandlar入れろ！とか言われるので、
puppyパッケージマネージャを使って、インストール。

(俺の環境じゃ、このアプリがクソ重いw)

その後、クリック起動し、インストール。

※以下、オペレーションはすべてrootユーザ想定

```
vi /usr/etc/sshd_config
```

して、一般的なセキュリティ設定(rootダメとか)する。

(この設定をするために、前回、一般ユーザ作って、su叩けるようにbusyboxに一般で蹴れる権限つけた)


その後

```
/usr/etc/sshd.sh
```

で起動。ながーい間「キーとか作ってます」の後、UIを出して起動を通知(必要ねえw)

マシン起動時に有効にするため、

```
vi /etc/rc.d/rc.local
```

して、末尾に

/usr/sbin/sshd

を追加。

initとかxinitとか触ってきた俺にとっては「いいのかなあ？」みたいな仕込みかただなあ。

取り合えず、再起動して確認っと。

