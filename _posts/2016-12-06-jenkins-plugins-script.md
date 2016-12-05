---
layout: post
title: Jenkinsの「プラグインをCLIから入れる」スクリプトが公式Dockerイメージに在る
category: tech
tags: [jenkins,plugin,cli]
---

ただ「良いの知った！」って言う備忘録なだけなのですが。

# これを読んで得られるもの

- Jenkinsに「CLIでプラグイン入れられる」な信頼おけるスクリプトの取得場所

# ネタ元

[http://dev.classmethod.jp/tool/jenkins/jenkins-on-docker/](http://dev.classmethod.jp/tool/jenkins/jenkins-on-docker/)

こちらを読んでいて、気付きがあったので、メモ代わりに書いておきます。

(パクリ記事…といえば身も蓋もないですが、感謝です)

# 経緯

Jenkinsを運用していると、 `AsCode` したくなってくるのですが、その時に…

- ジョブ構成
- プラグイン構成

が最後の「出来ないピース」として残ります。

ジョブについては、 [パイプラインスクリプト](https://jenkins.io/doc/book/pipeline/) が出来て、だいぶ楽になった(ジョブを作るところはまだ残る)のですが、プラグインのインストールだけは「エエカンジの手段」を知りませんでした。

なので [サーバの内側からHTTPでPluginインストール命令出すスクリプト](https://github.com/exemplary-buildpipeline-projects/jenkins1-2-sample/blob/master/provision/setup-as-code/setup_jenkins1.sh) とか自力で書いていたのですが、「うーん、いまいち」と思ってました。

で、上記サイトの記事読んで「公式が楽な手段用意しているやん！」というのを知ったので、中身見てみました。

# やったこと

## Jenkins公式Dockerのソースを見る

記事を読むと 「Dockerイメージ内の `/usr/local/bin/plugins.sh` に"プラグインID列挙したテキストファイル名"を引数として渡したらプラグインをインストール出来る」ようなので、そのスクリプトの `github上の元ソース` を見てみることにしました。




---

# 小並感
