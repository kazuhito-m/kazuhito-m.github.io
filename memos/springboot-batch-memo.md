# Spring Boot Batch メモ

`org.springframework.boot:spring-boot-starter-batch` で作ることができるコンソールアプリケーションのメモ。

基本、 `spring batch` は「xmlでバッチの構成を定義する」というものなので、 `spring boot batch` とは特性が異なる。

なので、 `spring boot batch` 中心に情報を収集する。

(ただし、やりたいことが `spring batch` で実現出来ている場合は、それをbootのカタチに読み替える。)

## SpringBatch の基本概念

- <https://terasoluna-batch.github.io/guideline/5.0.0.RELEASE/ja/Ch02_SpringBatchArchitecture.html>
- <https://www.slideshare.net/HasegawaDanna1/20170525-jsug>
- <http://labs.opentone.co.jp/?p=3480>

## SpringBootBatch の実装例

- <http://kagamihoge.hatenablog.com/entry/2015/02/14/144238>
- <http://www.omotenashi-mind.com/index.php?title=Spring_Bootによる簡単Springアプリケーション開発>

## 「パラメータを取る」方法

- <https://qiita.com/bauzer/items/13960a1c825d155edd7c>
- <https://stackoverflow.com/questions/32465142/spring-batch-accessing-job-parameter-inside-step>
  - `chunkContext` は、どういうとこで使う何なのか
- <https://terasoluna-batch.github.io/guideline/5.0.0.RELEASE/ja/Ch04_JobParameter.html#Ch04_JobParameter_HowToUse_CLIArgs>
  - XMLにて設定するヤツ
- <https://qiita.com/tfunato/items/196a143d6cbf103b7893>
  - プレースホルダの話
- <https://github.com/muumin/spring-boot-batch-sample>
  - サンプル、`-job` の指定や、 `-restert` 、普通のパラメータの指定等
- <https://qiita.com/kazuki43zoo/items/0ce92fce6d6f3b7bf8eb>
  - 引数から「使うapplication.propertiesを指定する」という箇所にも使える話

## StepScopeの話

理解出来ず。

- <https://stackoverflow.com/questions/28457107/spring-batch-scope-issue-while-using-spring-boot>

## ItemWrierの性質(spring batch)

-  <http://www.omotenashi-mind.com/index.php?title=SpringBatch：ItemWriterについて>

## Reader/Writerの話

### FlatFileItemReaer

- <https://docs.spring.io/spring-batch/trunk/apidocs/org/springframework/batch/item/file/FlatFileItemReader.html#setEncoding-java.lang.String->
- <http://forum.spring.io/forum/spring-projects/batch/60596-linetokenizer-in-flatfileitemreader>

### FlatFileItemWriter

- <https://qiita.com/tera78/items/356a2e1618544175f85e>

## 「Database接続要らないの勝手に使ってしまう問題」対応

- <https://stackoverflow.com/questions/24074749/spring-boot-cannot-determine-embedded-database-driver-class-for-database-type>

## Spring Boot Gradle Pluginのはなし

ビルドしてもjava -jarで動かなかった問題

- <https://docs.spring.io/spring-boot/docs/current/reference/html/build-tool-plugins-gradle-plugin.html>

## スケジュール実行の話

- <http://blog.enjoyxstudy.com/entry/2017/02/19/000000>
- <http://office-yone.com/blog/spring-boot-5-batch/>
  - ただこれはCommandLineRunnerの話

## テスト周りの話

- <https://stackoverflow.com/questions/24074749/spring-boot-cannot-determine-embedded-database-driver-class-for-database-type>
- <https://qiita.com/tfunato/items/346e3e898a85d834ee99>

## 管理テーブルを無効化する

- <https://qiita.com/sengoku/items/801c7b44cb38a635060e>
- <https://qiita.com/blackawa/items/e9eaa254cbe27e257e10>
- <https://blog.ik.am/entries/409>

### 管理テーブルの「スキーマを変える」にはどうすれば良いか

結論的には「変えることはできない」「接続先の指定で変えるくらい」ということが解った。

### 試したこと

- application.properties の spring.datasource.url の末尾に ?currentSchema=[スキーマ] 付ける
  - 唯一変更できるが、「マイグレーション前にCREATEする」ので、間に合わない
    - これは「テスト起動時」において
  - 「環境側に予め作る」などすればできるが、それではマイグレーションに一本化出来ない
    - 本運用でやるときにはマイグレーションを先にやるだろうから良いのだが
- application.properties の spring.datasource.schema を指定
  - 変わらず、publicに作ってしまう
- BatchConfiguration弄る
  - まだやってないが、 今の WithoutBatchManagementTableConfigurer.java より複雑性を持ち込みそう

## Flayway導入

基本「導入すると勝手に動く」ので、dependency仕込むだけで良さそう。

- <https://qiita.com/peg_73_/items/347a446ad183dda36da3>

## Batchの application.properties のパラメータ全量

- <https://github.com/pkainulainen/spring-batch-examples/blob/master/spring-boot/src/main/resources/application.properties>
- <https://github.com/spring-projects/spring-batch/tree/master/spring-batch-core/src/main/resources/org/springframework/batch/core/configuration/xml>

## SpringとMyBatisで「複数接続」


---


## Springの `@Scoope` の話

- <http://javatechnology.net/spring/spring-singleton-scope/>

# 別の話

## 固定長ファイル処理 `uniVocity-parsers` の紹介

- <https://dzone.com/articles/univocity-parsers-powerful>

## ライブラリの更新の自動通知

- <http://y-yagi.tumblr.com/post/146826188425/android使用しているライブラリの更新の通知を自動で行う>

## GradleでMavenのBOM(部品表)みたいなものを使う方法

- <http://create-something.hatenadiary.jp/entry/2015/05/08/063000>


## nio の「一般的な操作」まとめ

- <https://qiita.com/toastkidjp/items/5500521ff5dc0346c2b1>
