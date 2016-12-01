---
published: false
layout: post
title: Jenkinsで
category: tech
tags: [jenkins,slave,jnlp]
---



# これを読んで得られるもの

- Jenkins + Windows + PipelineScript にて「ジョブが何時までたっても止まってる」ハマリの回避
- Jenkinsにてjnlp(WebStart)Slave作る場合のトラブルシュート手順をある程度

# 前提

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

JenkinsのPipelineScriptでWindows対象の `bat` 構文を使った時、「無言で永久に止まる」という問題に当たりました。


「ログにも何も出ず」「ただ止まってるだけ」なので、何が起こってるかわかりません。


# やったこと

## 問題の切り分け

とりあえず

- 構成(JNLP使用slave)のせいなのか
- 単一環境(Windowsだから)のせいなのか

とかを切り分けたかったので、Slaveのマシンに同一VerのJenkinsを入れ、「同じ構文のPipelineスクリプトのジョブ」を作成し、実行しました。


一緒だ…。

## どんなメカニズムなのかをみていく

## Jenkinsにより生成されたバッチを実行してみる

## 解決

アルファベットだけのジョブ名に変えると…


---

# 小並感

スレーブなのだから「あまり手を入れずに、通信の仕込みだけして…」という状況になりやすいし、そうしたいことがほとんどなのではないかと。

そういう時に、こういう「得体のしれないハマり」をしたくないものです。

消極的ではありますが、「多OSのSlave抱えるMaster構成時にはジョブに日本語使わないのが無難」かな？という教訓を得ました。
