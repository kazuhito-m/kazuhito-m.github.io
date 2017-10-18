---
layout: post
title: JenkinsとDockerで「SpringBootアプリがbranchにpushされるたびデプロイ」する
category: tech
published: false
tags: [jenkins,cd,ci]
---

[これ](https://www.slideshare.net/miurakazuhito/2015reviewrc-stac2015/47) や [これ](https://www.slideshare.net/miurakazuhito/jenkins20-7jenkins-jenkinsstudy/25) の時に使ったやりかた＋αを、ご紹介します。

コンセプトは「近所のPC一つでできる継続的デプロイ」。

# これを読んで得られるもの

- ご家庭で手に入る「CD環境」の作り方

# 経緯


## nginxでの例

こんな `test.conf` ファイルを作り…

```
server {
    listen 80;
    location /jenkins {
        proxy_pass http://172.17.0.1:8080/; # Dockerコンテナ内から見た親サーバ
    }
}
```

`nginx` を起動 (docker経由)

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
