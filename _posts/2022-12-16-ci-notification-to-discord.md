---
published: true
layout: post
title: 各種CI/CDサービスでの結果をDiscordへ通知する
category: tech
tags: [cicd, circleci, githubactions, tips]
---

## これを読んで得られるもの

- いくつかのCIサービスでの「Webhookを使ったNotification(通知)のやり方」を知ることができる

## 自分用チャットサービスをSlackからDiscordに移動したのですが…

TODO ようやく:世のサービスはSlack専用の連携機能を備えているが…

TODO 方針としては「できるだけ書かない」「公式・準公式で用意している仕組みを利用する」

## 前提

- Discordで通知したいチャンネルへのWebhookを作成済み
  - [こちらの手順](https://support.discord.com/hc/ja/articles/228383668) で、すでにWebhookのURLは取得している

## CIサービスへの設定方法

### Github Actions

`Github Actions` には、「CI自体の機能として通知用のWebhookを指定する」ような箇所はありません。

そのため「ワークフローファイル記述し、自力で飛ばす」必要があります。

([Githubへの操作を通知する手段](https://qiita.com/Papillon6814/items/7bfd95cbd1b5a80afb92)は在りますが「CIがコケたら」とかではありません。)

自力は自力なのですが、共通部品として便利な `Actions` というものを使うことが出来ます。

https://github.com/marketplace から `Discord` を検索すると、50以上の `Actions` が見つかります。

![Actionsを”Discord”で検索した結果](/images/2022-12-16-actions-list.png)

一番Starが多かった [Actions for Discord(Ilshidur/action-discord)](https://github.com/marketplace/actions/actions-for-discord) を使って実現してみます。

#### 実装例1

ワークフローファイルのyamlに

```yaml
- name: Notify Discord
  uses: Ilshidur/action-discord@master
  env:
    DISCORD_WEBHOOK: $\{\{ secrets.DISCORD_WEBHOOK_URL \}\}
  with:
    args: |
      \{\{ GITHUB_REPOSITORY \}\} のテストが失敗しました。
      \{\{ GITHUB_SERVER_URL \}\}/\{\{ GITHUB_REPOSITORY \}=}/actions/runs/\{\{ GITHUB_RUN_ID \}\} を確認して下さい。
  if: failure()
```

のように書くと

![GithubActionsの通知をDiscordに出してみる_その1](/images/2022-12-16-actions-discrod-notify-01.png)

のように通知されました。

#### 実装例2

前述例1は、本体部分がすべて自分なので自由に書けて良いのですが、もうちょっと楽に書式が整った表示をしてほしいなと思いました。(警告なら赤色とかにしたいし)

そこで「作者にコンタクトを取ること」も考慮して、[日本の方が作られたActions](https://note.sarisia.cc/entry/actions-status-discord/) を使わせて貰おうと思います。

```
- name: Notify Discord
  uses: sarisia/actions-status-discord@v1
  with:
    webhook:
      ${{ secrets.DISCORD_WEBHOOK_URL }}
  if: failure()
```

と書くと、

![GithubActionsの通知をDiscordに出してみる_その2](/images/2022-12-16-actions-discrod-notify-02.png)

おお、ほしかった感じの結果です。満足しました。

--- 

前述の2例のように「良い感じの `Actions` を自ら選んで仕込む」というのが、ActionsからのDiscrod通知の仕込み方のようです。

#### 組み込み変数

前述の例にあった `GITHUB_RUN_ID` など、ワークフローファイル内では` Githubが用意している組み込み変数` が使えます。

[公式ドキュメントの一覧](https://docs.github.com/ja/actions/learn-github-actions/environment-variables#default-environment-variables) から、自身が表示したい情報の変数を探すと良いでしょう。

#### Srcrets(機密情報)

前述の例にあった `secrets.DISCORD_WEBHOOK_URL` など「ワークフローファイル内で使える自身が定義する変数」は、 `Srcrets(機密情報)` としてGithubActions側に登録するのが定石のようです。

[公式ドキュメント](https://docs.github.com/ja/actions/security-guides/encrypted-secrets) によれば、「Organizationごと」「リポジトリごと」「environmentごと」のレベルで登録出来るので「で複数リポジトリを同一チャンネルに流したい」などあれば、OrganizationレベルでWebhook情報を登録すれば良いかもしれません。

### CircleCI

こちらも、サービス自体に機能は在りません(Slackは埋め込みで在る)し、yamlにも組み込み構文等は無いのですが、Orbs(CircleCIのプラグインのようなもの)に有志が作ったDiscord通知用のものが在ります。

- Source: <https://github.com/antonioned/circleci-discord-orb>
- Document: <https://circleci.com/developer/orbs/orb/antonioned/discord>

上記のSource `README` にある「書き方のサンプル」を元に、 `./.circleci/config.yml` に `discord/status` 記述を追加して下さい。

#### 実装例

`.circleci/config.yml` に

```
version: 2.1

orbs:
  discord: antonioned/discord@0.1.0

jobs:
  xxx:
    steps:
      ...
      - discord/status:
          fail_only: true
          failure_message: "Triggered User: **${CIRCLE_USERNAME}**\\nBranch: **${CIRCLE_BRANCH}**\\n\\nCircleCI テストに失敗しました。 JOB: **$CIRCLE_JOB**"
          webhook: "${DISCORD_WEBHOOK}"
```

のように書くと

![CircleCIの通知をDiscordに出してみる](/images/2022-12-16-circleci-discord-notify.png)

のように通知されました。

#### CircleCIの環境変数

ドキュメントの例は `DISCORD_WEBHOOK` など「環境変数を使う例」で書かれているため、サンプルどおりそのまま実践するためには、CircleCIの環境変数も仕込む必要があります。

こちらも、チーム等で「複数のプロダクト」を担当しているのであれば [OrganizationのContext](https://circleci.com/docs/ja/contexts/) を利用すると、「複数プロダクトで環境変数共有できる」ので、Discordの同一チャンネルのWebhookURLを共有できて便利かと思います。

#### Orbを有効にするには

Orbsを使うには、当該組織(Organization)のセキュリティ設定で「Orbsを使う」設定を行う必要があります。

詳しくは[この記事](https://www.kaizenprogrammer.com/entry/2018/12/01/111145)の `Orbsのセキュリティ設定` の手順に従い確認してください。

#### 余談

久しぶりにCircleCIを見たら「githubからのソースcheckoutできなくなっていた」ので直しました。

- [
CircleCIのGitHub連携でPermission denied (publickey)が起きたときの対処](https://koic.hatenablog.com/entry/circleci-error-github-permission-denied)


## 所感

ゲーム文化で、かつラフ〜な感じのDiscord、自分は好きなんですが「自動化の情報」がSlackより少ない気がしています。(特に日本語情報)

なので、応援する意味でも「仕込み方」を紹介できたらなと思い、記事にしました。

ま、何より「自分こそが困ってる」ですしねー。

「Webhookがあれば、自力で書きゃあなんでも出来る」のは解ってるのですが、できるだけ楽に、できるだけオフィシャルな手段で、実現したいのです。

「もっと公式推奨の手段があるよ」などの情報あれば、教えて下さい。

## 参考資料

- GithubActions周り
  - <https://docs.github.com/ja/actions/learn-github-actions/environment-variables#default-environment-variables>
- CircleCI周り
  - <https://medium.com/tarmac/sending-circleci-job-notifications-to-discord-8bebc935637e>
- 今回実際に実装したリポジトリ
  - <https://github.com/kazuhito-m/java-odf-edit-sample>