---
layout: post
title: jenkinsの公式Dockerイメージの「プラグインをCLIから入れる」スクリプトについて
category: tech
tags: [jenkins,plugin,cli,docker]
---

「自分の備忘録」かつ「良いノウハウではない」です。あしからず。

# これを読んで得られるもの

- Jenkinsの公式Dockerイメージで「AsCode(Dockerfile)でプラグイン入れられる」方法
  - そのメカニズム

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

[https://github.com/jenkinsci/docker/blob/master/plugins.sh](https://github.com/jenkinsci/docker/blob/master/plugins.sh)

## やってることのサマリ

1. 引数や`$JENKINS_HOME`の確認を行った後、「既にインストールされているプラグイン群」を確認
    + `/var/jenkins_home/plugins` を確認
    + `/var/jenkins_home` は「Docker起動時の$JENKINS_HOME」、
    + Dockerのパラメタで「外からマウント」していてもこのパスは変わらない
    + `/var/jenkins_home/plugins`が無かった場合 `jenkins.war` そのもの
0. 引数の「インストールしたいプラグイン群」から「既にインストールされているもの」を除いたものを `https://updates.jenkins.io` からjpiファイルを `/usr/share/jenkins/ref/plugins` へダウンロード
    + `curl` を使っている
0. jpiファイルを解凍

なるほど、

- Dockerイメージのディレクトリ構成に依存
- 実行タイミングがDocker起動時に限定

なので、「汎用的に使えるスクリプト」ではなさそうですね。

---

# 小並感

本当は「使えるスクリプト見つけたぜ！」という記事にしたかったのですが、「Dockerでしか使えなそう」でしたので、「bashの解説」だけの記事になりました。

しかし、「公式も `curl` とかでネットから取ってきて内部ディレクトリ弄う感じの管理している」ということがわかったので、それをヒントに`AsCode`のアイディア元にできそうです。

…いや、「DockerイメージでJenkins動かせ」「そのDockerfileをメンテせえよ」てことですねｗ
