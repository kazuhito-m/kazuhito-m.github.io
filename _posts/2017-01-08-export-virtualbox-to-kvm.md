---
layout: post
title: VirtualBoxからKVMへと仮想イメージ移行した話
category: tech
tags: [ubuntu,virtualbox,kvm,qemu]
---

ま、題名は詐欺っぽくて「ワンライナー書いて移行一瞬だった」ってことが言いたかっただけなんですけどね。

# これを読んで得られるもの

- VirtualBox、KVMのインストール法(AsCodeしたもの)
- qemuのコマンドを使用した「仮想イメージの一括コンバート」方法

# 前提

- Ubuntu 16.04
  - linux 4.4.0-57-generic(kvmはカーネルに含まれている)
- VirtualBox 5.0.24_Ubuntu r108355

# 経緯

基本的に「__世界にはLinuxしか存在しない__」はずなので、「環境が用意したい」となれば、Dockerを用意すれば良いし、困ってないのです。

ただ「異界の異形の勢力」であるWindowsなどが絡んでくると、どうしても「(ソフトウェアレベル以上の)プラットフォーム仮想化」を使わざるを得ません。

とはいえ、迷うことはなく

- KVM : Linuxネイティブで行くならカーネルの一部である「これ一択」、ただ「一手間」ある
- VirtualBox : aptコマンド一発、簡易に使いたいならこれ(Oracleにアレルギーがなければ)

程度だと考えています(そない選択肢も無いですからね)。

で、時間なくて手を抜いてある端末にVirtualBoxなぞ使ってしまったのですが「WindowsサーバがVirtualBoxで動かなかった」というトラブルに見舞われてしまい…。

KVMを使い始めようと思ったのですが…「思ったより仮想イメージを多く作ってた」ので、「コンバートして全引っ越しできないか」をやってみました。

# やったこと

## VirtualBox、KVMのインストール

両方「以前からインストールしてた」ので、基本ここの解説はありません。

が、`VirtualBox`、`KVM`ともに[こちら](https://github.com/kazuhito-m/dockers/blob/master/scripts/fabric_ubuntu_standard/fabfile.py)にAsCodeしてあるので、いつでも再現できます。 ( 'insatll_virtualbox()' 、 'install_kvm()' という関数がそれです)

ただKVMについては、基本「インストール後は仮想マシンは外に公開できない(Host⇔Guestだけで外からGuestを見れない）ので、ブリッジ接続用意しなければ使い物になりませんので、

1. NetworkManager排除する
0. ブリッジ接続作る

作業が要ります。

```bash
sudo apt-get remove -y network-manager
```

```bash
sudo vi /etc/network/interfaces

# 以下を追加
auto ${マシン固有IF名}
iface ${マシン固有IF名} inet manual

auto br0
iface br0 inet static
address ${固定したい自宅ネットのIP}
network 192.168.1.0
netmask 255.255.255.0
broadcast 192.168.1.255
gateway 192.168.1.1
bridge_stp off
bridge_ports ${マシン固有IF名}
```

最近は「ネットワークカードのデバイス命名則が変わっている」ので、`eth0`とか例に書けないですねｗ

### よくわからないバグっぽいの

`/etc/network/interfaces` を編集し、 `sudo systemctl restart networking` などして、試行錯誤してる時にどうしても`ifup`のところで、かならずエラーとなるため、`ifup` 単体で叩いたところ、

```bash
sudo /sbin/ifup -a --read-environment -v
...
Failed to bring up br0.
...
run-parts: /etc/network/if-up.d/ubuntu-fan exited with return code 1
...
```

となり、さらに `/etc/network/if-up.d/ubuntu-fan` を見てみると、どうやら `/usr/sbin/fanctl` が存在しない様子…。

なので、このファイルが含まれるパッケージをインストールしたところ、このエラーは出なくなりました。

```bash
sudo apt-get install ubuntu-fan
```

必須なら依存性で解決しておいて欲しいですけど…バグって言っちゃうといちゃもんかなー？

## VirtualBox製のイメージをKVM用のに変換

VirtualBoxとKVMの(デフォルトで作った)イメージの違いは、

- `VirtualBox`イメージのファイル
  - `~/VirtualBox VMs/[環境名]` に保存される
  - `[環境名].vbox`,`[環境名].vbox-prev`な設定ファイル と `[環境名].vdi` なHDDイメージファイルで構成される
    - HDDイメージは`vdix`,`hdd`など「作成時に選んだ形式」で保存される
- `kvm`イメージのファイル
  - `/var/lib/libvirt/images` に保存される
  - `[環境名].qcow2` のファイル一つに保存される
  - デフォルトは `qcow2` 形式だが選択可（それにより拡張子変わる)

で、変換すべきは「ハードディスクの中身」である「HDDイメージファイル」です。それが変換したい。

でも、おあつらえ向きに `qemu-utils`をインストールした時に入る`qemu-img`コマンドが「世の大体の仮想HDDイメージファイルに対応している」ので、これを使わせてもらいます。

```bash
for i in $(ls ~/VirtualBox\ VMs/*/*.vdi)
do
  sudo qemu-img convert -O qcow2 $i /var/lib/libvirt/images/`basename ${i%.*}`.qcow2
done
```

`qemu-img convert` サブコマンドに「出力形式に`qcow2`」を指定して出力しています。

`-f [format]` オプションで、入力ファイルの形式を指定できますが、指定しなくば「自動判別」なので、上記ではそうしました。(実際には`*.hdd`なファイルも混ざっていたりしましたが、未指定で変換できました)

## GUIにて設定＆起動実験

HDDイメージファイルは変換できましたが、VMの設定(`*.vbox`の情報)は入ってないため、そこは設定しなければいけません。

`virt-manager` を実行し「Virtual Machine Manager」を起動します。

左上の「新しい仮想マシンの作成」ボタンをクリックします。

![選択画面](/images/2017-01-08-makemachine.png)

開いた「新しい仮想マシン」画面で、`既存のディスクイメージをインポート`を選び、進みます。

![](/images/2017-01-08-imageselect.png)

「既存のストレージのパスを指定してください」に先ほど変換した`*.qcow2`のファイルを指定します。

あとは、画面にしたがい環境を設定し完了まで行きます。

起動画面が開いたら、起動->シャットダウンまで行って「そのイメージが動くこと」を確認します。

---

この手順を元のイメージ一つに対しこの作業が必要なので、ここは面倒くさいのですが、「マシンの設定を見なおそう」と思ってたので、あえてやりました。

CLIで作成もできるようなので、本気をだせば`*vbox`ファイル（XMLですしね）を解析して、変換・登録もできそうです。

# 小並感

qemuの解説などを眺めることも多かったので「出来るっぽい」くらいのことはうっすらわかっていても「やらないとわからない」もので。

今回は備忘録ですが、これにより「わりとカジュアルに仮想化プラットフォームを行き来できる」とわかったので、いろいろ試すハードルが下がったかなと。
