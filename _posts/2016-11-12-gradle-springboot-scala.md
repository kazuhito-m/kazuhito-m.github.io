---
layout: post
title: Gradle + ScpringBoot + Scalaで開発始める始める方法
category: tech
tags: [gradle,springboot,scala]
---

# これ読んで、何が得られる？

- 掲題での組み合わせでの開始HowTo
  - 実績ありの一式を作れる
  - しょーもないことでのハマリの回避

# 欲しかったもの・動機

Webアプリを作りたくなりました(仕事ではないですが)。

となれば使うものを選ぶのですが…

__(明日、仕事で使う=いわば生きるか死ぬかのメシのタネになる)自分が勉強したかったもの"だけ"をチョイス__

しなければ、時間が掛かって死んでしまうわけです。

で考えると、

- Gradle
- SpringBoot
- Scala
- 自動テスト書くノウハウ

となるので「コレ全部同時に満たして開発できないか」を試みました。

# 手順

大まかには以下。

1. `gradle` コマンドが叩ける環境作る
0. プロジェクト作りたいフォルダで `gradle init`
0. `build.gradle` を編集
0. Scalaで `Application`,`Controler` クラスを作る
0. `./gradlew bootRun` でSpringBootの起動を確認
0. `localhost:8080` に対するリクエストで動くの確認
0. `specs2` でテスト書く
0. `./gradlew check` でテストが回るのを確認

上記から、「今回のキモ」だけ説明していきます。

## `build.gradle` を編集

`build.gradle` に以下の編集をします。

```grooby
repositories {
    jcenter()
}
buildscript {
    repositories {
        jcenter()
    }
    dependencies {
        classpath("org.springframework.boot:spring-boot-gradle-plugin:1.4.0.RELEASE")
    }
}

apply plugin: 'scala'
apply plugin: 'application'
apply plugin: 'spring-boot'

dependencies {
    compile 'org.scala-lang:scala-library:2.11.8'
    compile 'org.springframework.boot:spring-boot-starter-web'
    testCompile 'org.specs2:specs2-core_2.11:3.8.6'
    testCompile 'org.specs2:specs2-junit_2.11:3.8.6'
}
```

## Scalaで `Application`,`Controler` クラスを作る

ソースフォルダを作ります。

`mkdir -p ./src/main/scala`

２つのScalaクラスファイルを作ります。

`./src/main/scala/Application.scala`

```scala
package なんでもいいです
import org.springframework.boot.SpringApplication
import org.springframework.boot.autoconfigure.SpringBootApplication

@SpringBootApplication
class Application {
}

object Application extends App {
  SpringApplication.run(classOf[Application], args: _*)
}
```

`./src/main/scala/SampleController.scala`

```scala
package なんでもいいです
import org.springframework.web.bind.annotation.{RequestMapping, RequestMethod, RestController}

@RestController
@RequestMapping(Array("/api/sample"))
class SampleController {
  @RequestMapping(method = Array(RequestMethod.GET))
  def data = "hoge"
}
```

## `localhost:8080` に対するリクエストで動くの確認

上記のクラスを配置し終わったら、以下のコマンドを叩きます。

`./gradlew bootRun`

以下のURLをブラウザで確認します。

[http://localhost:8080/api/sample](http://localhost:8080/api/sample)

"hoge" と表示されれば成功です。

## `specs2` でテスト書く

テスト用のソースフォルダを作ります。

`mkdir -p ./src/test/scala`

Specs2形式のScalaテストクラスファイルを作ります。

`./src/test/scala/SampleControllerTest.scala`

```scala
package なんでもいいです
import org.junit.runner.RunWith
import org.specs2.mutable.Specification
import org.specs2.runner.JUnitRunner

@RunWith(classOf[JUnitRunner])
class SampleControllerTest extends Specification {
  "Scalaでテスト書けるかのテスト" should {
    "RESTの返答が固定値に成る、たったそれだけな世界一簡単なテスト" in {
      val sut = new SampleController
      sut.data must equalTo("hoge")
    }
  }
}
```

あとは、

`./gradle test`

を実行し、 `BUILD SUCCESSFUL` と表示されれば、「ScalaでSpecs2を使ったテスト可能な環境」はできています。

## ハマリ点

- `*.scala` ファイルの`package` は省略(デフォルトパッケージ)してはいけません
  - `./gradlew bootRun` がコケます
- 最新のscala-library(2.12)に上げられません
  - 現在指定しているspecs2の最新Ver(2.11:3.8.6)との組み合わせが動きません
  - Specs2を使わなければ上げてもかまいません

## 思ったこと

かなり「普通じゃない」組み合わせかもしれないので、ここからの開発は茨の道かもしれません。

Gradle＆Scalaの組み合わせは、カンファレンスなどで「sbtじゃなくgradleで…」とか聞きます。

ですがいまいちサンプルな日本語情報が無いので書いてみました。

# 参考

+ [http://mao-instantlife.hatenablog.com/entry/2015/09/07/SpringBoot%E3%83%97%E3%83%AD%E3%82%B8%E3%82%A7%E3%82%AF%E3%83%88%E3%82%92Scala_%2B_sbt%E3%81%A7%E6%A7%8B%E7%AF%89%E3%81%99%E3%82%8B](http://mao-instantlife.hatenablog.com/entry/2015/09/07/SpringBoot%E3%83%97%E3%83%AD%E3%82%B8%E3%82%A7%E3%82%AF%E3%83%88%E3%82%92Scala_%2B_sbt%E3%81%A7%E6%A7%8B%E7%AF%89%E3%81%99%E3%82%8B)
+ [http://bernhardwenzel.com/blog/2016/04/22/using-spring-with-scala/](http://bernhardwenzel.com/blog/2016/04/22/using-spring-with-scala/)
