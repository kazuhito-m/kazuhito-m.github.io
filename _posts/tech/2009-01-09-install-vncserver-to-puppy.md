---
layout: post
title: Puppy Linux にvncserverをインストールする
category: tech
tags: [linux,puppy,vncserver,installt]
---

順次作成していってるPuppyサーバですが、今度もサーバソフトを入れてサーバとして働かせます。

「Puppyは常時rootなんだから、そんなことしたら危険だ。自殺行為だ！」

論争は、「乗っ取られたら一緒」「あくまでLan内用」として封殺するとしますw

# やったこと

ニーズ的には、x11vncなので、それで。

ここを参考に、petをダウンロード。

[http://www.murga-linux.com/puppy/viewtopic.php?t=27424](http://www.murga-linux.com/puppy/viewtopic.php?t=27424)

1. UI使ってインストール
0. 再起動
0. メニュー→ネットワーク→x11vnc-server が現れるので、起動。
0. "Ontime","Everytime"の選択肢が現れる。
  - 単発の人は前者、俺みたいに常時起動したければ後者を選ぶ。
0. ログイン用のパスワードを入力。

これだけでおしまい。あとは、好きなクライアントでアクセスすれば良いです。

---

もっと、茨の道を想像していただけに、簡単過ぎて拍子抜けという、うれしい誤算でした。

最初にも書きましたが、Lan内で使うにも危なっかしいほどのセキュリティなので、もう少ししたらsshポートフォワードを検討しようと思います。
