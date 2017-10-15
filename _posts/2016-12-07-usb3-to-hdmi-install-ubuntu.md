---
layout: post
title: 「Basicest USB 3.0 to HDMI グラフィック変換アダプタ」をUbuntuで使う
category: tech
tags: [ubuntu,driver,install]
---

![Basicest USB 3.0 to HDMI グラフィック変換アダプタ](/images/2016-12-07-overview.png)

せっかく買った！ …のに「使えない！？」となって、早とちりだったので書き残します。

# これを読んで得られるもの

- [Basicest USB 3.0 to HDMI グラフィック変換アダプタ](https://www.amazon.co.jp/Basicest-%E3%82%B0%E3%83%A9%E3%83%95%E3%82%A3%E3%83%83%E3%82%AF-%E3%82%A2%E3%83%80%E3%83%97%E3%82%BF%E3%83%BC-Displaylink-Win10%E5%AF%BE%E5%BF%9C%E3%80%90%E7%9B%B8%E6%80%A7%E4%BF%9D%E8%A8%BC%E4%BB%98%E3%81%8D%E3%80%91/dp/B015XESLTO) のUbuntuで使用可能にするやり方

# 前提

- Ubuntu 16.04 LTS(64bit)
- ハードウェア
  - プロセッサ: Intel® Core™ i7 CPU 920 @ 2.67GHz × 8
  - グラフィック: Gallium 0.4 on AMD CAICOS (DRM 2.43.0, LLVM 3.8.0)

# 事象

なんとなく「挿したらいけるやろ…」と思って買って、実際やってみた…が何も写りません。

付属品にはCDがついており「ドライバをGUIでインストールせいや」って書いてありました。

…ので「Ubuntuでのやり方」と確認しました。

# やったこと

## 情報収集

ちょっと焦ったのですが…同梱されてた紙のマニュアルにドンピシャ書いてありました。

(ただし、Ubuntu 14.04.2用と書いてありますが…。)

それとは別にぐぐって、フォーラムなどにたどり着いたのですが「 [ここ](http://support.displaylink.com/knowledgebase/articles/615714#ubuntu) にやり方載ってるよ！」と書いてありました。

同じやりかたっぽいので、上記サイトの通り作業します。

## ドライバインストール

まず、「前提となるライブラリ」をあらかじめ入れておきます。

```bash
sudo apt-get install linux-generic-lts-utopic xserver-xorg-lts-utopic libegl1-mesa-drivers-lts-utopic xserver-xorg-video-all-lts-utopic xserver-xorg-input-all-lts-utopic linux-signed-generic-lts-utopic
```

[ダウンロードサイト](http://www.displaylink.com/downloads/ubuntu) から `DisplayLink USB Graphics Software for Ubuntu 1.2.1.zip` ファイルをダウンロードします。

解凍すると、ライセンスファイルと `displaylink-driver-1.2.65.run` というファイルが出てくるので、これを実行します。

```bash
chmod 755 ./displaylink-driver-1.2.65.run
sudo ./displaylink-driver-1.2.65.run

(sudoのパスワード入力)

Verifying archive integrity... All good.
Uncompressing DisplayLink Linux Driver 1.2.65  100%  
DisplayLink Linux Software 1.2.65 install script called: install
Distribution discovered: Ubuntu 16.04.1 LTS
Installing
Configuring EVDI DKMS module
Registering EVDI kernel module with DKMS
Building EVDI kernel module with DKMS
Installing EVDI kernel module to kernel tree
EVDI kernel module built successfully
Installing x64-ubuntu-1604/DisplayLinkManager
Installing libraries
Installing firmware packages
Installing license file
Adding udev rule for DisplayLink DL-3xxx/5xxx devices
```

ん？ サイトの通りじゃなくて「GUIも何も出ず"Adding...devices"と出て終わった」ぞ？

大丈夫ですかね…。

## USB挿し直し

変化が無かったので、挿し直しました。

![OK](/images/2016-12-07-display-ok.png)

やった！写った！

## その後

まぁ、致命的な問題はないのですが、以下の変化がありました。(念のため再起動後です)

- ドライバ認識＆挿し直し直後に「ディスプレイの設定がデフォルトに戻る」（設定しなおせば大丈夫です）
- メインディスプレイで「マウスカーソルが細かく明滅する」ようになる

上記以外： この変換ケーブルを用いる前に「グラボのHDMI端子で運用」していたのですが、ソレと比べても遅延などもなく、目立つものはありません。

---

# 小並感

職場やノートパソコンで「旧機の"余剰ディスプレイ"はいっぱい在るのに…刺すとこ無い！」というシチュエーションに多く出くわすので

_変換ケーブルの種類揃えてあらゆるところに刺す_

という変な努力を今まで割としていたのですよね…。

![いろんな端子toRGB/HDMI](/images/2016-12-07-converters.png)

でも、「USBからディスプレイ系変換アダプタ」の存在を知ってからは「大部分のものがこれでカバー出来る」と思い、それ買っています。

(その代わり、単純電気的変換でなくなってドライバと相性問題も出てくるのですが…。)

今回買った「USB to HDMI」も「出先のポート不足」に一役買って重宝しそうです。

…金ドブにならなくてよかった…。(ほっ

# 参考資料

以下を参照しました。感謝！

- [http://support.plugable.com/plugable/topics/ubuntu-usb-3-0-4k-drivers-dont-auto-start-upon-boot](http://support.plugable.com/plugable/topics/ubuntu-usb-3-0-4k-drivers-dont-auto-start-upon-boot)
- [http://www.displaylink.com/downloads/ubuntu](http://www.displaylink.com/downloads/ubuntu)
