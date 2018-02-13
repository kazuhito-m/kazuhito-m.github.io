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
