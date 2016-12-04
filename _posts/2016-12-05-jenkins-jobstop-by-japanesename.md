---
layout: post
title: Jenkinsで「パイプラインスクリプトでWindowsのコマンド叩く」時ジョブが延々と止まる感じになる場合
category: tech
tags: [jenkins,slave,jnlp]
---

色々書きますけど、結論的には「JenkinsとWindowsでハマる」です。(slave nodeとか構成関係ないです)

ま、自分用なので読みにくくとも「やったこと順」で書きますかね。

# これを読んで得られるもの

- Jenkins + Windows + パイプラインスクリプト にて「ジョブが何時までたっても止まってる」ハマリの回避
- Jenkinsにてjnlp(WebStart)Slave作る場合のトラブルシュート手順をある程度

# 前提

Jenkinsのnodeをmaster/slaveで組んでいました。

- Jenkins(master)
  - CentOS6(in AWS)
  - [本家の入れ方](https://wiki.jenkins-ci.org/display/JENKINS/Installing+Jenkins+on+Red+Hat+distributions)したJenkins使用
  - Jenkins ver. 2.34
- Jenkins(slave)
  - Windows Server2012 R2(in AWS)
    - AWSでくれる状態ほぼデフォルト
    - 日本語言語パックすら入れず、ロケール/タイムゾーンも用意されたまま
  - jnlpでコネクション張る(java -jar slave.jar起動)


# 事象

Jenkinsのパイプラインスクリプト(Jenkinsfileに書くアレ)でWindows対象の `bat` 構文を使った時、「無言で永久に止まる」という問題に当たりました。

![全体の感とnodeの構成](/images/2016-12-05-outline.png)

スクリプト自体は「指定したノードでechoするだけ」の簡単なワンライナー。

![echoするだけの簡単なパイプラインスクリプト](/images/2016-12-05-pipelinescript.png)

実行するも「ログにも何も出ず」「ただ止まってるだけ」なので、何が起こってるかわかりません。

![20分以上動かないジョブ](/images/2016-12-05-infinity.png)

これ…「めちゃめちゃ待ったら終わったり」しない？止めて良いのかな？

# やったこと

## slave側の状態を見る

WindowsのSlave側を確認します。

masterのJenkinsの方で「Widndowsのslaveで使うのは `C:\jenkins_node` というフォルダ」と設定してあるので、そこがどうなってるのか眺めます。

![Windowsのslave側のフォルダ状態](/images/2016-12-05-winslave-folders.png)

`bat`ステートメントの詳しい仕様は知らないのですが、「ジョブ名のフォルダ」も出来ているし、「実行すべきコマンド」もbatファイルで放り込めてるように思えます。…なぜ止まるんだ。

## 問題の切り分け

とりあえず

- 構成(JNLP使用slave)のせいなのか
- 単一環境(Windowsだから)のせいなのか

とかを切り分けに行きます。

Slaveのマシンに同一VerのJenkinsを入れ、「同じ構文のPipelineスクリプトのジョブ」を作成し、実行しました。

![Windowsのslave側でJenkins起動](/images/2016-12-05-win-standalone-jenkins-script.png)

![WindowsのJenkinsでJob実行](/images/2016-12-05-win-standalone-jenkins-stay.png)

一緒だ…。

これにより「構成は関係ない」で、「Windows + Jenkins + パイプラインスクリプト(bat)の問題」に絞れました。

## 実際に「Jenkinsに作られたbatファイル」を叩いてみる

ローカルに入れたJenkinsは「デフォルト(特に何も設定しない)なら、 `[ユーザのカレントフォルダ]\.jenkins` にデータを貯め」ます。

上の検証から「問題はローカルJenkinsでも起こる」と考え、このフォルダを見ていきます。

パイプラインスクリプトかつ`bat`で在る限りは、`workspace`とかに同じようにバッチを作って…

![WindowsのJenkinsで吐かれたbat](/images/2016-12-05-win-standalone-jenkins-bat.png)

ましたね。ではコレを叩いてみます。

![WindowsのJenkinsで吐かれたbatを叩く](/images/2016-12-05-win-standalone-jenkins-bat-exec.png)

`jenkins-main.bat` というバッチは成功しますが…

 (おそらくそれを呼び出すラッパーバッチであろう) `jenkins-wrap.bat` というバッチが失敗します。

おそらく、 __コレ__ ですね！

バッチの内容は正しいのですが「そんなpathない」と言ってます。

## 解決

「日本語が問題かなー？」と決め打って、元のSlave/Master構成で、「アルファベットだけのジョブ名」に変えると…

![ジョブをアルファベットだけにしてmaster/slave構成で実行](/images/2016-12-05-job-rename-exec.png)

すんなり通った！

これについて「日本語LanguaePack入れてないとか"ロケール変更を怠った"から」かなーと思ったのですが、

<blockquote class="twitter-tweet" data-lang="ja"><p lang="ja" dir="ltr">Language Pack 入れたとしても UTF-8/ANSI (Windows-31J) 変換地獄見るので日本語やめたほうがいいっす（笑）<a href="https://twitter.com/kazuhito_m">@kazuhito_m</a> <a href="https://twitter.com/kyon_mm">@kyon_mm</a></p>&mdash; kes/0.9 (H. Ushito) (@iso2022jp) <a href="https://twitter.com/iso2022jp/status/804238178873843712">2016年12月1日</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

と識者の方に聞いたので「ジョブ名に日本語は避ける」が定石かもしれません。

---

# 小並感

JenkinsのSlaveを立てるとき「あまり手を入れずに、通信の仕込みだけして…」という状況になりやすいし、そうしたいことがほとんどなのではないかと。

そういう時に、こういう「得体のしれないハマり」をしたくないものです。

消極的ではありますが、「他種OSのSlave抱えるMaster構成時にはジョブに日本語使わないのが無難」かな？という教訓を得ました。
