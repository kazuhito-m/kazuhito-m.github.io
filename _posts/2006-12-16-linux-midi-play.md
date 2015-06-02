---
published: false
layout: post
title: LinuxでMIDIを再生したい
category: tech
tags: [linux,midi]
---

ながく、書くトピックがなかったが、今回MIDIの再生がしてみたくて、挑戦してみます。

## まずはレシピ

http://bbs.fedora.jp/read.php?FID=9&TID=3073

みてると、timidity++ を入れることから始まるらしい。

## インストール

```
sudo yum install timidity++.i386

```

インストールは難なく成功。

## トラブルシュート

しかし、実際にMIDIを再生してみようとすると、以下のエラーが出る。

```
/usr/bin/timidity fff.mid
esd: No such file or directory
Couldn't open Enlightened sound daemon (`e')
```

ぐぐると、以下の情報が

```
「ここでesdを起動すれば再生はできるようになるのだが、ぶつぶつと音が切れてしまい、最終的には音がでなくなってしまう。 timidityはalsaに出力を送る事もできるので、Fedoraではalsaに出力をする-Osオプションをつけると良い。

timidity -Os ファイル名

という具合である。毎回-Osオプションをつけるのはめんどくさいので、aliasを設定してしまうのがいいかもしれない。」
```

とのことなので、/etc/bashrc に、以下のエイリアスを切った。

```
alias timidity='timidity -Os'
```

これで、めでたくMIDIが再生できるようになった。

ついでに、firefoxでMidiがおいてあるページで再生できていなかったのも解決する。

```
sudo yum install mozplugger
```

これをインストールするだけで、なんかなるようになった。

---

しかし…画面上にデカデカと再生マークが表示されるのは、ダサいなあw
