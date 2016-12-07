---
layout: post
title: 「Basicest USB 3.0 to HDMI グラフィック変換アダプタ」をUbuntuで使う
category: tech
tags: [ubuntu,driver,install]
---

せっかく買った！ …のに「使えない！？」となって、解決したので書き残します。


# これを読んで得られるもの

- [Basicest USB 3.0 to HDMI グラフィック変換アダプタ](https://www.amazon.co.jp/Basicest-%E3%82%B0%E3%83%A9%E3%83%95%E3%82%A3%E3%83%83%E3%82%AF-%E3%82%A2%E3%83%80%E3%83%97%E3%82%BF%E3%83%BC-Displaylink-Win10%E5%AF%BE%E5%BF%9C%E3%80%90%E7%9B%B8%E6%80%A7%E4%BF%9D%E8%A8%BC%E4%BB%98%E3%81%8D%E3%80%91/dp/B015XESLTO) のUbuntuで使用可能にするやり方

# 前提

- Ubuntu 16.04 LTS

# 事象

なんとなく「挿したらいけるやろ…」と思って買って、実際やってみた…が何も写りません。

付属品にはCDがついており「Windows/MacはドライバをGUIでインストールせいや」って書いてありました。

…ので「Ubuntuでの例はないか」と探しました。

# やったこと

## 情報収集

同梱されてた紙のマニュアルにドンピシャ書いてありました。

(ただし、Ubuntu 14.04.2用と書いてありますが…。)

それとは別にぐぐって、フォーラムなどにたどり着いたのですが「 [ここ](http://support.displaylink.com/knowledgebase/articles/615714#ubuntu) にやり方載ってるよ！」と書いてありました。

同じやりかたっぽいので、上記サイトの通り作業します。

## ドライバインストール

まず、「前提となるライブラリ」をあらかじめ入れておきます。

```bash
sudo apt-get install linux-generic-lts-utopic xserver-xorg-lts-utopic libegl1-mesa-drivers-lts-utopic xserver-xorg-video-all-lts-utopic xserver-xorg-input-all-lts-utopic linux-signed-generic-lts-utopic
```


[ダウンロードサイト](http://www.displaylink.com/downloads/ubuntu) から `DisplayLink USB Graphics Software for Ubuntu 1.2.1.zip` ファイルをダウンロードします。



---

# 小並感



# 参考資料

以下を参照しました。感謝！

- [http://support.plugable.com/plugable/topics/ubuntu-usb-3-0-4k-drivers-dont-auto-start-upon-boot](http://support.plugable.com/plugable/topics/ubuntu-usb-3-0-4k-drivers-dont-auto-start-upon-boot)
- [http://www.displaylink.com/downloads/ubuntu](http://www.displaylink.com/downloads/ubuntu)
