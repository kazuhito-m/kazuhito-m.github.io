# DroneIOでCI結果をSlackに通知する設定を加える

## ネタ元

ま、この通りにトレースするだけです。

[http://addons.drone.io/slack/](http://addons.drone.io/slack/)

## やり方

1. Githubリポジトリ直下に `.drone.yml` 作る
0. 以下の設定を書く

```yml
notify:
  slack:
    webhook_url: https://hooks.slack.com/services/...
    channel: dev
    username: drone
```

## でも…

結局これ、効かないので記事にするのはやめねｗ
