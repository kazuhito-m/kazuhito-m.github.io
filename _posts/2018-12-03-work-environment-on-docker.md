---
published: false
layout: post
title: SSHトンネリングしたFirefoxを使ってブラウジングする「作業用端末」をDockerで再現する
category: tech
tags: [docker,firefox,infrastructur,iac]
---

# これを読んで得られるもの

- 業務で使う「限定された作業用端末」をDockerを使い配布する方法
  - SSHトンネリングでブラウジングする端末の作成方法

# 経緯


# やったこと


# 所感

「特殊な設定(トンネリングを仕込む、など)をした端末」って、サービスのメンテでもインフラの仕事でも必要になることがあると思います。

ただ、ブラウザの設定とか「GUIの設定も含む」と、途端に「長大な手順書を用意して」とか「各自端末を汚す」「個人で設定するのを強いる」とか、そういうことになりがちで…。

そういうとき「インハウスリポジトリから`docker run` のワンライナーで落として実行」などできると、すごく便利なんじゃないか？と思いやってみました。

トレーサビリティが気になる方は、ログ等「立ち上げてアクセスされたら解る仕組み」も自動で設定しておくのも良いかもしれません。

# 参考

以下を参考にさせていただきました。

- どこへ行っても安心！SSHサーバーを踏み台にしてWebアクセスする方法
  - <https://linuxfan.info/ssh-dyamic-forward>
- OpenBox man page
  - <https://www.mankier.com/1/openbox>
- DockerImage : docker-headless-vnc-container
  - <https://github.com/ConSol/docker-headless-vnc-container>
- Supervisorで簡単にデーモン化
  - <https://qiita.com/yushin/items/15f4f90c5663710dbd56>
