---
published: false
layout: post
title: (仮)Flywayの設定をbuild.gradleに書く場合の複数記述について
category: tech
tags: [flyway, gradle, trubleshoot]
---

サンプルがあまりないが…mvn)(pom.xml)で「文字列列挙」だったものが、「Gradle的リスト」といて書き換えないと動かない。

```
flyway {
    url = dbUrl
    user = dbUser
    password = dbPassword
    schemas = ['storemaster', 'public']
    locations = ['classpath:db/migration']
}
```
