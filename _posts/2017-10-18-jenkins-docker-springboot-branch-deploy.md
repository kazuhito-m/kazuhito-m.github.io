---
layout: post
title: JenkinsとDockerで「SpringBootアプリがbranchにpushされるたびデプロイ」する
category: tech
published: false
tags: [jenkins]
---

まえからやりたかたことができたので、紹介します。

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
