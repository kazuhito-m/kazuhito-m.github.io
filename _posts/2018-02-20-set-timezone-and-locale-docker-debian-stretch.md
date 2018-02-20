---
published: true
layout: post
title: debian:stretchのイメージを使ったDockerfileでタイムゾーンとロケールを日本に変更する
category: tech
tags: [docker,debian,locale,timezone]
---



# これを読んで得られるもの

- debian:stretchのイメージを使ったDockerfileでタイムゾーンとロケールを日本に変更する方法
  - 最適かはわからないがハマらない方法

# 経緯

よくやってるはず…のこの設定に「意外と時間を取られた」ので備忘録です。

# やったこと

`Dockerfile` のはじめに、以下を書きます。

```Dockerfile
FROM debian:stretch
MAINTAINER xxx

# タイムゾーンとロケールの設定
RUN ln -sf  /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
  && apt update -y \
  && apt install -y locales \
  && locale-gen ja_JP.UTF-8 \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
ENV LANG ja_JP.UTF-8  
ENV LANGUAGE ja_JP:en  
ENV LC_ALL ja_JP.UTF-8

...
```
---

よく「生Debianを設定する」時に使用される、 `timedatectl` , `task-japanese` などは「インストールできても設定に使え無かった」ので、上記のカタチにしました。

# 所感

もう少し簡易な方法があるかもしれませんが「とりあえず動く設定を手っ取り早く手に入れる」のであればこれでいいかなぁと。

# 参考

以下を参考にさせていただきました。

- <https://qiita.com/suin/items/856bf782d0d295352e51>
