# 実行可能なwarを作る方法メモ

## SpringBootから感じを探る

- War(実行可能コンテナ抜き)を敢えて作る
  - <https://qiita.com/TEBASAKI/items/7a22c8b6ac6eb5f1c304>
  - <http://d.hatena.ne.jp/Kazuhira/20150927/1443365994>
  - <https://qiita.com/kz1202/items/cb04ebb42ce4cd9ea30b>

```
SpringBootの起動可能jar - SpringBootの起動機能の無いwar = 起動機能部分だけの構成
```

ができるか？と思い

- Zipの中身を差異分析
- 中身から「SpringBootのアプリ部分」を削除
- その中に「別のWarから持ってきた中身」を封入
- `java -jar` で起動

したのだが「構造にSpringBootアプリの形状を期待」しているため、動かず。

## maven-tomcat-plugin


## 自力で作る場合の手がかり

- jenkins.war のような実行可能 war ファイル作りたい
  - <https://qiita.com/k_ui/items/1d3bbbd7993c4c9adf71>
  - いろいろなサンプルが在る(これで多くまなんだ)
    - ここと対のgithubが秀逸
  - が `maven` である
- TomcatEmbeded実行実装例
  - <https://gist.github.com/AlBaker/2772611>

## Tomcat8(7後半)になると同じことをしても動かない件

Tomcat7.0.47以降からは、以下のような「単純な実装」なら、ディレクトリが作れなかったり、Warが展開できなかったりして、正常な起動をしない。


```Java
Tomcat tomcat = new Tomcat();
tomcat.addWebapp(parameters.contextRoot(), thisWarPath.toString());
tomcat.setPort(parameters.port());
tomcat.start();
tomcat.getServer().await();
```

上記のバージョンから「appBaseが必須となる(実サーバであればserver.xmlで)」のためで、start()前に以下の対策が要る。

```Java
tomcat.getHost().setAppBase("./");
```

## Tomcat8からデフォルトエンコーディングが 'UTF-8' になる

逆に、Tomcat７以下であれば「UTF-8にならない」ので、多くの場合7以下でこの指定をすることとなる。

```Java
tomcat.getConnector().setURIEncoding("UTF-8");  // Tomcat8のデフォルトと合わせる
```

## 関係ないが細かい技術

- gradleかつwarかつMANUFEST変更
  - <https://stackoverflow.com/questions/21272527/gradle-war-manifest-version-number-wrong-for-release-build>
- Javaから実行可能なJARや実行ファイルをGradleで作る
  - <https://qiita.com/informationsea/items/cd1d8d130a5c7b0bc31a>
  - 単品だけじゃなくて、複数jarを内包し「それだけで実行できるJar」を作る方法
  - 実行可能Jarの基礎ではある
- gradleでwarを作る方法(基礎)
  - <http://gradle.monochromeroad.com/docs/userguide/war_plugin.html>
