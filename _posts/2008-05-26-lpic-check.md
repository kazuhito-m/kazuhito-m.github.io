---
layout: post
title: LPIの出題範囲から学ぶ「俺の弱いカテゴリ」
category: tech
tags: [linux,lpic]
---

ふと、「俺LPIの最下級くらいとれんじゃね？」と思い立って、LPIのページを流し見していました。

[http://www.lpi.or.jp/](http://www.lpi.or.jp/)

出題範囲と例題から、俺が弱いところ(もしくはまったく知らないところ)を抽出。
すると、出るわ出るわww

- /etc/nsswitch.conf
- プライベートアドレス(192.168. 以外)
- /etc/issue　(知ってたけどディストリ名を調べるトコという程度)
- apropos
- ulimit
- quota
- バックグラウンド- 優先度制御系(fg,bg,top,reniceなど)
- ssh(sshdやコマンド設定でなく、ssh-keygenとかツール類は…)
- ld系(避けてきたしなあ)
- dd,tar以外のバックアップ手段(dumpなど。両極端なバックアップ法してきたからなあ)
- /prop/ 以下の情報ファイル系
- debian系パッケージ管理。
- LPD(印刷管理系)
- /etc/nologin, /etc/security
- フィルタコマンド系
(http://www.lpi.or.jp/mail/contents/20050513.shtml)
- port番号
- network系制御コマンド

てか、ほとんど全部じゃん。ボロボロですね。
教科書買わないといけないな…w

とくに、quota,ulimit,debian系 は自分がしたいサーバ設定に必要だったから、ぜひ勉強すべきもの。
試験勉強と実務勉強を同時にできる効率性。値打ちあると思う…けどやらないのはサボり魔なんでしょね。
