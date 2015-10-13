---
published: false
layout: post
title: RaspberryPIで無線LAN設定
category: tech
tags: [raspberrypi,usb,linux]
---

ラズパイを「一台一仕事のサーバ」として運用していきたい三浦としては…「何処に置いても動作する」にしておきたいわけです。

ということで、RaspberryPIに無線LANを設定します。

## 使う道具

+ RaspberryPI(マーク1)
+ USB無線LANユニット - WLI-UC-GNM

## 参考にしたサイト

+ http://denshikousaku.net/raspberry-pi-wifi-lan-usb

…上のLANユニット…「力いっぱい地雷認定」されてんじゃねーかｗ

## やったこと

### ラズパイにログインして、認識してるか確認。

```bash
pi@raspberrypi ~ $ lsusb | grep -i LAN
Bus 001 Device 004: ID 0411:01a2 BUFFALO INC. (formerly MelCo., Inc.) WLI-UC-GNM Wireless LAN Adapter [Ralink RT8070]
```

### 設定を吐き出させる。

```
pi@raspberrypi ~ $ wpa_passphrase Your_SSID Your_Passphrase
network={
	ssid="Your_SSID"
	#psk="Your_Passphrase"
	psk=なんかなんか
}
pi@raspberrypi ~ 
```

### /etc の設定ファイルに付け加える。

```bash
pi@raspberrypi ~ $ sudo vim /etc/wpa_supplicant/wpa_supplicant.conf

ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
# ここから以下が追加
network={
        ssid="Your_SSID"
        #psk="Your_Passphrase"
        psk=なんかなんか
}
```

参考にしたサイトには、上記のpsk=の下に「WPA-PSKの設定」があったのだが…追加すると繋がらなかったので、ただssidとpskだけにした。

※恐らく「セキュリティ的にガバガバ」なんだろうと思うけど、本気でやりたかったら以下サイトをしらべながら設定すべし。(TODO)

[http://www.youchikurin.com/blog/2007/06/linuxlan_1.html](http://www.youchikurin.com/blog/2007/06/linuxlan_1.html)



### ネットワークカードの設定を追加。

```
pi@raspberrypi ~ $ sudo cp -a /etc/network/interfaces /etc/network/interfaces.org
pi@raspberrypi ~ $ sudo vi /etc/network/interfaces

auto lo
iface lo inet loopback

auto eth0
allow-hotplug eth0
iface eth0 inet manual

auto wlan0
allow-hotplug wlan0
# 以下、コメントアウト＆追加
# iface wlan0 inet manual
iface wlan0 inet static
address 192.168.1.32
netmask 255.255.255.0
gateway 192.168.1.1

wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf

```

### ネットワークの再起動

```bash
pi@raspberrypi ~ $ sudo service networking restart
```
あとは、無線LAN側のIPにLAN内からsshして、繋がったら有線を抜くべし。

## やってみて

+ USBの無線LANユニットが(記事の地雷指定どおり)目玉焼き焼けそうな発熱
+ セキュリティ設定が甘い(と思われる)

ので、ココらへんをTODOにして、もうちょい改善していくつもりです。