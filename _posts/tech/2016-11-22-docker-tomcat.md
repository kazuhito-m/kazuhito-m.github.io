---
layout: post
title: Dockerでtomcatを手早く立てる(コマンド備忘)
category: tech
tags: [docker,tomcat]
---

ただたんなる、自分用のコマンドの備忘録です。

## コマンド

```bash
mkdir webapps
docker run -d -p 8080:8080 -v $PWD/webapps:/usr/local/tomcat/webapps --name tomcat9 tomcat:9.0-jre8-alpine
```

あとは、作った './webapps' に起動させたいwarを配置(予め入れとくのも可)して、[http:/localhost/[放り込んだwarのコンテキスト]](http://localhost/[放り込んだwarのコンテキスト]) を参照すれば、環境汚さず一時的にサーバ上げて殺す、みたいなことが出来ます。

(tomcatのバージョン変えたければ、[こちら](https://hub.docker.com/r/library/tomcat/) からサポートされてるバージョン(イメージVer名)を探し、 コマンド中の `tomcat:` 以降を変更してください。)
