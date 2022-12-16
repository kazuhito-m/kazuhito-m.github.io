---
published: true
layout: post
title: 各種CI/CDサービスでの結果をDiscordへ通知する
category: tech
tags: [cicd, circleci, githubactions, tips]
---

## これを読んで得られるもの

- いくつかのCIサービスでの「Webhookを使ったNotification(通知)のやり方」を知れる

## 自分用チャットサービスをSlackからDiscordに移動したのですが…

TODO ようやく:世のサービスはSlack専用の連携機能を備えているが…

## 前提

- Discordで通知したいチャンネルへのWebhookを作成済み
  - [こちらの手順](https://support.discord.com/hc/ja/articles/228383668) で、すでにWebhookのURLは取得している

## 仕込み方

### CircleCI

サービス自体に機能は在りません(Slackは埋め込みで在る)し、yamlにも組み込み構文等は無いのですが、Orbs(CircleCIのプラグインのようなもの)に有志が作ったDiscord通知用のものが在ります。

- Source: <https://github.com/antonioned/circleci-discord-orb>
- Document: <https://circleci.com/developer/orbs/orb/antonioned/discord>

上記のSource `README` にある「書き方のサンプル」を元に、 `./.circleci/config.yml` に `discord/status` 記述を追加して下さい。

### CircleCIの環境変数

サンプルは「環境変数を使う例」で書かれているため、サンプルどおりそのまま実践するためには、CircleCIの環境変数も仕込む必要があります。

チーム等で「複数のプロダクト」を担当しているのであれば [OrganizationのContext](https://circleci.com/docs/ja/contexts/) を利用すると、「複数プロダクトで環境変数共有できる」ので、Discordの同一チャンネルのWebhookURLを共有できて便利かと思います。(プロダクトごとにチャンネルを分けたほうがわかりやすいかもですが)

### Orbを有効にするには

Orbsを使うには、当該組織(Organization)のセキュリティ設定で「Orbsを使う」設定を行う必要があります。

詳しくは[この記事](https://www.kaizenprogrammer.com/entry/2018/12/01/111145)の `Orbsのセキュリティ設定` の手順に従い確認してください。



## 所感

Game文化かつラフ〜な感じのDiscord、自分は好きなんですが「自動化の情報」がSlackより少ない気がしています。(特に日本語情報)

なので、応援する意味でも「仕込み方」を紹介できたらなと思い、記事にしました。

ま、何より「自分こそが困ってる」ですしねー。

## 参考資料

- https://medium.com/tarmac/sending-circleci-job-notifications-to-discord-8bebc935637e
- 

