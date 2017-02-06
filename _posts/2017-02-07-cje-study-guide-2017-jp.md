---
published: false
title: 「Certified Jenkins Engineer (CJE) Study Guide」の訳
layout: post
category: tech
tags: [jenkins,exam]
---

「Jenkinsの資格がある！」って聞いたのですが、[日本語情報っぽいのがここしかない](http://www.slideshare.net/hirokotamagawa/9jenkins-pipeline#6)ので、本家のガイドを探しだして「超絶テキトウ翻訳」してみました。

- 原文: [https://www.cloudbees.com/sites/default/files/cje-study-guide-2017.pdf](https://www.cloudbees.com/sites/default/files/cje-study-guide-2017.pdf)
- 訳: [@kazuhito_m](https://twitter.com/kazuhito_m)
- 注: 実際の試験は「すべて英語」なので「翻訳してちゃいけない(用語としての)英語」も適当にやらかしている場合があるのでご注意を

---

認定Jenkinsエンジニア(CJE) - 2017 認定試験学習ガイド
========================================

## CloudBees社はJenkinsエンジニアに2つの認定を提供します

- 認定Jenkinsエンジニア(CJE)試験は、(オープンソースの)Jenkins知識に関する60の複数選択問題で出題します
- 認定CloudBeesJenkinsエンジニア(CCJPE)試験は、90の問題: 60の(オープンソースの)Jenkins知識に関する問題と、30のCloudBeesのJenkinsプラットフォームに関する問題 を出題します

## イントロダクション

この学習ガイドは、認定Jenkinsエンジニア(CJE)試験のためのものです。
認定CloudBeesJenkinsエンジニア(CCJPE)試験については[こちら](https://www.cloudbees.com/jenkins/jenkins-certification)を参照ください。

このガイドであなたは、試験の出題トピック、外部参照のリンク、そして例題を得ることができます。

## 新着情報

__NOTE: 2016年から2017年へのすべての変更は、このドキュメント中の [new] 記号で表示しています。__

認定試験で2016年から2017年での主な変更は:

- open-source Jenkinsに関する問題は Jenkins 2.19.4 に基づく
- パイプラインに関する問題は、 [Pipeline plugin version2.4](https://plugins.jenkins.io/workflow-aggregator#PipelinePlugin-2.4%28Sep21%2C2016%29) の [最新の構文](https://jenkins.io/blog/2016/10/16/stage-lock-milestone/) に更新
- 試験対象にされているプラグインは、「suggested(推奨)」セットのプラグインのみ(詳細は下記参照)
- CJPに関する問題は、現在CJP 2.7.20.2に基づく
- CJPの問題にCloudBees保証プログラムに関するセクションを追加
- Docker及び構成管理に関する問題を削除

## 構成

試験は、4つの章に集約されます:

1. CI/CD/Jenkinsのコンセプト
0. Jenkinsの使用方法
0. 継続的デリバリー(CD)パイプラインの構築
0. CD-as-codeのベストプラクティス

すべての出題は、Jenkins coreのバージョン [`2.19.4`](https://jenkins.io/changelog-stable/#v2.19.4) [new] を元にします。

すべての問題は、既定の推奨プラグインセットがインストールされたJenkins（以下 "base" Jenkinsと呼称）の標準インストール（以下"Suggested plugins"と呼称）に基づいています。
詳細は、「プラグイン」を参照してください。

__NOTE:__ 試験では、ランダムな順序で出題され、セクションはありません。

## プラグイン群

セクション1〜4の質問は、主にJenkinsの「base」インストールに関する質問をカバーしていますが、
「suggested(提案)」プラグインの知識もカバーされます。

受験者には、これらのプラグインの機能/用途を知ることが期待されますが、詳細な使用法についてはテストされません。

[new] 「suggested(推奨)」プラグインは、新しいJenkinsインストールで「セットアップウィザード」によってインストールされるデフォルトのプラグインです。

このリンクをたどり、Jenkinsの固定バージョンに紐付いた完全なリストを見つけることができます： [Jenkins 2.19.4 suggested plugin list](https://github.com/jenkinsci/jenkins/blob/jenkins-2.19.4/core/src/main/resources/jenkins/install/platform-plugins.json)

[new] 「[Pipeline Plugin](https://plugins.jenkins.io/workflow-aggregator)」は、それ自体、パイプラインと関連機能を実装するプラグインの集合体です。

以下の機能が含まれています:

- [Pipeline Multibranch](https://wiki.jenkins-ci.org/display/JENKINS/Pipeline+Multibranch+Plugin)
- [Pipeline Shared Groovy Libraries](https://wiki.jenkins-ci.org/display/JENKINS/Pipeline+Shared+Groovy+Libraries+Plugin)
- [Pipeline Stage View](https://wiki.jenkins-ci.org/display/JENKINS/Pipeline+Stage+View+Plugin)


## 用語

次の点にも注意してください:

- `SCM` は、特に指定しない限り “source code management” を指します
- `Pipeline` は、一般名詞として使用されている場合やパイプライン名（「CD pipelines」など）を除いて、Pipelineプラグイン（以前は「Workflow plugin」と呼ばれていました）によって作成されたジョブタイプを指します
- JenkinsのさまざまなUI要素は、次の用語を使用して参照されます

※訳者注. 4〜5ページの画像は割愛。 ([本家ドキュメント参照](https://www.cloudbees.com/sites/default/files/cje-study-guide-2017.pdf))

## 1. CI/CD/Jenkinsのコンセプト

このトピックは、試験の約27％を構成します。
質問には次のトピックが含まれます：

- 継続的デリバリー(CD)/継続的インテグレーション(CI) コンセプト
  - 継続的インテグレーション、継続的デリバリー、継続的デプロイの定義
  - CI、CDという段階
  - 継続的デリバリー 対 継続的デプロイ
- ジョブ
  - Jenkinsにおけるジョブとは？
  - ジョブのタイプ
  - ジョブの範囲(Scope)
- ビルド
  - Jenkinsにおけるビルドとは?
  - ビルドステップ、トリガー、成果物(artifacts)、リポジトリとは？
  - ビルドツールの設定
- ソースコード管理
  - ソースコード管理システムとはどういうもので、どういう用途に買われているか？
  - クラウドベースSCM(Cloud-based SCMs)
  - Jenkins変更ログ(changelogs)
  - インフラストラクチャ アズ コード(Infrastracture-as-Code)
  - ブランチとマージ戦略
- テスト(Testing)
  - Jenkinsを使ってテストを行うことの利点
  - ユニットテスト、スモークテスト、受け入れ(Acceptance)テスト、自動的検証(automated verification)、機能テスト
- 通知(Notifications)
  - Jenkinsにおける通知の種類
  - 通知の重要性
- 分散ビルド(Distributed Builds)
  - 分散ビルドとは？
  - マスターとエージェントの機能
- プラグイン(Plugins)
  - プラグインとは？
  - プラグインマネージャー(plugin manager)とは？
- Jenkins Rest API
  - 接続・応答の方法
  - なぜこれを使うのか？
- セキュリティ
  - 承認(authentication) 対 認証(authorization)
  - マトリクスセキュリティ(Matrix security/行列で扱える機能認可)
  - 監査の定義、資格情報、およびその他の重要なセキュリティの概念
- 指紋(Fingerprints)
  - 指紋とは？
  - 指紋はどのように機能する？
- 成果物(Artifacts)
  - Jenkinsにおける成果物はどのように機能する？
  - 容量の大きい成果物(訳者注：Strong Artifactsなのだけれど、こういう意味か？)
- サードパーティ製ツールの使用
  - どのようにサードパーティ製ツールを使うか
- インストール・ウィザード [new]
  - Jenkinsインストールウィザードとは何か？
  - ウィザードはどのように使う？
  - どの構成がインストールウィザードの対象？

下記のオンラインリソースは、上記のトピックを理解するためのエントリーポイントを提供します:

- [http://www.martinfowler.com](http://www.martinfowler.com)
  - [Continuous Integration](https://www.martinfowler.com/articles/continuousIntegration.html)
  - [Continuous Delivery](https://martinfowler.com/bliki/ContinuousDelivery.html)
  - [Deployment Pipeline](https://martinfowler.com/bliki/DeploymentPipeline.html)
- [http://www.informit.com](http://www.informit.com)
  - [CD Pipeline Anatomy](http://www.informit.com/articles/article.aspx?p=1621865&seqNum=2)
- [http://devops.com](http://devops.com)
  - [What is a CD pipeline](http://devops.com/2014/07/29/continuous-delivery-pipeline/)
- [https://jaxenter.com](https://jaxenter.com)
  - [Implementing Continuous Delivery](https://jaxenter.com/implementing-continuous-delivery-117916.html)
- [http://www.infoq.com](http://www.infoq.com)
  - [Orchestrating Pipelines Jenkins](https://www.infoq.com/articles/orch-pipelines-jenkins)
- [http://technologyconversations.com](http://technologyconversations.com)
  - [Continuous Delivery Introduction to Concepts and Tools](https://technologyconversations.com/2014/04/29/continuous-delivery-introduction-to-concepts-and-tools/s)
- [https://en.wikipedia.org](https://en.wikipedia.org)
  - [Continuous delivery](https://en.wikipedia.org/wiki/Continuous_delivery)
  - [Artifact software development](https://en.wikipedia.org/wiki/Continuous_delivery)
  - [Build automation](https://en.wikipedia.org/wiki/Build_automation)
  - [Distributed version control](https://en.wikipedia.org/wiki/Distributed_version_control)
  - [List of version control software](https://en.wikipedia.org/wiki/List_of_version_control_software)
  - [Smoke testing (software)](https://en.wikipedia.org/wiki/Smoke_testing_(software))
- [https://jenkins.io](https://jenkins.io) [new]
  - [Jenkins Installation and Setup](https://jenkins.io/download/) [new]
  - [Jenkins Documentation](https://jenkins.io/download/) [new]
  - [Jenkins Pipeline](https://jenkins.io/doc/book/pipeline/) [new]
  - [Jenkins HandBook](https://jenkins.io/doc/book/) [new]
  - [https://plugins.jenkins.io](https://plugins.jenkins.io) [new]
- [https://www.safaribooksonline.com](https://www.safaribooksonline.com)
  - [Jenkins the Definitive Guide](https://www.safaribooksonline.com/library/view/jenkins-the-definitive/9781449311155/ch05.html)
- [https://wiki.jenkins-ci.org](https://wiki.jenkins-ci.org)
  - [Administering Jenkins](https://wiki.jenkins-ci.org/display/JENKINS/Administering+Jenkins)
  - [Terminology](https://jenkins.io/doc/book/glossary/)
  - [Extreme feedback lamp switch gear style](https://jenkins.io/blog/2013/09/05/extreme-feedback-lamp-switch-gear-style/)
  - [Distributed builds: Offline status and retention strategy](https://wiki.jenkins-ci.org/display/JENKINS/Distributed+builds#Distributedbuilds-Offlinestatusandretentionstrategy)
  - [Remoting issue](https://wiki.jenkins-ci.org/display/JENKINS/Remoting+issue)
  - [Remote access API](https://wiki.jenkins-ci.org/display/JENKINS/Remote+access+API)
  - [Matrix based security](https://wiki.jenkins-ci.org/display/JENKINS/Matrix-based+security)
  - [Securing Jenkins](https://wiki.jenkins-ci.org/display/JENKINS/Securing+Jenkins)
  - [Quick and Simple Security](https://www.cloudbees.com/sites/default/files/cje-study-guide-2017.pdf)
- [http://docs.openstack.org](http://docs.openstack.org)
  - [Jenkins job builder](http://docs.openstack.org/infra/jenkins-job-builder/triggers.html)
- [https://www.simple-talk.com](https://www.simple-talk.com)
  - [Branching and merging](https://www.simple-talk.com/opinion/opinion-pieces/branching-and-merging-ten-pretty-good-practices/)
- [http://stackoverflow.com](http://stackoverflow.com)
  - [What is unit test, integration test, smoke test, regression test?](http://stackoverflow.com/questions/520064/what-is-unit-test-integration-test-smoke-test-regression-test)
- [https://www.cloudbees.com/](https://www.cloudbees.com/)
  - Notifications (ページがなくなってる模様)
- [http://searchsecurity.techtarget.com/](http://searchsecurity.techtarget.com/)
  - [Authentication authorization and accounting](http://searchsecurity.techtarget.com/definition/authentication-authorization-and-accounting)

## 2. Jenkinsの使い方（機能と特長）

- ジョブ
  - Jenkinsでのジョブの整理
  - パラメータ化ジョブ
  - フリースタイル/パイプライン/マトリックスジョブの使用方法
- ビルド
  - ビルドステップとトリガーの設定
  - ビルドツールの設定
  - ビルドステップの一部としてのスクリプト実行
- ソースコード管理
  - ポーリングによるソースコード管理
  - フックの作成
  - バージョン管理タグとバージョン情報のインクルード
- テスト(Testing)
  - コードカバレッジのためのテスト
  - Jenkinsにおけるテストレポート
  - テスト結果の表示
  - テスt自動化ツールとの統合
  - ビルドの中断
- 通知(Notifications)
  - セットアップと使用法
  - 電子メール通知、インスタントメッセージ
  - 通知時のアラーム
- 分散ビルド(Distributed Builds)
  - 並行実行のセットアップと実行法
  - SSHエージェント、JNLPエージェント、Cloudエージェントのセットアップと使い方
  - ノードの監視
- プラグイン(Plugins)
  - プラグインマネージャーのセットアップと使い方
  - 必要なプラグインの検索と設定
- CI/CD
  - Pipeline(以前は"Workflow"と呼ばれていたもの)の使い方
  - 自動デプロイの統合
  - リリース管理プロセス
  - パイプラインの"Stage"の振る舞い
- Jenkins Rest API
  - REST APIを使用した遠隔ジョブトリガー、ジョブ状態の確認、ジョブの作成/削除
- セキュリティ
  - セキュリティレルム(realms,訳註:認証ポリシーの適用範囲)の設定と使い方
  - ユーザデータベース、プロジェクトセキュリティ、マトリックスセキュリティ
  - 監査(auditing)のセットアップと使い方
  - 資格情報(Credentials)のセットアップと使い方
- 指紋(Fingerprints)
  - 指紋(Fingerprints)ジョブの共有またはジョブ間でのコピー
- 成果物(Artifacts)
  - 成果物のコピー
  - Jenkinsにおける成果物の使い方
  - 成果物の保持ポリシー
- アラート
  - ジョブとビルドスクリプトの基本的な更新方法
  - ビルドとテストの失敗アラートからの問題のトラブルシューティング

以下のオンラインリソースは、上記のトピックを理解するためのエントリーポイントを提供します:

- [https://wiki.jenkins-ci.org](https://wiki.jenkins-ci.org)
  - [Distributed builds](https://wiki.jenkins-ci.org/display/JENKINS/Distributed+builds)
  - [Post-initialization script](https://wiki.jenkins-ci.org/display/JENKINS/Post-initialization+script)
  - [Features controlled by system properties](https://wiki.jenkins-ci.org/display/JENKINS/Features+controlled+by+system+properties)
- [http://blog.cloudbees.com](http://blog.cloudbees.com)
  - [Parallelism and Distributed Builds with Jenkins](https://www.cloudbees.com/blog/parallelism-and-distributed-builds-jenkins)

## 継続的デリバリー(CD)パイプラインの構築

このトピックは、試験の約16％を構成します。 質問には以下の内容が含まれます:

- パイプラインの概念(コンセプト)
  - CDパイプラインのバリューストリームマッピング
  - なぜパイプラインを作成するのか？
  - CDパイプライン内のゲート(Gates)
  - 複数のグループが同じツールを使用する場合の、集中パイプラインの保護(protect)方法
  - バイナリ再利用、自動デプロイメント、複数環境の定義
  - 理想的なCI/CDパイプライン・ツールの要素
  - スクリプト構築における重要な概念（セキュリティ/パスワード、環境情報などを含む）
- アップストリーム(上流)とダウンストリーム(下流)
  - 他のジョブからのジョブトリガー
  - Parameterized Trigger pluginのセットアップ
  - アップストリーム(上流)とダウンストリーム(下流)ジョブ
- トリガ(Triggering)
  - コード変更によるJenkinsトリガー
  - プッシュとプルの違い
  - 使うタイミング プッシュ vs プル
- Pipeline(以前は"Workflow"と呼ばれていたもの)
  - パイプライン vs リンクされたジョブ の利点
  - パイプラインで提供される機能
  - パイプラインの使い方
  - Pipeline stage view [new]
- フォルダ(Folders)
  - Jenkinsのフォルダにあるアイテムへのアクセス制御する方法
  - フォルダ内のジョブの参照
- パラメータ(Parameters)
  - アップロードされた実行ファイルに対してJenkinsのテスト自動化の設定
  - ジョブ間でのパラメータ渡し
  - パラメータの特定と使用方法：ファイルパラメータ、文字列パラメータ
  - JenkinsCLIパラメータ
- プロモーション(Promotions/促進)
  - 仕事の促進
  - なぜジョブを促進するのか？
  - Promoted Builds Pluginの使用方法
- 通知(Notifications)
  - CDパイプラインの情報をチームに発信する方法
- パイプライン・マルチブランチとリポジトリスキャン
  - マルチブランチジョブの使用方法
  - Github/BitBucketのOrganizationスキャン
  - 基本的なSCMリポジトリのスキャン
- パイプライン・グローバル・ライブラリ
  - パイプライン間でコードを共有する方法
  - 共有ライブラリの使用
  - フォルダとの相互作用とリポジトリスキャン
  - セキュリティとGroovyサンドボックス

以下のオンラインリソースは、上記のトピックを理解するためのエントリーポイントを提供します:

- [https://jenkins.io/](https://jenkins.io/) [new]
  - [Handbook](https://jenkins.io/doc/book/) [new]
  - [Pipeline](https://jenkins.io/doc/book/pipeline/) [new]
  - [Pipeline Global Shared Libraries](https://jenkins.io/doc/book/pipeline/shared-libraries/) [new]
  - [Pipeline Multibranch](https://jenkins.io/doc/book/pipeline/multibranch/) [new]
  - [Controlling the Flow with Stage, Lock, and Milestone](https://jenkins.io/blog/2016/10/16/stage-lock-milestone/) [new]
- [https://plugin.jenkins.io/](https://plugin.jenkins.io/) [new]
  - [Pipeline Plugin 2.4](https://plugins.jenkins.io/workflow-aggregator#PipelinePlugin-2.4%28Sep21%2C2016%29) [new]
- [CloudBees Knowledgebase](https://support.cloudbees.com/hc/en-us)
  - [Injecting Secrets into Jenkins Build Jobs](https://support.cloudbees.com/hc/en-us/articles/203802500-Injecting-Secrets-into-Jenkins-Build-Jobs)
- [https://www.cloudbees.com](https://www.cloudbees.com)
  - [Credentials API Jenkins](https://www.cloudbees.com/blog/credentials-api-jenkins)
- [CloudBees Documentation](https://go.cloudbees.com/doc/index.html)
  - [List views](https://go.cloudbees.com/docs/cloudbees-documentation/cje-user-guide/index.html#_list_views?query=view)
- [https://github.com](https://github.com])
  - [confab](https://github.com/jenkinsci/jenkins/blob/3537831a42cd5b3b27a41fcde9b1f201962f38a1/core/src/main/grammar/crontab.g#L68-L71)
  - [help-spec](https://github.com/jenkinsci/jenkins/blob/3537831a42cd5b3b27a41fcde9b1f201962f38a1/core/src/main/resources/hudson/triggers/TimerTrigger/help-spec.html#L45-L46)
  - [pause and resume execution](https://github.com/jenkinsci/pipeline-plugin/blob/feb5bf44573dfc9379d9551f12b0372907e787be/README.md#pause-and-resume-execution)
  - [Executor Step Test](https://github.com/jenkinsci/pipeline-plugin/blob/feb5bf44573dfc9379d9551f12b0372907e787be/aggregator/src/test/java/org/jenkinsci/plugins/workflow/steps/ExecutorStepTest.java#L165-L214)
  - [Write File Step](https://github.com/jenkinsci/pipeline-plugin/blob/e0263fc7275e804785e4e93054ef0f2f2945a2dc/basic-steps/src/main/resources/org/jenkinsci/plugins/workflow/steps/WriteFileStep/help.html#L1)
- [http://wiki.jenkins-ci.org](http://wiki.jenkins-ci.org)
  - [Jenkins CLI](https://wiki.jenkins-ci.org/display/JENKINS/Jenkins+CLI)

## 4. CD-as-Codeのベストプラクティス

このトピックは、試験の約16％を構成します。 質問には以下の内容が含まれます:

- 分散ビルドアーキテクチャ
- 置換(交換)可能なエージェント
- マスターエージェントのコネクタとプロトコル
- エージェント上のツールのインストール
- クラウドエージェント
- トレーサビリティ
- 高可用性

以下のオンラインリソースは、上記のトピックを理解するためのエントリーポイントを提供します:

- [http://go.cloudbees.com](http://go.cloudbees.com)
  - [Cookbook](https://go.cloudbees.com/docs/cloudbees-documentation/cookbook/book.html)
  - [Distributed Builds Architecture](https://go.cloudbees.com/docs/cloudbees-documentation/cookbook/book.html#_distributed_builds_architecture)
  - [Choosing the Right Hardware](https://go.cloudbees.com/docs/cloudbees-documentation/cookbook/book.html#_choosing_the_right_hardware_for_masters)
  - [Architecting for Scale](https://go.cloudbees.com/docs/cloudbees-documentation/cookbook/book.html#_architecting_for_scale)
  - [Pipeline as Code](https://go.cloudbees.com/docs/cloudbees-documentation/cookbook/book.html#pipeline-as-code) (formerly “Workflow as Code”)
- [http://wiki.jenkins-ci.org](http://wiki.jenkins-ci.org)
  - [Remoting](https://wiki.jenkins-ci.org/display/JENKINS/Remoting+issue)
