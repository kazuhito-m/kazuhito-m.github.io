---
published: false
layout: post
title: landiskが起動しなくなった
category: tech
tags: [linux,boot,usb]
---

今まで作業記録してきたが、何らかの作業の途中に、ランプが点滅し続ける状態になって、その後作業を続けていくと、telnetもsshも受け付けなくなった。
おまけに、HDDがとんでもない高温に。

記憶が曖昧だが、rebootというコマンドを見つけ出して、それを実行してからおかしくなったと思う。

急遽、作業前(Hack初め)に戻す。

その時とってたバックアップがあったので、それ使う。

以前の取り方は

dd if=/dev/hdc of=./mba.img bs=512 count=63
dd if=/dev/hdc1 of=./hd1.img bs=1M

だったので、逆をかます。

dd if=./mba.img of=/dev/hdc bs=512 count=63
dd if=./hd1.img of=/dev/hdc1 bs=1M

半信半疑だったが…ランプが…正常起動成功！
いやあ、バックアップ重要！コピーで戻る組み込みLinux最高w

さて、もう一度telnetの仕込みからだなw
