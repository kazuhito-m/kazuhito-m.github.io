---
layout: post
title: JenkinsのJNLPによるSlave接続でBasic認証でmasterのJenkinsと接続する方法
category: tech
tags: [jenkins,jenkins-slave]
---

実は、こっちのが先なのだろうと思いますが…。

# これを読んで得られるもの

- JenkinsのJNLPによるSlave接続でBasic認証でmasterに接続する方法
  - `slave.jar` のパラメータ指定方法

# 経緯

Jenkinsで「MasterとSlave」というふうな構成を組む場合、JNLPでの接続(Slave側からは `slave.jar` を起動しての接続)を使うこと多いと思います。

masterにJNLPを選びノードを登録した場合、推奨として？ masterが作った `cecret` 値を指定しての接続方法が提示されます。

![Slaveを登録したところ](/images/2017-04-23-agent.png)

ただ、これは

- masterが直接Jenkinsサービスをそのまま外側に出している

ことが前提であり、Webサーバが前に居る＆Basic認証などがかかってる場合、乗り越えるひつようがあるので、 上記の接続方法はそのまま使えません。

今回、実際「Basic認証のサーバを通す必要」があり、やってみたので書きます。

# 前提

- Jenkins(master)
  - CentOS6(in AWS)
  - [本家の入れ方](https://wiki.jenkins-ci.org/display/JENKINS/Installing+Jenkins+on+Red+Hat+distributions)したJenkins使用
  - Jenkins ver. 2.55
- Jenkins(slave)
  - Amazon Linu
    - AWSでくれる状態ほぼデフォルト
  - jnlpでコネクション張る(java -jar slave.jar起動)
    -`slave.jar` ver. 3.7

# やりかた

何のことはなく `slave.jar` の引数に指定する、なだけでした。

```
java -jar slave.jar -jnlpUrl https://[sarver]/computer/[agent名]]/slave-agent.jnlp -jnlpCredentials [user]:[password]
```

ただし、 `-secret` 指定とは排他なので「バッチ・スクリプト等に仕込んでる場合」は忘れず消すようにしましょう。

```
java -jar slave.jar -jnlpUrl https://[sarver]/computer/[agent名]]/slave-agent.jnlp -secret [secret] -jnlpCredentials jenkins:sniknej0

Exception in thread "main" java.io.IOException: -jnlpCredentials and -secret are mutually exclusive
       at hudson.remoting.Launcher.parseJnlpArguments(Launcher.java:375)
       at hudson.remoting.Launcher.run(Launcher.java:248)
       at hudson.remoting.Launcher.main(Launcher.java:218)
```

## 実は…

`slave.jar` に「てきとーな引数を放りこんだ時のUsage」にいろいろ書いてあって、それ先に見ればよかった話なんですけどね…。

```
java -jar slave.jar X

No argument is allowed: X
java -jar slave.jar [options...]
 -auth user:pass                 : If your Jenkins is security-enabled, specify
                                   a valid user name and password.
 -cert VAL                       : Specify additional X.509 encoded PEM
                                   certificates to trust when connecting to
                                   Jenkins root URLs. If starting with @ then
                                   the remainder is assumed to be the name of
                                   the certificate file to read.
 -connectTo HOST:PORT            : make a TCP connection to the given host and
                                   port, then start communication.
 -cp (-classpath) PATH           : add the given classpath elements to the
                                   system classloader.
 -jar-cache DIR                  : Cache directory that stores jar files sent
                                   from the master
 -jnlpCredentials USER:PASSWORD  : HTTP BASIC AUTH header to pass in for making
                                   HTTP requests.
 -jnlpUrl URL                    : instead of talking to the master via
                                   stdin/stdout, emulate a JNLP client by
                                   making a TCP connection to the master.
                                   Connection parameters are obtained by
                                   parsing the JNLP file.
 -noKeepAlive                    : Disable TCP socket keep alive on connection
                                   to the master.
 -noReconnect                    : Doesn't try to reconnect when a
                                   communication fail, and exit instead
 -proxyCredentials USER:PASSWORD : HTTP BASIC AUTH header to pass in for making
                                   HTTP authenticated proxy requests.
 -secret HEX_SECRET              : Slave connection secret to use instead of
                                   -jnlpCredentials.
 -slaveLog FILE                  : create local slave error log
 -tcp FILE                       : instead of talking to the master via
                                   stdin/stdout, listens to a random local
                                   port, write that port number to the given
                                   file, then wait for the master to connect to
                                   that port.
 -text                           : encode communication with the master with
                                   base64. Useful for running slave over 8-bit
                                   unsafe protocol like telnet
```

「Jenkins内蔵の認証」「PEMファイル」「Proxyの認証」など、わりかし「いろんな説奥手段」が出来ることが分かります。

---

# 小並感

本来は「Slave(となるマシン側)にパスワードなどを持ち込まない」ために `cecret` 式が推奨・一般化されているものだと思います。

Jenkinsは2.0になってから「普通に立てたらログイン必須になる」ので、それ以上の認証手段を積まなくてもだいだい大丈夫…ということから、この手段がより使いよいのだと思います。

てことは、いわば今回のは「先祖帰り」なのですが…少数派に落ちた途端に「世での例を探すor調べないといかん」となるので、面倒ですね。(最近そんなんばかりだ)
