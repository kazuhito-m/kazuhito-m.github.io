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

# かんたんなコンセプト/設計

以下の感じでやりたいと思います。

- SpringBootアプリ(のgitリポジトリ):CIサーバ を 1:1 と考える
- サーバ一台に `Jenkins` と `Nginx` と `Docker` をサーバにインストールし、使う
- `git` に `SpringBoot` 製のアプリがpushされるごとに、`Docker` 内にbranch別アプリが立ち上がる
- branchが存在している限り、CIサーバにHTTP(80)でbranch別アプリにアクセス出来る
  - `http://[CIサーバ]/[アプリのコンテキスト]/[branch名]`

雑い像はこんな感じです。

![全体象](/images/2017-10-18-overview.png)

## 他の前提

- CIサーバの筐体(あるいは仮想環境)は「比較的新し目のLinux」であれば問わない
  - サンプルでは `Amazon Linux` で動かします
  - サーバへは80,8080ポートがアクセス可能であること
- SpringBootアプリは「コントローラ一丁」程度のもの
  - DB等「外部になにも依存しない」サンプルです
  - [SpringBoot:1.5.8](https://projects.spring.io/spring-boot/) を利用

# やったこと

今回の"やること(やったこと)"は、すべて[このリポジトリ](https://github.com/kazuhito-m/continuous-deploy-par-branch-the-springboot-app)に置いてあります。

## LinuxのCIサーバに必要な道具を入れる

1. Jenkins
0. Docker
0. Nginx
0. git,java8

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

## gitリポジトリに"Jenkinsfile"を作成

当該のgitリポジトリ直下に `Jenkinsfile` を作成します。




# 制約・課題

作りの問題で、いくつかの制約と課題があります。

## 制約

- gitのbranch名は「URLに使えるもの」のみ(`/`はOK)で運用する必要あり

## 課題

- 「Dockerでアプリが正しく起動できたか」は見ていない、非同期で完了してしまう
- 



---


# 運用時

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
