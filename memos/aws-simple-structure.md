# AWSで「シンプルな構成」を作るための知見メモ

DBは「レプリカ一台」APPのインスタンスは2台、ALBでロードバランス…そんな構成を「簡単に」つくるためのメモ。

# ヘルプページを出す。

- Route53とS3で「メンテナンス中のソーリー画面」を出す
  - <http://d.hatena.ne.jp/minamijoyo/20150213/p2>

# デプロイのアイディア

## `CodeDeploy` を使う

- SpringBootのアプリをJenkinsとCodeDployでデプロイする仕組み
  - <https://qiita.com/ryosukehayashi/items/6a419ab73a98ce8e8217>
- 上記で使う「SpringBootアプリの"Fully Executable War"」について
  - <https://qiita.com/yoshidan/items/696cfa68f3dbbad8140c>
- AWS再入門、コードデプロイ編
  - <https://dev.classmethod.jp/cloud/aws/cm-advent-calendar-2015-aws-re-entering-codedeploy/>
-

# 監視

## RDSまわり

- コツ
  - <https://moomindani.wordpress.com/2014/12/15/monitoring-rds-postgresql/>

# セキュリティ

## WAF

- WAF自体の入門
  - <https://dev.classmethod.jp/security/getting-started-waf/>
- AWS WAFを使ってみよう
  - <https://qiita.com/yamakozawa-mediba/items/047065c8adca4674e625>
  - CloudFrontかALBにつけられるらしい
- 気付かぬうちに成長してるかわいい子？ AWS WAFの知られざる実力
  - <http://ascii.jp/elem/000/001/567/1567420/>
- AWS Black Belt Online Seminar 2017 AWS WAF
  - <https://www.slideshare.net/AmazonWebServicesJapan/20171122-aws-blackbeltawswafowasptop10>

## IAM

ほんとうは、AIMはセキュリティの範疇では無いかも知れないけれど

- IAMによるAWS権限管理運用ベストプラクティス
  - <https://dev.classmethod.jp/cloud/aws/iam-bestpractice-1/>

## IDS

- Amazon EC2でIDS(侵入検知システム)を導入する – AIDE –
  - <https://dev.classmethod.jp/cloud/amazon-ec2-ids-aide/>


# Applicationとデプロイ

## SpringBootとEC2

- EC2上にSpringBootアプリをデプロイ
  - <https://www.magata.net/memo/index.php?AWS%20EC2%BE%E5%A4%C7%20Spring%20Boot%A5%A2%A5%D7%A5%EA%B5%AF%C6%B0>
  - 環境変数で制御するみたい

# 機能別

## スケジュール実行

- AWS Lambda の Scheduled Event を試してみた #reinvent
  - <https://dev.classmethod.jp/cloud/aws/lambda-scheduled-event/>
- スケジュールされたイベントでの AWS Lambda の使用
  - <https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/with-scheduled-events.html>
