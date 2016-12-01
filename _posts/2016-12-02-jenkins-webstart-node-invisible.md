---
published: false
layout: post
title: Jenkinsでslaveを作るとき「Java Web Startを利用して…」の選択肢が出ない場合
category: tech
tags: [jenkins,slave,jnlp]
---

常識なのかもしれないけど…ググッて１行目くらいに出てきてくれなくて凹んだからさあ。

# これを読んで得られるもの

- Jenkinsにてjnlp(WebStart)Slave作るときのハマリを回避出来る

# 前提

- Ubuntu 16.04 LTS(in Docker)
- [本家の入れ方](https://wiki.jenkins-ci.org/display/JENKINS/Installing+Jenkins+on+Ubuntu)したJenkins使用
- Jenkins ver. 2.19.4

# 事象

Jenkinsの画面にて、 `Jenkinsの管理` -> `ノードの管理` -> `新規ノード作成` で、ノードが作成出来ます。

そこで、[本家の通り「Java Web Startを利用してスレーブエージェントを起動する」をしたい](https://wiki.jenkins-ci.org/display/JA/Distributed+builds#Distributedbuilds-JavaWebStart%E3%82%92%E5%88%A9%E7%94%A8%E3%81%97%E3%81%A6%E3%82%B9%E3%83%AC%E3%83%BC%E3%83%96%E3%82%A8%E3%83%BC%E3%82%B8%E3%82%A7%E3%83%B3%E3%83%88%E3%82%92%E8%B5%B7%E5%8B%95%E3%81%99%E3%82%8B)のですが、インストール直後その選択肢が出ません。

![一番上の選択肢にホントは出るはず](/images/2016-12-02-invisible-jnlp.png)

…下のHelpの中にすら載っているのに。

# やったこと

## 「グローバルセキュリティの設定」の変更

Jenkinsの画面にて、 `Jenkinsの管理` -> `グローバルセキュリティの設定` 画面へ行きます。

`TCP port for JNLP agents` という選択肢が、最初は `無効` になっています。

これを `ランダム` を選択するか `固定` でポートを指定して、設定保存をします。

![１例として"ランダム"を選んでます](/images/2016-12-02-jnlp-port-settings.png)

そして、 `新規ノード作成` 画面に行くと、選択肢が増えています。

![めでたく出ましたね](/images/2016-12-02-visible-jnlp.png)


# 小並感

感嘆なことなんですが…「昔の資料は全然触れてない」し「どうググッて良いかわからない」し…ハマったので記事書きました。

昔一度やったときには、こんなハマリしなかった気がする…んだけどなー。

# 参考URL

以下を参考(というかドンピシャ答え)にさせていただきました。ありがとう英語圏の方。

- [http://stackoverflow.com/questions/40340097/there-is-no-launch-agent-via-java-web-start-option-in-my-jenkins-when-i-adding](http://stackoverflow.com/questions/40340097/there-is-no-launch-agent-via-java-web-start-option-in-my-jenkins-when-i-adding)
