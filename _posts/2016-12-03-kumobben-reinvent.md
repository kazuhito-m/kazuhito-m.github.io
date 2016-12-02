---
layout: post
title:  勉強会行ってみた「雲勉【勉強会:新技術好き!】AWS re:Invent 2016 速報共有会」#kumoben
category: study-meeting-repo
tags: [aws,cloudpack,reinvent,cloud]
---

昨日の事になりますが、まあ備忘録なので…。

# 情報

+ 日付 : 2016/11/28(月)
+ [申し込みサイト](https://kumoben.doorkeeper.jp/events/53338)
+ ハッシュタグ : [#kumoben](https://twitter.com/search?q=%23kumoben)
+ 何するのか : 11/28からラスベガスで行われていた `AWS re:Invent 2016` の内容を、`CloudPack`のiret大阪オフィスの識者の皆様によるテーマ別＆日本語解説付きで知ることが出来る勉強会

# なんで来たん？

自分は、AWSに関しては後発（8年遅れ）で、使ったプロダクトも3〜4程度…。

こうなると、ほっとくと「最新を追う」こともしなくなる…のにたいして「せめて触り程度でも…」と `re:Invent` で発表されたものの情報を藁つかむ感じで得に来ました。

# 内容

以下、「全体的に新プロダクトを触れる」のスライドの発表がありましたので、メモと「一言感想」あれば下に書きます。

## 序盤15分

遅刻していったので、序盤はのがしてます。

(電車乗り間違えた…とか言えない)

## [AWS Greengrass](http://jp.techcrunch.com/2016/12/01/20161130aws-greengrass-brings-lambda-to-iot-devices/)

- LambdaのコードをPythonでかけば、「IoTデバイス上で動かせる」 仕組み
  1. コードはクラウド上で書き
  0. クラウド上でテストし
  0. IoTデバイスへと”デプロイ”する
- IoTデバイスは、メモリ128MB、1GHz以上のx86orARMが必要
- 金額は、月額0.16$/一台
  - 一般供給開始後は、3デバイス一年無料
- 制約は、最大デバイス10,000台

コンセプトだけは解ったのですが、「認定デバイスとかあるのか？」「そのデバイスをAmazonから買う/借りるとかできるのか？」とかが疑問としてありました。

…IoTデバイスって「ウェアラブルなどカタチが無限」なので、「準拠」ってそもそも考えられるんやろか…。

## [AWS Snowmobile](http://www.publickey1.jp/blog/16/100pbaws_snowmobileaws_reinvent_2016.html)

- AWS Snowballエキサバイトのデータ移行サービス
- トレーラーで運ぶ

[VMWareのサービスでよく似たハナシを聞いてた](http://www.networld.co.jp/product/vmware/pro_info_cloud/vcloudair/)ので、「データ転送も一定のしきい値を超えると物理輸送に負けるのか…」と思って「ドッグイヤーの進化が負ける分野」を見た気がします。

## [AWS Snowball Edge](https://aws.amazon.com/jp/blogs/news/aws-snowball-edge-more-storage-local-endpoints-lambda-functions/)

- S3 API,NFS
- Lambdaを内包できる
- 日本に来てない
- Lambdaファンクションの実行は無料

データサービスでありながら「Lamdaが実行できる」というのが、もうひとつピンときませんでした。

…どこか「エントリイベント」があって、そこを通過した時に加工できる、とかかなー？

## [AWS Code Build](https://aws.amazon.com/jp/blogs/news/aws-codebuild-fully-managed-build-service/)

- ビルドとテストができるマネージドサービス
- ソースリポジトリとして、AWSさん CodeCommit,Github,S3
- CodePipelineととも連携したCI/CD環境を実現
- セットアップ済でスケール、分単位での実行時間課金

[いち早い日本の方のレビュー](http://qiita.com/numa08/items/8cbb602dea429c1c494b)があったので、眺めています。

Travisを始めとする「CI as a Service」「Build as code」のAmazon版、という認識で良いのでしょうかね。

基本、「CIは頻繁なもの」「デプロイは時折」なので、自動で動かすには「時間貸しの試算がしたい」「ユースケースを想定したざっくり見積もり」をしたくなりました。

## [AWS X-Ray](https://aws.amazon.com/jp/blogs/news/aws-x-ray-see-inside-of-your-distributed-application/)

- EC2,ECS,Beanstalk,APIGatewayその他の基盤上で実行される
- コードからトレースデータを補足できるサービス

すごいありがたい機能だ！と思ったのですが、「プログラムに仕込みが要る」ときいて「まあ…そうだよなあ」と思いました。

AOP的に仕込めたら楽なのになぁ。 (コードの仕込み方を見ずに言ってますが)

## [RDS Aurora PostgreSQL](https://aws.amazon.com/jp/blogs/news/amazon-aurora-update-postgresql-compatibility/)

- AuroraのPostgreSQL版

そもそもAuroraの最初の印象が「あー、AuroraがPostgresに対して作られていたら良いのに…」だったので、凄く自然かつしっくりくる！ 俺得ですねｗ

## [AWS Pinpoint](https://aws.amazon.com/jp/blogs/news/amazon-pinpoint-hit-your-targets-with-aws/)

- ユーザエンゲージメント促進
- ユーザ行動理解
- ターゲットにするユーザを定義
- キャンペーン結果を追跡

## [AWS Glue](http://dev.classmethod.jp/cloud/aws/aws-glue-is-coming-soon/)

- データカタログの作成とデータ加工・ロード(ETL)が実現可能なマネージドサービス
- S3,RDS,Redshiftその他JDBC対応データをサポート

「スケジューリングとルートの設定が可能なデータコンバートサービス」なのでしょうか？

たとえば「分析用データを退避（夜間バッチで）」とかに使うイメージでしょうか？

## [Lambda@Edge](http://dev.classmethod.jp/cloud/aws/reinvent-2016-aws-lambda-at-edge/)

- Lambdaベースの処理をCloudFrontのエッジロケーションで実行し、リアルタイムにヘッダー、URLなどの編集か可能なサービス
- Node.jsで記述
- 利用可能メモリは128MBで実行時間の上限は50ms

キャッシュサービスをプログラマブルに制御可能にしてくれる、ってことかな？

`AWS Snowball Edge`と同じで「どこに何を挟むのだろう？」は疑問です。(調べろってのｗ)

## [AppStream 2.0](http://dev.classmethod.jp/cloud/amazon-appstream-2/)

- 描画処理を得意とするゲームアプリ配信基盤で提供してたが、2.0では汎用的なデスクトップアプリを配信

「具体的に企業等で使うユースケースは…」と考えて、「内部監査アプリや自社基幹デスクトップアプリを全社配信したい」とかかな？とは思いましたが、そうなんかな？

---

数分の休憩

---

## [EC2 System Manager](http://dev.classmethod.jp/cloud/aws/amazon-ec2-systems-manager/)

- ES2インスタンス、オンプレミスの構成管理を自動化できる
- EC2 System Mangerは無料で利用

自動化と聞いて「おれは知っときたい！」とは思うものの「ちょっとAWSの独自の概念覚えなあかんかな？」と。

## [AWS Batch](http://dev.classmethod.jp/cloud/aws/batch/)

- フルマネージド型のバッチ処理実行サービス
- ジョブ登録したアプリ・コンテナイメージをスケジューラが実行
- AWS Batchの料金は無料
  - 起動したリソースについて課金

すげえパワーワードですが、最後の `AWS Step functions` の印象とかぶってて、余り記憶に残ってないｗ

個人的には「AWSはタイマーが弱い」と思ってるので、無料なら使うと思います。(なんか難解な仕込みを必要としないならば)


## [Amazon Polly](https://aws.amazon.com/jp/blogs/news/polly-text-to-speech-in-47-voices-and-24-languages/)

- フルマネジの"Text-to-speach"機能

自分は「XFD代わり」をするためOpenJTalkでやってるけど、その理由は「世にサービスはあるがWebをまたぐが嫌」「金がない」で、しかし「自力でやると遅い」「発声が変」が付きまとうので「安い」「早い」なら使いたいなぁと思いました。

サンプルを聞きましたが精度は凄い！

「公共機関のアナウンスがすべてPolly製のものに置き換わる」未来が少しみえた…かも？

## [OpsWorks for Chef Automate](http://dev.classmethod.jp/cloud/aws/reinvent2016-opsworks-chef/)

- Chefサーバが使える

以前、OpsWorksを検証した際「インハウスのサーバ欲しいな…」と思った記憶があるので、個人的には考えやすくなるかもしれません。

## [ECS向けのオープンソーススケジューラBlox](http://jp.techcrunch.com/2016/12/02/20161201aws-launches-blox-a-collection-of-open-source-tools-for-the-ec2-container-service/)

- ECS向けのコンテナ管理及びオーケストレーション・ツール群
- OSS

「コンテナ」「タイマー」「OSS」と「俺の好物てんこ盛り」なので、興味はあるのですが…いかんせん「ECSに良い印象を持ってない」ので…ま、おいおい見てこうかなと。

## [Amazon Lightsail](http://dev.classmethod.jp/cloud/aws/lightsail-config/)

- 単純な構成のサーバ必要時に

AMIよりもっと「ユースケースを(金額のプランなどまで)一式でコーディネート」された、インスタンス立ち上げ機構でしょうか？

「必要用途のサーバを爆速で立ちあげれる」は、コンテナの用途と同じく開発者には嬉しい…かも？

## AWS Shield

- マネージドDDoSプロテクションサービス
  - 無償版の `AWS Shield for Everyone`
  - 有償版の `AWS SHield Advanced`

# 特集

後半は「１つのAWSプロダクトに対して(おそらく専門の)お一方ずつ発表してただく」形式のセッションでした。

## [AWS Personal Healsth Dashboard](https://aws.amazon.com/jp/blogs/news/aws-shield-protect-your-applications-from-ddos-attacks/)

- 顧客保有のAWSリソースのメンテナンスイベントを集約するダッシュボード機能を提供
- 「影響を受けるAWSサービスのメンテ」をダッシュボードに表示
- CloudWatch EventやLambdaに連携
  - 3rd Party製の監視システム連携も可能

## [AWS Step functions](https://aws.amazon.com/jp/blogs/news/new-aws-step-functions-build-distributed-applications-using-visual-workflows/)

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

なんとなく「AWSの相談として”業務的な夜間バッチ”ばっかりだったのかな？」と勘ぐるくらいのラインナップですねｗ (`AWS Batch` といい…)

たしかに、「Lambdaは”ソースの再利用”,"チェインしていくような構造づくり"が不便」だと思ってたので、ありがたいです。

…が「ビジュアライズはありがたいけど、デバッグやテストしにくいJSONに責務が寄る」のは、ちょっと辛いかなと。
※くわしく調べてないので、調べるとものすごく便利な手段が提供されてるかもしれません、と付け加えておきます。

---

## 小並感

「使ってないし…使ったりして多くのプロダクトに詳しくなろう」…と思っていたのですが、今や「プロダクトの数が全部触れるとか現実的ではない量」となっていて、自身にはもうムリくさい感じがしてきました。

今後は

- 全体的なプロダクト名前と概要(何が出来るか)が言える程度の把握
- 自身の興味 & 強みとしている分野のAWSプロダクトに関する探求

という感じの追っかけをしていこうかな？と思いました。

自身はCD/CIに興味があるので、今回の発表なら `AWS Code Build` とかはウォッチしていたいかなー。
