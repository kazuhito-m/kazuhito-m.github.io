---
published: false
layout: post
title: Resilio Syncをインストール＆他マシンからGUI見れる設定変更
category: tech
tags: [resilio,p2p,fileshare]
---

Resilio Sync(旧BitTorrent Sync)について、いろいろと試行錯誤しつつ使えるようにしてみた…ので、書いてみます。

# これを読んで得られるもの

- ResilioSyncのUbuntuへのインストール方法
  - ResilioSyncの2つのインストール法
- GUI(設定が行える内蔵HTTPサーバ)を自端末だけじゃなく他の端末からも閲覧可能にする設定


# 経緯

以前から、手段はいろいろ考えながら漠然と…

<blockquote class="twitter-tweet" data-lang="ja"><p lang="ja" dir="ltr"><a href="https://twitter.com/iso2022jp">@iso2022jp</a> ですよねｗ そうかウチん家の内情を知っての発言でしたか…深けぇ。現在、Samba(Lan内）、SSL-WebDav、NFS(v4 &amp; Kerbelos &amp; LDAP)、etc... の&quot;全方位ファイルサーバ&quot;を企画中。…完成何時になるやらｗ</p>&mdash; 三浦一仁(本読めるようになりたい) (@kazuhito_m) <a href="https://twitter.com/kazuhito_m/status/65901469601239040">2011年5月4日</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

みたいなことを考えたり、ちょっとやってみたり、挫折してきたり…してきたのです。

結局、要件としては

- 自宅Lan内なら「NFS/Sambaサーバ」なりで「(高速に)ファイルを参照」できる
- 外からは「認証付きSSL-Webdav」なりで「同じ原資(ファイル)だが、全部orチョイスして取得」できる

みたいなことが望みだったりします。

上記とは関係なく、「Dropboxが上限を迎えた」ので、

__ファイルサーバにプラスして"上限のないDropboxっぽいこと"ができないか__

を考え始めました。

---

「実現する道具」として検討したのは

1. ownCloud : 老舗のDropboxクローン
0. Resilio Sync : P2P型のフォルダ同期ツール

です。

やりたいことをそのものでいけば`ownCloud`なのですが、「ファイルシステムを原資としてNAS的に直参照もしたい」と考えると、

- `ownCloud`のデータ保持はファイルシステムだが「ファイルのメタ情報」はDB
  - ファイルシステム側にファイル足すだけでは`ownCloud`でのファイル公開にならない
- 上記の事情で「ファイルサーバ側で両方満たす」とすると「内部で`ownCloud`と共有したディレクトリ」など作る必要がありそう
  - 素直にやると「ファイル容量が２倍」必要

となりそうなので、`Resilio Sync`を試すことにしました。

# 前提

- Ubuntu 16.10 (登場する2台ともに)
- PCの構成
  - 一台目 : ルータ経由でインターネットに接続したLAN内のPC
  - 二台目 : ４GテザリングしたPC

# やったこと

「ファイルサーバ運用」の話は後に考えるとして、とりあえず「どんなものか」を評価するため、インストールしてみて、他端末と共有するとこまでやってみます。

## Resilio Syncのインストール

上記「一台目」に、[本家のブログに書いてあったやり方](https://www.resilio.com/blog/official-linux-packages-for-sync-now-available)でインストールしてみます。

```bash
wget -qO - https://linux-packages.resilio.com/resilio-sync/key.asc | sudo apt-key add -
sudo sh -c  "echo 'deb http://linux-packages.resilio.com/resilio-sync/deb resilio-sync non-free' > /etc/apt/sources.list.d/resilio-sync.list"
sudo apt-get -y update
sudo apt-get install -y resilio-sync
sudo systemctl enable resilio-sync
# メインユーザを'rslsync'グループに入れる
sudo gpasswd -a ＄{USER} rslsync
```

最後の `gpasswd` は

- resilio-syncはデーモンとして、ユーザ：`rslsync`で動いている
- resilio-syncがSyncして作られたファイルは、パーミション `664` で作られる

ため、「メインとなるユーザでも更新できるように」グループを追加しています。

### GUIから初期設定を行う


## GUI(HTML画面)を他のマシンから参照できるようにする

インストール後、 [http://127.0.0.1:8888/](http://127.0.0.1:8888/) を表示すると「初期ユーザ登録画面」になります。

「このマシンのresilio-syncだけで使うユーザ」なので、覚えやすい名前を適当につけます。



---

# 小並感


# 参考URL

以下を参考にさせていただきました。感謝。

- [https://wiki.archlinuxjp.org/index.php/Resilio_Sync](https://wiki.archlinuxjp.org/index.php/Resilio_Sync)
- [（本家）https://www.resilio.com/](https://www.resilio.com/)
  - [https://www.resilio.com/blog/official-linux-packages-for-sync-now-available](https://www.resilio.com/blog/official-linux-packages-for-sync-now-available)
- []()
- []()
- []()
- []()
