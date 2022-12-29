---
layout: post
title: JenkinsとDockerで「SpringBootアプリがbranchにpushされるたびデプロイ」する
category: tech
published: true
tags: [jenkins,cd,ci]
---

[これ](https://www.slideshare.net/miurakazuhito/2015reviewrc-stac2015/47) や [これ](https://www.slideshare.net/miurakazuhito/jenkinsdocker/44) の時に使ったやりかた＋αを、ご紹介します。

コンセプトは「近所のPC一つでできる継続的デプロイ」。

# これを読んで得られるもの

- ご家庭で手に入る「CD環境」の作り方
  - 近所に空きPCあれば出来る継続的デプロイ
  - もちろんEC2等でも出来る
  - 一人で出来る

# かんたんなコンセプト構想&設計

以下の感じでやりたいと思います。

- SpringBootアプリ(のgitリポジトリ):CIサーバ を 1:1 と考える
- サーバ一台に `Jenkins` と `Nginx` と `Docker` をインストールし、使う
- `git` に `SpringBoot` 製のアプリがpushされるごとに、`Docker` 内にbranch別アプリが立ち上がる
- branchが存在している限り、CIサーバにHTTP(80)でbranch別アプリにアクセス出来る
  - `http://[CIサーバIPorホスト名]/[アプリのコンテキスト]/[branch名]`

雑い像はこんな感じです。

![全体象](/images/2017-10-19-overview.png)

## 他の前提

- CIサーバの筐体(あるいは仮想環境)は「比較的新し目のLinux」であれば問わない
  - サンプルでは `Amazon Linux` で動かします
  - サーバへは80,8080ポートがアクセス可能であること
- SpringBootアプリは「コントローラひとつ」程度のもの
  - DB等「外部になにも依存しない」サンプルです
  - [SpringBoot:1.5.8](https://projects.spring.io/spring-boot/) を利用

# やったこと

今回の"やること(やったこと)"は、すべて[このリポジトリ](https://github.com/kazuhito-m/continuous-deploy-par-branch-the-springboot-app)に置いてあります。

## LinuxのCIサーバに必要な道具を入れる

1. Jenkins
0. Docker
0. Nginx
0. その他ツール(git,java8)

のインストールを行います。

手動でやるなら、こんな感じ。(Amazon Linux前提)

```bash
# 必要なサービスと道具を一発インストール
sudo yum install docker nginx java-1.8.0-openjdk-headless git
# Jenkinsはリポジトリを足した後、インストール。
sudo sh -c "curl http://pkg.jenkins-ci.org/redhat/jenkins.repo > /etc/yum.repos.d/jenkins.repo"
sudo rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key
sudo yum install jenkins
sudo chmod +s /usr/bin/docker # ちょっと雑なことしてるけど、全ユーザから叩ける様に
```

この後、

- sshでサーバに入り、 `docker ps` が叩けるか
- ブラウザからhostのIP指定して、nginxのWelcome画面が出るか

くらいの確認をしておいてください。

※上記のインストール作業をAnsilbeのplaybookとしてAsCode[こちら](https://github.com/kazuhito-m/continuous-deploy-par-branch-the-springboot-app/blob/master/env/ci/main.yml)に置いてあります

## Jenkinsの初期設定処理

ここからは、ブラウザを使った手動作業です。

Jenkins(標準リポジトリからインストールすれば2.0系になる)に、初期設定をしてください。

1. ブラウザから <http://[お使いのhost名]:8080/> を叩く
0. 「Unlock Jenkins」の画面に、サーバ内から当該ファイルを表示してpassword入力
0. 「Customize Jenkins」の画面では「Install suggested Plugins」をクリック
0. 「Create First Admin User」で、Jenkinsの管理者情報を入力/Save
0. 「Star using jenkins」クリック

## Nginxの「設定ファイルの置き場」「管理コマンド」のパーミションを緩める

Jenkinsから「Nginxに対して任意の設定ファイルを置ける」ようにするため、`/etc` の中のディレクトリの権限を変更します。

```bash
sudo chmod u+w /etc/nginx/default.d/
```

また、ファイルを配置した後「設定読みなおし」もJenkinsにさせたいので、 `nginx` コマンドも、`root`以外から叩けるようにしましょう。

```bash
sudo chmod +s /usr/sbin/nginx
```

※このやり方は少々"乱暴"です。クラウドなど「外からアクセス出来るトコ」でやるなら、groupで縛るなりもう少しセキュアにしてください

一旦、CIサーバ作成作業は、ここで終了です。

## git上にSpringBootのアプリケーションを用意

皆様が「CIにかけたいSpringBootプロダクト」を格納したgitリポジトリをご用意ください。

今回の記事中では[こちら](https://github.com/kazuhito-m/continuous-deploy-par-branch-the-springboot-app)のリポジトリを対象にします。

ローカルで `./gradlew bootRun` すると、こんな画面が出るアプリです。

![サンプルアプリの画面](/images/2017-10-19-sampleapp.png)

## gitリポジトリに"Jenkinsfile"を作成

当該のgitリポジトリ直下に `Jenkinsfile` を作成します。

実際には、[このリポジトリのJenkinsfile]()を持ってきて、一番上の `APP_NAME` を好きな名前に変えればOKです。

中身を解説していきます。

## Jenkinsfile による「ビルドとアプリ起動」

```groovy
stage('Jar Build') {
 sh './gradlew build'
}
stage('Start Application in Docker container.') {
 def branchName = getBranchName()
 contextPath = '/' + APP_NAME + '/' + branchName
 def localJarDir = '/var/tmp' + contextPath
 containerName = APP_NAME + '_' + branchName
 // 既存のコンテナがあれば削除
 sh "docker rm -f ${containerName} || echo 'Container already exists. Delete container.'"
 // あろうがなかろうが「Jarを置くディレクトリ」を再作成
 sh "rm -rf ${localJarDir} && mkdir -p ${localJarDir}"
 // 予め作っておいたJarを移動
 sh "mv ./build/libs/*.jar ${localJarDir}/app.jar"

 // dockerコンテナを生成して、SpringBootアプリを起動。
 // その際、コンテキストパスを /[任意の名前]/[branch名] に変更
 def cmd = "docker run -d --rm --name ${containerName} -v ${localJarDir}:/usr/src/myapp -w /usr/src/myapp ${JDK_DOCKER_IMAGE_NAME} java -jar ./app.jar --server.contextPath=${contextPath}"
 sh cmd
}
```

ほぼコメントが語っていますが…

1. SpringBootのアプリを `executable jar` としてビルド
0. そのjarを `/var/tmp/[アプリの名前]/[branch名]` なディレクトリに移動
0. 上記のディレクトリをマウントした `docker container` を起動し、`java` コマンドでjarを起動

しています。

起動時に引数で「内部のコンテキストパスを変更している」のは、[以前の記事](/tech/2017/04/25/jenkins-url-path-shifted)でも触れたように「CSSなどファイル参照やリンクがおかしくなる」防止です。

この時点では、CIサーバ内で

__http://172.17.0.x:8080/[アプリの名前]/[branch名]/__

で内部でしかアクセス出来ないカタチ(172.17.0.x は「DockerコンテナのIP体系」)で立ち上がっています。


## Jenkinsfile による「アプリの外部公開」

```groovy
stage('Publish Application per branch by WebServer.') {
  // Dockerのコンテナ名から「内部のIPアドレス」を割り出し。
  def containerIp = getIpAddressByContainerName(containerName)
  // Nginxの設定ファイルとして「内部のコンテナを末尾ポートを削除した状態」で外へ公開する。
  sh "echo 'location ${contextPath} { proxy_pass http://${containerIp}:8080${contextPath}; }' > /etc/nginx/default.d/${containerName}.conf"
  // Nginxの管理コマンドを叩いて「設定ファイルの読みなおし」をさせる。
  sh 'nginx -s reload'
}
```

これまたコメントがほぼ解説ですが、

1. コンテナ名(起動時に割り振ってる)から内部のIP(172.17.0.x)割り出し
0. Nginxの設定ファイルを動的に書き出し
0. Nginxの「設定ファイル反映」をコマンド実行

しています。

「Nginxの設定ファイル」を、echoにより一行で吐いてるため、わかりにくいですが…

`/etc/nginx/default.d/[アプリ名]_[branch名].conf` というファイルを

```bash
location /[アプリ名]/[branch名] {
  proxy_pass http://172.17.0.x:8080/[アプリの名前]/[branch名]/;
}
```

という内容で吐いています。

コレにより、

```
http://172.17.0.x:8080/[アプリの名前]/[branch名]/ (内部のみ参照出来るアドレス)
↓
http://[CIサーバIPorホスト名]/[アプリの名前]/[branch名] (CIサーバ自体のアドレス)
```

という外部公開をしています。

---

という `Jenkinsfile` をリポジトリ直下に配置したら、commit&push をしておきます。

## Jenkinsに「Multibranch Pipelineジョブの登録」をする

CIサーバに戻り、JenkinsにSpringBootアプリのgitリポジトリがpushされるごとに動く「Multibranch Pipeline」のジョブを作成します。

![作成画面](/images/2017-10-19-create-job.png)

1. Jenkinsの「新規ジョブ作成」をクリック、ジョブ名を入力し「Multibranch Pipeline」を選択し「OK」クリック
0. できたジョブに「Branch Sources」から「Add source -> Git」を選び、gitリポジトリのURL入力
  ![git指定](/images/2017-10-19-git-settings.png) ※privateなリポジトリなら、「認証情報」をセットしてください
0. 「Build Configuration」は「Mode:by Jenkinsfile」「Script Path:Jenkinsfile」のまま
0. 「Scan Multibranch Pipeline Triggers」から「他のビルドが起動してなければ定期的に起動」をチェック
0. 「間隔」に「gitをポーリングしたい時間」を指定(自分は何も考えないで1 minuteとしてるが…)
0. 「保存」ボタンをクリック

保存した直後に `scan` が始まり、 `master` branchの `Jenkinsfile` を検出、その定義通りのパイプラインが実行されます。

![Multibranch pipeline全景](/images/2017-10-19-master-branch-search.png)
![Stage View 全景](/images/2017-10-19-pipeline-overview.png)

パイプライン(`Jenkinsfile` の内容)が、全て成功していれば、

__http://[CIサーバIPorホスト名]/[アプリの名前]/[branch名]__

で「 `master` branchをjarビルド/デプロイしたアプリ画面」が閲覧できるはずです。

![デプロイされたアプリの画面(master branch)](/images/2017-10-19-success-deploy-master.png)


## 別branchを作って「デプロイされるか」を確認する

別branchを作り、少し変更しcommit&pushしてみます。

![差分とbranch名](/images/2017-10-19-push-anther-branch.png)

すると、先ほど作成したジョブに検知されて、ビルド/デプロイが走ります。

![違うbranchに呼応して実行された](/images/2017-10-19-build-another-branch.png)

今回、branch名を `another-branch-for-cd-test` としてpush、HTMLの一部を変更しているので、branch名をコンテキストパスに含むURLでアクセスすると…

![違うbranchのビルド/デプロイされたアプリ](/images/2017-10-19-another-branch-app.png)

期待通り「別branchのアプリがデプロイされた」のが見れますね。

## 無くなったbranchへの追随(デプロイしたアプリの終了)

これでbranchごとにpushタイミングでデプロイされるようになりましたが、branchが削除されてもDockerコンテナは削除されません。

このままではDockerコンテナが無尽蔵に生成され、CIサーバがパンクするでしょう。

そこで「削除されたbranchと対応するコンテナ(と設定ファイル)は削除する」ようにします。

「現在、アクティブなリモートbranch」を割り出し、それと __対を成さない__

- Dockerコンテナ
- ワークディレクトリ(jarを置いてあるところ)
- Nginxの設定ファイル

を、削除するような `Jenkinsfile` を作成し、任意のタイミングで実行させます。

ここでは [Jenkinsfile_maintenance](https://github.com/kazuhito-m/continuous-deploy-par-branch-the-springboot-app/blob/master/Jenkinsfile_maintenance) と名付け、リポジトリの直下に置きました。

これを `パイプライン` のジョブに登録し、一日一回くらい回しておけば、パンクすることは無いでしょう。

![タイミングの指定](/images/2017-10-19-delete-container-scheule.png)
![リポジトリとJenkinsfileの指定](/images/2017-10-19-delete-container-set-jenkinsfile.png)


# 制約・課題

作りの問題で、いくつかの制約と課題があります。

## 制約

- gitのbranch名は「URLのPathに使えるもの」のみで運用する必要あり
  - `/` はダメ、英数と `_` `-` はOK

## 課題

- gitの変更検知はポーリングを選んだが、Webhookに変更するのが望ましい
- 「Dockerでアプリが正しく起動できたか」は見ていない、非同期で完了してしまう
- デプロイ後、ユーザに「このアドレスですよ」を知らせていない
  - ここをSlack通知するのは比較的簡単
- logなどの考慮がない
  - せめて「Hostの/var/logにbranch名を含むファイル名で出す」などしたい
  - CIサーバにFuluentdなど入れて収集できればgood
  - 外側から観られるようになればなおgood

---

# 運用をしていく上で

「アプリが単一でメチャクチャ軽い」「CIサーバの資源がある程度ある」というように、いろいろと極端な例のサンプルになっていますが、実際運用するときには、

- データ(大体はRDBMS)の考慮
  - Dockerコンテナの中にRDBMSもってしまってデプロイ都度マイグレーション
  - 外部にペアとしてDBのインスタンスを多量にプールしてマイグレーション
- CIサーバの性能問題
  - 割りかし強靭なサーバを使う(現場の余剰サーバにメモリをガン積み、とか)
  - Dockerサーバをスケール可能に( `docker swarm` 使うとか)
- サービスが多岐のサーバ構成にわたる
  - デプロイ時に立ち上げる構成に `docker-compose` を検討

と「アプリに応じて」の設計が必要だと思います。

また、「CIがJenkins依存」「1サーバに依存するのはどうか(引き剥がせない)」という議論があると思いますが、ここは割り切りで

__「自身プロジェクト用の"CD専用のサーバ"とする(CI等とは別の枠組みでやる)」__

という位置づけで”別立て"しといたら良いかな？と考えます。

# 所感

恐らく(詳しくは調べていなけれど)「金の実弾をマシンガンすれば出来る」系のはなしだとは思います。

でも、仕事であれば「稟議が…」等で「継続的デプロイが遠いもの」になってしまうことがしばしばかと。

そうなるくらいなら「近所に落ちてるPCで」「なんなら自分のマシンで」気軽に出来たら…と思い書いてみました。
