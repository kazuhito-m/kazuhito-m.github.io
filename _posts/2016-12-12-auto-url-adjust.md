---
published: false
layout: post
title: SpringBootで「どこにデプロイされてもcontext-pathを自動的に調整する」Webアプリを作る
category: tech
tags: [java,springboot,web,ci]
---

地味だけど…わりかし「こうなってたら便利だなー」を昔から思ってるモノを実現します。

# これを読んで得られるもの

- SpringBootで「どこにデプロイされてもcontext-pathを自動的に調整する」機能
  - その実装方法

# 経緯


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

- [http://huruyosi.hatenablog.com/entry/springboot%E3%81%A7context_path](http://huruyosi.hatenablog.com/entry/springboot%E3%81%A7context_path)
- [http://qiita.com/NewGyu/items/d51f527c7199b746c6b6](http://qiita.com/NewGyu/items/d51f527c7199b746c6b6)
