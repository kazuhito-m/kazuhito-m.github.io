# AWSで「シンプルな構成」を作るための知見メモ

DBは「レプリカ一台」APPのインスタンスは2台、ALBでロードバランス…そんな構成を「簡単に」つくるためのメモ。

# ヘルプページを出す。

- Route53とS3で「メンテナンス中のソーリー画面」を出す
  - <http://d.hatena.ne.jp/minamijoyo/20150213/p2>

# Route53

- セキュリティ周りについて
  - <https://blog.manabusakai.com/2015/09/route53-domain-security/>

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

# 個々のプロダクトの知見

## ALB

- 豆知識
  - <http://blog.serverworks.co.jp/tech/2017/02/08/alb-tagert-health-status/>
- 入門
  - <https://jyo-to.okinawa/20170611/1275/>

## s3

- VPCひも付け
  - <https://jyo-to.okinawa/20170611/1264/>

## 番外:ACM(証明書発行)

基本、今回の状況では使えない

- 簡単だよ、という話
  - <https://www.slideshare.net/IkunaWada/acmssl>

# 機能別

## スケジュール実行

- AWS Lambda の Scheduled Event を試してみた #reinvent
  - <https://dev.classmethod.jp/cloud/aws/lambda-scheduled-event/>
- スケジュールされたイベントでの AWS Lambda の使用
  - <https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/with-scheduled-events.html>

## ClamAVと定義実行について

- Amazon LinuxにClamAVを導入する
  - <https://dev.classmethod.jp/cloud/aws/install-clamav-to-amazon-linux/>
- ClamAVのオンアクセススキャンついて
  - <http://tbpgr.hatenablog.com/entry/2017/04/20/080000>

## SpringBOot+SecureCookieについて

- 基本
  - <https://qiita.com/syukai/items/92d7dfc22b6ac34f9b87>

## S3 Buget + ELB(ALB) + CloudFront + Route53で「トップページだけはS3、ソレ以外はALB」という挙動を作る

- 基本的に「やること」（兄貴連携情報)
  - <https://tomokazu-kozuma.com/aws-cloudfront%E3%81%A8s3%E3%80%81albelb%E3%81%A7spa%E3%82%92%E6%A7%8B%E7%AF%89%E3%81%99%E3%82%8B/>
- [AWS]ELBがURLパスで振り分けできない問題はCloudFrontでなんとかする
  - <http://mil-o.jp/yb/elb-l7/>
- / 指定で index.html を表示
  - <https://qiita.com/onooooo/items/6839b5871b35451a0235>
  - 結局、CloudFrontの `Default Root Object` を使った
- S3の特定バケットへのアクセスを特定のCloudFrontからのみ許可する
  - <https://qiita.com/kooohei/items/2779f2755fb75ec3cc93>
- Route53とCloudFrontとS3で静的コンテンツをホスティングするメモ
  - <https://qiita.com/buta/items/06a7e147d865fb862783>
- S3+ACM+CloudFront+Route53で独自ドメインでhttpsホスティングする
  - <https://qiita.com/haracane/items/287f2a35c03e33683875>
- CloudFrontとS3のWebサイトをCloudFormationでさくっと作る
  - <http://www.h4a.jp/detail/31654>
- CloudFrontのキャッシュ削除
  - <https://dev.classmethod.jp/server-side/aws-amazon-cloudfront-deleting-cache-by-invalidation/>
- S3のバケットポリシーへの Principal 設定に CluodFront からの許可を追加する
  - <http://aimstogeek.hatenablog.com/entry/2017/09/29/191101>
- CloudFrontの「Restrict Bucket Access」と「Restrict Viewer Access」の違いがよくわからなかったので検証してみた
  - <https://doruby.jp/users/nakamatsu/entries/CloudFront%E3%81%AE%E3%80%8CRestrict-Bucket-Access%E3%80%8D%E3%81%A8%E3%80%8CRestrict-Viewer-Access%E3%80%8D%E3%81%AE%E9%81%95%E3%81%84%E3%81%8C%E3%82%88%E3%81%8F%E3%82%8F%E3%81%8B%E3%82%89%E3%81%AA%E3%81%8B%E3%81%A3%E3%81%9F%E3%81%AE%E3%81%A7%E6%A4%9C%E8%A8%BC%E3%81%97%E3%81%A6%E3%81%BF%E3%81%9F>
-
【AWS S3】S3 bucket policy を使ったアクセス制限方法 ~Effectの評価優先度を考える~
  - <http://aimstogeek.hatenablog.com/entry/2017/2/07/083643>

# 構築例

- 見積もりとほぼ同構成
  - <https://qiita.com/kite_999/items/6607d684412b14690901>
- 構築はしてないが、概念の説明
  - <http://stefafafan.hatenablog.com/entry/aws>
- さらにミニマムな構成例
  - <https://tech.recruit-mp.co.jp/infrastructure/retry-aws-minimum-vpc-server-environment/>
- 初心者向けSpringBootデプロイまで
  - <https://qiita.com/KevinFQ/items/119521ebd12bb7890761>
