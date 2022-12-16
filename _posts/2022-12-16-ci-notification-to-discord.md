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

サービス自体に機能は在りません(Slackは埋め込みで在る)し、yamlにも組み込み構文等は無いのですが、Orb(CircleCIのプラグインのようなもの)に有志が作ったDiscord通知用のものが在ります。

- https://github.com/antonioned/circleci-discord-orb

上記のREADMEに「書き方のサンプル」を元に、 `./.circleci/config.yml` に `discord/status` 記述を追加して下さい。

## 所感

Game文化かつラフ〜な感じのDiscord、自分は好きなんですが「自動化の情報」がSlackより少ない気がしています。(特に日本語情報)

なので、応援する意味でも「仕込み方」を紹介できたらなと思い、記事にしました。

ま、何より「自分こそが困ってる」ですしねー。

## 参考資料

- https://medium.com/tarmac/sending-circleci-job-notifications-to-discord-8bebc935637e
- 

