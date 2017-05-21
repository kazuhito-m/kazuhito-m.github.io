---
layout: post
title: CircleCIとPlantUMLで「リバースしたClass図を常時生成」する
category: tech
tags: [circleci,plantuml,ci,reverce-engineering]
---

おそらくですが「もっと苦労しなくともできるものがある」…とは思うので、教えて欲しいのですよね。

# 経緯っぽいの

[DDDが関係する勉強会](https://tagile.doorkeeper.jp/events/59757)に行ってる時に、ふと思ってつぶやいたんです。

<blockquote class="twitter-tweet" data-lang="ja"><p lang="ja" dir="ltr">「リバース・エンジニアリング」が「人の手を煩わせない」のであれば、DDDでもやってもええ話なんやろか。</p>&mdash; 三浦一仁(脱staticおじさん) (@kazuhito_m) <a href="https://twitter.com/kazuhito_m/status/865815911374114816">2017年5月20日</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

とか言うと、関西におけるDDD実践者で著名な [@haljik](https://twitter.com/haljik) さんから…

<blockquote class="twitter-tweet" data-lang="ja"><p lang="ja" dir="ltr"><a href="https://twitter.com/kazuhito_m">@kazuhito_m</a> そこはかなり有りだと思ってる。コードだけだと俯瞰はしにくいし</p>&mdash; はるじっく (@haljik) <a href="https://twitter.com/haljik/status/865816183311712256">2017年5月20日</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

と来まして、 __なんだかんだあって__

<blockquote class="twitter-tweet" data-lang="ja"><p lang="ja" dir="ltr"><a href="https://twitter.com/kazuhito_m">@kazuhito_m</a> お願いします！ｗ</p>&mdash; はるじっく (@haljik) <a href="https://twitter.com/haljik/status/865816861287391232">2017年5月20日</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

みたいになったので「20秒くらいで出来へんかな？」と思って、やってみました。

# 説明

## コンセプト

最初から「こうしたい」って決めてたのは…

- タダであること
- 真似すりゃ簡単にできること

です。(だってそうでないと俺自身が出来ないんだものｗ)

## 前提

こんなJavaプロジェクトがあるとします。

- [典型的なSpringBootで作ったWebアプリ](https://github.com/kazuhito-m/java-odf-edit-sample)
  - [この発表])(https://www.slideshare.net/miurakazuhito/opendocument-13libreoffice-libokansai) の時に作ったやつです
- [CircleCI](https://circleci.com)でテスト回してる
  - ただ「[テスト回す](https://circleci.com/gh/kazuhito-m/java-odf-edit-sample)」くらいのシンプル構成

CircleCIの設定ファイル `circle.yml` は、

```
machine:
  java:
    version: openjdk8
```

程度で、ほぼ何も仕込んでないです。  

これを例に「リバースしたClass図を常時生成」できないか、をやって来ます。

# やったこと

## 使う道具

要件は

- (Linixの)コンソールから出力命令を実行できること
- 出力された図は特殊なビューアを必要としないこと

と(自分に)課します。

昔はなんかあった気がするのですが、今は「有料の統合ツールを買う」か、以下の

- [`PlantUML`](http://plantuml.com/)

くらいしかググっても出てきません。

上記ツールだけでは「テキスト(DSL)を書けばpngのクラス図が出せる」だけなのですが、別途「JavaからPlantUMLのテキストファイルを生成できるツール、

- [`plantuml-dependency-cli`](http://plantuml-depend.sourceforge.net/command_line/command_line.html)

を組み合わせれば「コンソールからテキストをリバース -> 画像化」できます。

## お試し

まず、 `plantuml-dependency-cli` ですが、[こちら](https://sourceforge.net/projects/plantuml-depend/files/1.4.0/plantuml-dependency-cli-1.4.0-archive-with-bundled-dependencies.tar.gz)から tgz をダウンロードして、解凍します。

その後出てきたJarを使って、目的のディレクトリと出力ファイルを指定、実行してみます。

```bash
java -jar plantuml-dependency-cli-1.4.0-jar-with-dependencies.jar \
  --basedir './src/main/java//com/github/kazuhito_m/odf_edit_sample/domain' \
  -o test.pu
```
すると…s `test.pu` にそれっぽいのが出てきます。

```txt
@startuml
annotation java.lang.Override
class com.github.kazuhito_m.odf_edit_sample.domain.user.User
class com.github.kazuhito_m.odf_edit_sample.domain.workresult.WorkResultDay
class com.github.kazuhito_m.odf_edit_sample.domain.workresult.WorkResultRow
class com.github.kazuhito_m.odf_edit_sample.domain.workresult.WorkResults
class com.github.kazuhito_m.odf_edit_sample.domain.workresult.report.WorkResultReportMaker
class com.github.kazuhito_m.odf_edit_sample.infrastructure.fw.util.DateUtils
class com.github.kazuhito_m.odf_edit_sample.infrastructure.fw.util.OdsUtils
class java.io.File
class java.io.IOException
...
```

この出力されたファイルを `plantuml` を使って画像出力させてみます。

[こちら](https://sourceforge.net/projects/plantuml/files/1.2017.13/plantuml.1.2017.13.jar) から、Jarをダウンロードし、実行します。

```bash
java -jar plantuml.1.2017.13.jar test.pu
```

すると、対になる `test.png` という画像ファイルが生成されます。

![画像を出してみた結果](/images/2017-05-21-test.png)

馬鹿でかいのでわかりにくいかもしれませんが、「JavaのAPI」や「フレームワークのクラス」まで依存が描かれてるのは邪魔ですね。

テキスト加工して`java.`や`org.`削除してみましょう。

![ちょっとアレンジ](/images/2017-05-21-test-arrange.png)

おお、これならいい感じかも。

## 設計

1. CIでテストが成功したらクラス図生成をする
0. 出力したクラス図はCircleCIへビルドごとに「成果物」として保存
0. ツールはWebから常時落とす
0. どのパッケージをリバースするかは設定ファイルで指定出来る
0. 除外するものを(文字一部一致で)設定ファイルで指定できる
0. 上記を邪魔に成らない程度にスクリプトでプロジェクトに置いとく

くらいにしといたら、使いやすいでしょうかね。

## 作ったもの

### スクリプトやらもろもろ

プロジェクト直下に `.purc` なディレクトリをつくり、そこにスクリプトなりを[一式置いて](https://github.com/kazuhito-m/java-odf-edit-sample/tree/master/.purc)みました。

![.purcとは](/images/2017-05-21-purc.png)

`plantuml-reverce-class-diaglam.sh` がメインのスクリプトで、

```bash
#!/bin/bash

# どこから呼ばれても同じ挙動をする様に
scriptDir=$(cd $(dirname $0);pwd)
cd ${scriptDir}

# 共通関数読込、設定ファイル読みこみ
source ./functions.sh
source ./setting.conf

# 作業ディレクトリ作成
outDir=./class-diagrams
workDir=./work
clearDir ${outDir}
clearDir ${workDir}

cd ${workDir}

# plantuml-dependency-cli をダウンロード
wget https://sourceforge.net/projects/plantuml-depend/files/1.4.0/plantuml-dependency-cli-1.4.0-archive-with-bundled-dependencies.tar.gz
tar xzf plantuml-dependency-cli*.tar.gz
mv ./plantuml-dependency-cli*/plantuml-dependency-cli-*.jar ./plantuml-dependency-cli.jar

# plantuml 自体をダウンロード
wget https://sourceforge.net/projects/plantuml/files/1.2017.13/plantuml.1.2017.13.jar
mv plantuml.*.jar plantuml.jar

cd ${scriptDir}

for targetPackage in $(cat ./target-package.list) ; do
  targetDir=`echo ${targetPackage} | sed 's/\./\//g'`
  lastPackageName=`basename ${targetDir}`
  targetFile=${outDir}/${lastPackageName}.pu

  # PlantUMLのクラス図ファイルへリバース
  java -jar ${workDir}/plantuml-dependency-cli.jar --basedir ../${SRC_DIR}/${targetDir} -o ${targetFile}

  # 作成されたファイルを加工
  for ignoreWord in $(cat ./ignore-words.list) ; do
    rowDelete ${targetFile}  ${ignoreWord}
  done

  # クラス図テキストファイルから、画像へ。
  java -jar ${workDir}/plantuml.jar ${targetFile}

done

makeHtml './target-package.list' ${outDir}
```

てな感じで、ダウンロード->テキストリバース->画像化してます。

サービスで画像を一覧出来るHTMLなども吐いてみました。

`target-package.list` は「対象指定ファイル」で、

```bash
com.github.kazuhito_m.odf_edit_sample.domain
com.github.kazuhito_m.odf_edit_sample.application
```

のようにパッケージ指定で除外、

`ignore-words.list` は除外設定ファイルで、

```bash
java.
org.
```

のように「除外したいクラス・パッケージの一部」を書けば除外出来るようにしています。

### CircleCIの設定

`circle.yml` は以下のようなカタチにしています。

```yml
machine:
  java:
    version: openjdk8
test:
  post: # PlantUMLのクラス図の画像を生成・保存
    - sudo apt-get install -y graphviz
    - ./.purc/plantuml-reverce-class-diaglam.sh
    - cp -r ./.purc/class-diagrams $CIRCLE_TEST_REPORTS/
```

テストが成功した後に、スクリプトを実行し、CircleCIの「成果物(Artifacts)」に成果フォルダごとコピーします。

PlantUMLの実行には、本体Jar以外に `graphviz` が必要なので、直前にインストールしています。

(CircleCIのコンテナのデフォルトはUbuntuっぽい何からしいです)

### 実行すると…

テスト成功、CI完了後に、画面中 `Artifacts` をクリックすると、クリックすると、成果物が保存されています。

![CircleCIのArtifacts](/images/2017-05-21-artiracts.png)

`index.html` をクリックすると、こんな感じ。

![CircleCIのArtifacts](/images/2017-05-21-diagram-overview.png)


## でもですね…

やった！ …のですが、いろいろアカン感じがありまして…

- 同一パッケージ内のクラス依存は線を引いてくれない
- パッケージ階層のネストは考慮してくれない
- フィールド・メソッドは考慮してくれない

というのが見て取れます。

例えば、今回解析した `domain` パッケージは、

![今回の例](/images/2017-05-21-src-tree.png)

という構成で、 `PlantUML` 的に頑張れは、

![本来のカタチ](/images/2017-05-21-sample-classes.png)

と言うような表現が出来るのですが…これは `plantuml-dependency-cli` のリバース能力の限界だと思います。

(多分、javaファイルのimport部からしかテキスト的に拾ってきてるだけなのでしょう。 `*` 指定とかすると拾えなくなりますし。)

ここはもう [こういうの](https://github.com/javaparser/) で自力でツール作ったらエエかな、と考え始めてます。

## 小並感

ちょっと故あって `CircleCI` で行いましたが、もちろん我らがJenkinsでも同じことが出来ます。

また、「CircleCIの成果物」というとこは、常時何かで通知するor意識しないと観に行くことが少ないと思われるので、現場で使う際は「ポータルサイト」や「Wiki」などにアップしたらよい感じかなぁと。

でも、やっぱり「もっと簡単に出来る手段」がある気がするので、なんかあれば教えてくださいませ。
