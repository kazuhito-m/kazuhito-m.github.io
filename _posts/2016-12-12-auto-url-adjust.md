---
published: false
layout: post
title: SpringBootで「どこにデプロイされてもcontext-pathを自動的に調整する」Webアプリを作る
category: tech
tags: [java,springboot,web,ci]
---

地味だけど…わりかし「こうなってたら便利だなー」を昔から思ってるモノを実現します。

# これを読んで得られるもの

- SpringBootで「どこにデプロイされてもcontext-pathを自動的に調整する」機能
  - その実現方法

# 経緯

WebアプリをJava系(War,もしくはSpringBootならjar(内蔵tomcat))で作ると、デフォルトではコンテキストぱすは `/` 前提で動きます。

![例はJenkins](./images/2016-12-12-jenkins.png)

※例は「ローカルにインストールしたJenkins」の最初の画面です。

これに対して、以下の設定など書いてhttpサーバで「外からの要求のコンテキストパス」をずらすと…

```bash
http {
  server {
    listen 80;
    location /jenkins {
        proxy_pass http://localhost:8080/;
    }   
  }
}
```

※例はnginxの設定例で「http://localhost/jenkins を指定されたら、内側から http://localhost:8080 へ転送する」という設定

![内部pathがズタズタに成るの図](./images/2016-12-12-jenkins-ng.png)

そのため、多くのWebアプリ/システムでは、「コンテキストパスを指定できる画面/設定ファイル」などを用意します。

…が、これだと「ビルドするときにその値を練り込む」や「起動時にコマンド引数から指定する」など、依存性との戦いになります。

それを「なんとか__自分で勝手にあんじょうようやってくれる__ように出来ないか？」というのが今回の主旨です。

# やったこと

今回、対象としているプログラムは [こちら](https://github.com/exemplary-buildpipeline-projects/studyosaka8-jenkins-docker-app) です。

## SpringBootアプリで「コンテキストパス変更」に対応する

SpringBootには「コンテキストパス変更」が設定ファイルがすでにあります。

[spring boot で context-pathを設定する](http://huruyosi.hatenablog.com/entry/springboot%E3%81%A7context_path)

`application.yml` の `server.contextPath` を変更するだけ。ま、設定的にはこれだけです。

が、アプリには対応が必要です。コントローラは無改造で良いとして、「thymeleafのviewテンプレート」を使っているなら…

```html
<link href="/style.css" rel="stylesheet" />
↓
<link th:href="@{/style.css}" rel="stylesheet" />
```

のように `th:` なアトリビュートと `@{}` で囲む必要があります。

逆に言えばこれだけで対応出来ます。楽ですね。

## 動的に「コンテキストパス変更」が出来るか確かめる

## アプリ起動後の「初回リクエスト時のURL」から割り出して記憶する


---

# 小並感


# 参考資料

以下を参照しました。感謝！

- [http://huruyosi.hatenablog.com/entry/springboot%E3%81%A7context_path](http://huruyosi.hatenablog.com/entry/springboot%E3%81%A7context_path)
- [http://qiita.com/NewGyu/items/d51f527c7199b746c6b6](http://qiita.com/NewGyu/items/d51f527c7199b746c6b6)
