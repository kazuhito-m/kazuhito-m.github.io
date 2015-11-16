---
published: false
layout: post
title: Puppy Linux にvncserverをインストールする
category: tech
tags: [linux,puppy,vncserver,installt]
---

今度もサーバとして働かせます。
「Puppyは常時rootなんだから、そんなことしたら危険だ。自殺行為だ！」
論争は、「乗っ取られたら一緒」「あくまでLan内用」として封殺するとしますw

ニーズ的には、x11vncなので、それで。

・ここを参考に、petをダウンロード。
http://www.murga-linux.com/puppy/viewtopic.php?t=27424

・UI使ってインストール

・再起動

・メニュー→ネットワーク→x11vnc-server が現れるので、起動。

・"Ontime","Everytime"の選択肢が現れる。
単発の人は前者、俺みたいに常時起動したければ後者を選ぶ。

・ログイン用のパスワードを入力。

これだけでおしまい。あとは、好きなクライアントでアクセスすれば良い。
もっと、茨の道を想像していただけに、簡単過ぎて拍子抜けという、うれしい誤算w

最初にも書いたが、Lan内で使うにも危なっかしいほどのセキュリティなので、もう少ししたらsshポートフォワードを検討しようと思う。


