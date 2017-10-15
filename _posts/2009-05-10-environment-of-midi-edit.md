---
layout: post
title: MIDI編集環境の作成
category: tech
tags: [dtm,linux,midi]
---

Midiを編集する環境、ソフトウェアで鳴らす環境を設定します。

# やったこと

具体的にはtimidityをソフトウェアシンセにして鳴らして、Rosegardernを編集アプリに使うこととします。

ほぼ、こちらが答え合わせ : [https://forums.ubuntulinux.jp/viewtopic.php?id=2869](https://forums.ubuntulinux.jp/viewtopic.php?id=2869)

## timidityインストール

```bash
sudo apt-get install timidity
sudo apt-get install timidity-interfaces-extra
```

ついでにFirefoxで再生されるようにしとこう。

```
sudo apt-get mozplugger
```

付属のサウンドフォント(sudo apt-get)が気に入らないので、なんか一般的でかつaptだけで入れられる奴に変えます。

```bash
sudo apt-get install fluid-soundfont-*
```

これで、fluid-soundfont-gm、fluid-soundfont-gs が入ります。

timidity++側に読ませるには、timidity.cfg を編集します。

```bash
sudo vi /etc/timidity/timidity.cfg
```

以下を末尾に追加。

```bash
soundfont /usr/share/sounds/sf2/FluidR3_GM.sf2 order=0
soundfont /usr/share/sounds/sf2/FluidR3_GS.sf2 order=0
```

## rosegardenインストール

```bash
sudo apt-get install rosegarden
```

`jack` が必要なんですが、以前 `Ardour` を入れた際にサーバが動く環境を手に入れているので割愛。
