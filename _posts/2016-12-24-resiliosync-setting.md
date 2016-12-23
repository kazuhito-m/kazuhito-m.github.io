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

みたいなことを考えたり、ちょっとやってみたり、挫折してきたり…してきたのですが。





# 前提

- Ubuntu 16.10 (登場する2台ともに)
- PCの構成
  - 一台目 : インターネットに接続したルータ経由でLAN内のPC
  - 二台目 : ４GテザリングしたPC

# やったこと

## Resilio Syncのインストール


## GUI(HTML画面)を他のマシンから参照できるようにする


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
