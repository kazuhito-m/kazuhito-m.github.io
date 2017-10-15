---
layout: post
title: TomcatのWebアプリで"Too many open files"が出る場合の対処
category: tech
tags: [java, linux, tomcat]
---

この話は、完全に個人用忘備録です。責任は持てません。

# やること

## 前提

- OS : RHEL5.7(CentOSでも同様だと思われ)
- Software : tomcat5,java6(Sun)

## 現象

TomcatでJenkins(JavaのWebアプリ)を運用していた際、このようなエラーが出ました。

__"Too many open files"__

再起動したり設定読み込み直したりすると状況が変わるため、非常にタチが悪いものです。

アプリ側にJavaの例外として通知されるのが余計にわかりにくいですが、どうやら…

「Linuxにおけるファイルディスクリプタの制限」

に引っかかっているらしい。

簡単に言うと「1ユーザの1プロセスに多量のファイルを開かせてやるものかあぁぁ！」という制限のようで。

確認方法は、

```bash
ulimit -n
```

で、初期値は1024のよう。(このコマンドで他の制限も確認・設定可能)

かたや、tom猫さんが開いているファイル数はというと…

```bash
# PID特定
ps aux | grep tomcat
tomcat 9999 ～
# PIDが開いているファイル数をチェック
/usr/sbin/lsof -p 9999 | wc -l

1578
```

なるほど、余裕で超えてますね…。

## やったこと

ulimit コマンド自体でも変更できるのですが、そのユーザ＆一時的なものなので、これの「大元の設定ファイル」を弄う。

```bash
vi /etc/security/limits.conf
```

末尾に以下を足します。※数は2倍＋切りの良い数字にした。

```bash
tomcat hard nofile 4096
```

これで解消しました。

ただ、いろいろググっていると「無尽蔵に増えていく」らしいので、いつか足さないといけないのかな？

# 参照資料
- [http://www.matsuaz.com/matsumotojs/2010/12/24/1293117835413.html](http://www.matsuaz.com/matsumotojs/2010/12/24/1293117835413.html)
