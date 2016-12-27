---
layout: post
title: Jenkinsで「パイプラインスクリプトでMSBuild実行」時の文字化けを解決できなかった話
category: tech
tags: [msbuild,jenkins,slave,chcp]
---

わりかし「特殊環境らしいところで多段に要素が重なった話」なのと「自分よう備忘録」なので、箇条書きで詳しく解説しません。ごめんなさい。

# これを読んで得られるもの

- Jenkins + Slave側Windows + パイプラインスクリプト にて「文字化け」場合のハマリの回避
- `chcp 61005` で「ジョブが止まる(ステイしてエラーも終了もしない)」「期待していた挙動にならない」場合の対処

# 前提

Jenkinsのnodeをmaster/slaveで組んでいました。

- Jenkins(master)
  - CentOS6(in AWS)
  - [本家の入れ方](https://wiki.jenkins-ci.org/display/JENKINS/Installing+Jenkins+on+Red+Hat+distributions)したJenkins使用
  - Jenkins ver. 2.34
- Jenkins(slave)
  - Windows Server Stndard 2007 SP2(日本語版)
    - VMWare vSphare上実行
  - jnlpでコネクション張る(java -jar slave.jar起動)


# 事象

JenkinsNodeを、普通に Master:Linux , Slave:Windows(日本語のやつ) を作って、 PipelineScript(Jenkinsfile)にて、

```groovy
bat "MSBuild.exe XXX.sln"
```

などすると、Jenkinsのログコンソール文字化けします。

![結果](/images/2016-12-27-mojibake.png)

これは、

```txt
プロジェクト "xxx" (規定のターゲット) のビルドが完了しました。

ビルドに成功しました。
    0 警告
    0 エラー
```

の表記なのですが…まあわかりませんねｗ

そのため、[こちらのサイト](http://gozuk16.hatenablog.com/entry/2016/03/29/195705) の如く、Jenkinsfileで

```groovy
bat 'chcp 65001'
```
を書いて実行したのですが、[以前のハマり](https://kazuhito-m.github.io/tech/2016/12/05/jenkins-jobstop-by-japanesename)と同じく「ジョブが止まった状態」になりました。

# やったこと

ちょっと煩雑に「いろいろやった」ので、やったことと結果を箇条書きにしていきます。

## Slave側のJenkinsが載ってるWindowsでコマンドプロンプトで実行

- コードページ`932`(shift_jis)の状態から
  - `chcp 65001`(UTF-8) -> プロンプトのウインドウの状態がリセットされ変わる（フォントなど)
  - `chcp 20127`(US-ASCII) -> 同上
  - `chcp 932`(shift_jis) -> 文字がクリアされるだけでウインドウは変わらず
  - バッチファイルに`MSBuild`書いて実行 -> 普通に実行可能、表示は日本語
  - バッチファイルに`chcp 65001`を書いて実行 -> ウインドウ状態リセット、chcp後の記述は動かず
- `chcp 65001`後に実行
  - `chcp 65001` ->  文字がクリアされるだけでウインドウは変わらず
  - `chcp 932` -> プロンプトのウインドウの状態がリセットされ変わる（フォントなど)
  - バッチファイルに`MSBuild`書いて実行 -> 何も実行されない、空白の一行が出力されて終わる
    - どんなバッチファイルでも、中身がどんなことが書いてあっても無効化、何も起こらず終了する模様
  - `MSBuild`を、コンソールから直に実行 -> 普通に実行可能、表示は日本語
- `chcp 20127`後に実行
  - バッチファイルに`MSBuild`書いて実行 -> 普通に実行可能、表示は英語
  - バッチファイルに`chcp 65001`を書いて実行 -> 普通に実行可能、表示は英語

なんとなく、`65001`が「ひとつだけ異端」で、そこさえ回避すれば「世の記事っぽく動く」感じがします。

`chcp`で使用出来る「コードページの数値」の一覧は[こちら](https://msdn.microsoft.com/en-us/library/windows/desktop/dd317756.aspx)。

## 「MasterのJenkins」から`Jenkinsfile`の指定のジョブを「SlaveのJenkins(windows)」にて実行

問題を切り離すため、Slave:Jenkins側の`slave.jar`は、

```bat
REM echo off
set JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF-8 -Dsun.jnu.encoding=UTF-8
set JENKINS_URL=http://[jenkinsのurl]/computer/[slave名]]/slave-agent.jnlp
set JENKINS_SECRET=[それっぽいの]

REM charset (us mode)
chcp 20127

REM Connect to Jenkins server (AWS)
java -Dhttp.proxyHost=%PROXY_HOST% -Dhttp.proxyPort=%PROXY_PORT% -Dfile.encoding=UTF-8 -Dsun.jnu.encoding=UTF-8 -jar slave.jar -jnlpUrl %JENKINS_URL% -secret %JENKINS_SECRET%
```

な記述の`batファイル`を実行し、固定した状態での「JenkinsからSlave実行」とします。

- Jenkinsfileに`bat "chcp 65001"`記述で実行 -> ジョブがその行でステイ、エラーも終了もせず
- Jenkinsfileに`bat "chcp 20127"`記述で実行 -> 止まらず次の行に行ける
  - しかし後の行に`MSBuild.exe`実行があっても「日本語かつ文字化け」した表示のまま
- Jenkinsfileに`bat "chcp 65001 && MSBuild.exe ..."`記述で実行 -> 日本語表示(成功！)
  - しかし、 __ビルドの最後でステイ、エラーも終了もせず__ な状態になってしまう
- Jenkinsfileに`bat "chcp 20127 && MSBuild.exe ..."`記述で実行 -> 英語表示
  - ただし`日本語ファイル名`は文字化け
- Jenkinsfileに`bat "cmd.exe /u /c MSBuild.exe ..."`記述で実行 -> 日本語結果で文字化け
  - 何も書かず `bat "MSBuild.exe ..."` と書いた場合と同じ

…これ以上はがんばれなかった…。(環境固有かもしれないし)

## 解決（…はしてないが、とりあえずこれで行くことにした方策）

とりあえず、

__Jenkinsfileに `bat "chcp 20127 && MSBuild.exe ..."` 記述で実行__

で、茶お濁して先に進むことにしました。

「結果がわからない」が問題だったので。日本語ファイル名は…まぁ「推測つくだろう」ってことで。

---

人によっては

- そもそも止まらない
- そもそも化けない

可能性があるらしい…のだけど、それすらも検証していません。

---

# 小並感

複合要素がありすぎて、「特殊な環境固有」なのか「（前提に書いた）組み合わせによるもの」なのか、わからない上に「検証のワンショット」がかなり時間を使い、「落とし所に至る」まで時間がかかりました。

もっと良い解決法があったのかもしれませんが…まあ「同じことに陥った人」はご連絡くださいまし。

# 参考URL

以下を参考にさせていただきました。感謝です。

- [http://samooooon.hatenablog.com/entry/2016/07/07/151754](http://samooooon.hatenablog.com/entry/2016/07/07/151754)
- [http://gozuk16.hatenablog.com/entry/2016/03/29/195705](http://gozuk16.hatenablog.com/entry/2016/03/29/195705)
- [MS本家のコードページ一覧](https://msdn.microsoft.com/en-us/library/windows/desktop/dd317756(v=vs.85).aspx)

# 感謝

Windowsまわりで、いろいろ詳しい助言をくださった [@iso2022jp](https://twitter.com/iso2022jp) さん、ありがとうございました。
