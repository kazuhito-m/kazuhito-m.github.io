# plantumlをslackで勝手に図にして投稿してくれるbotを作ろうメモ

## まず

ドンピシャなものはある。

https://github.com/taichi/umlbot

### …が、動かず。

正確には

- helokにはデプロイ成功
  - READMEの元の手順通りで
- アプリケーションも反応
  - `I'm running!! yey!` とブラウザで返す
- `outgoing-webhook` の仕込みも成功
  - 恐らくだが「Slackに書き込むたび、Herokuのlogに出てる」ので
- だが「Slackに投稿されない」状況

## 材料

### SlackのBotKit

- BotKit
  - https://github.com/howdyai/botkit
  - おそらく、今標準っぽい
  - 入門記事
    - https://qiita.com/prime300th/items/a2fcdbccd42804153ff5
    - http://robin.hatenadiary.jp/entry/2017/01/02/220338
    - https://bita.jp/dml/slack_botkit
- JavaでSlackBot作る
  - https://qiita.com/riversun/items/25f64f285699223a992d

### node x plantuml

BotKit弄うなら、node.js なので…。

- node-plantuml
  - https://www.npmjs.com/package/node-plantuml
-
