---
layout: post
title: ヤケになって…
category: tech
tags: [linux,fedora,install]
---

結局、テレビも見れるようになっていないし、なんせうまくいかないので、
イヤケがさして、Fedora6を入れることにしました。

インストールはレスキューCDにより、rikenさんからネットワークインストールを試みます。

## やったこと

- yumで全パッケージ最新に。
- ディスプレイ設定で、ディスプレイを選びなおし、800＊600からもっといけるように。
- AthronのCPUソフトウェアクーラをONする。
- Thunderbirdインストール
- 前の設定から、有用なものをインポート(特にブラウザとメール)
  - 旧ディレクトリをTARでかためて持ってきた。.mozila, .thunderbird , .gaim , .ssh , .scim
をコピー
- NTPの設定
  - Fedoraのデフォルトだったが、ntp02.zaq.ne.jpへ変更

## 作業

列挙します。

- 前のディスクをマウント
  - 難易度たかし。LVMを勉強する必要あり
- Fontを入れる
- xmms,mp3のモジュールともに入れる
- mplayer入れる

## 今後の計画

- キャプチャカードを有効にする
- ええディスプレイ買って、いい感じにする
