---
layout: post
title: 雲勉【勉強会:新技術好き!】AWS re:Invent 2016 速報共有会
category: study-meeting-repo
tags: [aws,cloudpack,reinvent,cloud]
---

最速で「感想ブログ記事」出す！！ (おそらく今回限り)

# 情報

+ 日付 : 2016/11/28(月)
+ [申し込みサイト](https://iotlt.connpass.com/event/42653/)
+ ハッシュタグ : [#iotlt](https://twitter.com/search?q=%23iotlt)
+ 何するのか : IoT縛りでLT…ってそのままかｗ

# なんで来たん？

「IoTどうなん？」って言われて…しょーじき自分でも「家電やセンサー＆ITって…199X年時点であったしなぁ」という感じで、「IoTのIoTたるところ」を知らないんですよ。

あと「物体弄らえるエンジニア」って俺の憧れ！なんで、大リスペクトなんですよね。

というわけで、「IoTの感じ」を得るために来ました。

# 内容

以下、「全体的に新プロダクトを触れる」のスライドがあったので、それのメモ。

## AWS Greengrass

## AWS Snowmobile

## Snowmobile

- AWS Snowballエキサバイトのデータ移行サービス
- トレーラーで運ぶ

## AWS Snowball Edge

- S3 API,NFS
- Lambdaを内包できる
- 日本に来てない
- Lambdaファンクションの実行は無料

## AWS Code Build

- ビルドとテストができるマネージドサービス
- ソースリポジトリとして、AWSさん CodeCommit,Github,S3
- CodePipelineととも連携したCI/CD環境を実現
- セットアップ済でスケール、分単位での実行時間課金

時間貸しの試算がしたい…。

## AWS X-Ray

- EC2,ECS,Beanstalk,APIGatewayその他の基盤上で実行される
- コードからトレースデータを補足できるサービス

## RDS Aurola PostgresSQL

- AurolaのPostgresSQL版


## AWS Pinpoint

- ユーザエンゲージメント促進
- ユーザ行動理解
- ターゲットにするユーザを定義
- キャンペーン結果を追跡

## AWS Glue

- データカタログの作成とデータ加工・ロード(ETL)が実現可能なマネージドサービス
- S3,RDS,Redshiftその他JDBC対応データをサポート

## Lambda@Edge

- Lambdaベースの処理をCloudFrontのエッジロケーションで実行し、リアルタイムにヘッダー、URLなどの編集か可能なサービス
- Node.jsで記述
- 利用可能メモリは128MBで実行時間の上限は50ms

プログラマブルにしてくれる、ってことかな？

## AppStream 2.0

- 描画処理を得意とするゲームアプリ配信基盤で提供してたが、2.0では汎用的なデスクトップアプリを配信

---

## EC2 System Manager

- ES2インスタンス、オンプレミスの構成管理を自動化できる
- EC2 System Mangerは無料で利用

## AWS Batch

- 古マネージド型のバッチ処理実行サービス
- ジョブ登録したアプリ・コンテナイメージをスケジューラが実行
- AWS Batchのりよう料金は無料
  - 起動したリソースについて課金

## Amazon Polly

- フルマネジの"Text-to-speach"機能

自分は「XFD代わり」をするためOpenJTalkでやってるけど、その理由は「世にサービスはあるがWebをまたぐが嫌」「金がない」で、しかし「自力でやると遅い」「発声が変」が付きまとうので「安い」「早い」なら使いたいなぁと思いました。

## OpsWorks for Chef Automate

- Chefサーバが使える

## ECS向けのオープンソーススケジューラBlox

- ECS向けのコンテナ管理及びオーケストレーション・ツール群
- OSS

## Amazon Lightsail

- 単純な構成のサーバ必要時に

AMIよりもっと「ユースケースを(金額のプランなどまで)一式でコーディネート」された、インスタンス立ち上げ機構でしょうか？

「必要用途のサーバを爆速で立ちあげれる」は、コンテナの用途と同じく開発者には嬉しい…かも？

## AWS Shield

- マネージドDDoSプロテクションサービス
  - 無償版の `AWS Shield for Everyone`
  - 有償版の `AWS SHield Advanced`

# 特集

## AWS Personal Healsth Dashboard

- 顧客保有のAWSリソースのメンテナンスイベントを集約するダッシュボード機能を提供
- 「影響を受けるAWSサービスのメンテ」をダッシュボードに表示
- CloudWatch EventやLambdaに連携
  - 3rd Party製の監視システム連携も可能

## AWS Step functions

- ワークフローが複雑で、条件分岐が発生するような処理をビジュアルとJSONで定義・実行
- `タスク`を使った分散処理を設計・実行する仕組み
- 概念
  - State Machine
    - ワークフロー全体
  - タスク
    - Lambdaファンクション
    - その他
  - StateType
  - エラーハンドリング
    - Retry,Catch
- 実行
  - 結果(Output)がわかる
  - どこを通過しているかも「ビジュアル」と「ステップのリスト」でわかる
- 制約
  - state machine
    - 10,000
    - 一年実行できる（Max)
- ユースケース
  - 従来のバッチをLambda化
    - ジョブ間連携を単純な入力、出力で実装できる
    - ワークフローの進捗がコンソールでわかる
    - CloudWatchにイベント出力される
    - 外部システムの処理待ちも容易にできる



---

## 子並感
