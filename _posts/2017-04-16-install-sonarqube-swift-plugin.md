---
layout: post
title: Sonarqubeに「Swift Plugin(OSS版)」をインストールする
category: tech
tags: [sonarqube, swift]
---

普通にやると「コケる」か「課金することになる」って…罠な感じが…。

# これを読んで得られるもの

- SonarqubeにSiwftPluginを入れようとした時のハマり回避
- Sonarqubeに「Swift Plugin(OSS版)」をインストールする方法

# 経緯

Sonarqubeは「デフォルトに入っている言語」以外は、「プラグインを追加すると解析出来る言語が増える」という仕組みです。

プラグインは「システムの画面内から検索、追加することが出来る」ようになっています。

今回、「iOSアプリの静的解析がしたくなった」ので、公式(上記のシステム画面内)からSwiftの名前を関したプラグイン `Swift(Code Analyzer for Swift)` が見つかるので、普通ならそれを入れがちだと思います。

しかし `sonar-scanner` を実行し、解析させてみると[エラー](https://github.com/Backelite/sonar-swift/issues/32)になります。

```
Running Lizard...Running SonarQube using SonarQube Runner.ERROR: Error during SonarQube Scanner execution
ERROR: No license for swift
```

それもそのはず「公式で出てくるものは[有料のプラグイン](https://www.sonarsource.com/why-us/products/codeanalyzers/sonarswift.html)」であり、(どうやって課金するのかはわかりませんが)ライセンスを手に入れないと使えないようです。

----

諦めそうになったところで、「[有志が作成しているOSSのSwiftプラグイン](https://github.com/Backelite/sonar-swift)」を見つけましたので、インストール手段を残します。

# 前提

- `Sonarqube` は比較的新しいものをインストール済み
  - 例は `Version 6.3 (build 19869)` 上での作業
- Linux(例ではCentOS6.9)にインストールしている
  - データディレクトリは `/opt/sonar` とします

# やりかた

## プラグインのダウンロード&再起動

Sonarqubeのプラグインの実体は `jar` で配布されており、前述のプラグインも「[githubのreleases機能で配布](https://github.com/Backelite/sonar-swift/releases)」されています。

そして、「手動でのインストール」については「[公式がやり方をドキュメントで紹介](https://docs.sonarqube.org/display/SONAR/Installing+a+Plugin)」しています。

要約すると…

1. データディレクトリの一角(extensions/plugins/)にjarを配置
0. Sonarqube自体を再起動

と、これで本体が認識し、インストールが完了するようです。

前提の「自分の環境」では

```bash
cd /opt/sonar/extensions/plugins/
sudo wget https://github.com/Backelite/sonar-swift/releases/download/0.3.2/backelite-sonar-swift-plugin-0.3.2.jar
sudo service sonar restart
```

といった感じです。

[インストール後のSonarqube画面](/images/2017-04-16-installed.png)

指定している `0.3.2` は現在の最新なので入れる際は[公式を確認](https://github.com/Backelite/sonar-swift/releases/)してください。

---

# 小並感

現在、このプラグインを使って見ているのですが、どうやら入れただけでは「行重複(Duplications)」しか検出してくれないようで。

ちょろっとドキュメントを見てみると「 `SwiftLint` と連携」みたいな記載が見えるので、今後仕込んで行きたいなと思います。

作者の方に感謝！
