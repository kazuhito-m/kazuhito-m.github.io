---
layout: post
title: JenkinsのURLパスの階層をずらす方法
category: tech
tags: [jenkins]
---

コレもまた「もひとつ探し方がわからなかった」やつで…。

# これを読んで得られるもの

- Jenkinsの公開しているURLパスの階層をずらす方法
  - 公式の方法でCentOSにインストールした場合の変更方法

# 経緯

Jenkinsを普通に起動すると `http://localhost:8080/` から参照可能で開始します。

運用していくにつれ

- セキュリティのためhttpサーバを前に通さないといけない
- しかしhttpサーバにはいろなサービスが載ってるため、パス下へずらしたい

などを行いたい場合が出てくることもあります。

しかし、「httpサーバでただバイパスする」だけでは、Jenkins側がそんなことを想定してないので、上手く動きません。

## nginxでの例

こんな `test.conf` ファイルを作り…

```
server {
    listen 80;
    location /jenkins {
        proxy_pass http://172.17.0.1:8080/; # Dockerコンテナ内から見た親サーバ
    }
}
```

`nginx` を起動 (docker経由)

```bash
docker run -v ${PWD}:/etc/nginx/conf.d -p 80:80 nginx
```

で、 `http://localhost` を表示。

![パスを変えたJenkins](/images/2017-04-25-jenkins-path-shift-top.png)

あれ？表示出来てる…「新しいジョブ」をクリックしてみましょう。

![新規ジョブを作成をクリック](/images/2017-04-25-jenkins-path-shift-link.png)

だめですね。内部でリンクのパスを考慮してくれません。

## 管理画面等でできれば良いのですが…。

「管理画面にそれっぽい設定は無いか」を探し、 Jenkinsの管理->システム設計を開くと、 `Jenkins URL` というのがあるのですが…。

![Jenkins URL](/images/2017-04-25-jeknins-setting-url.png)

これを変更しても解決しませんで…メール等「表示する箇所が変わる」だけの設定のようです。

これをなんとかしたので、紹介します。

# 前提

- CentOS 6.9
- Jenkins ver. 2.55
  - [公式の入れ方](https://wiki.jenkins-ci.org/display/JENKINS/Installing+Jenkins+on+Red+Hat+distributions) でインストールしたもの

# やりかた

何のことはなく「Jenkinsの引数に `--prefix` パラメータを指定するだけ」でした。

```
java -jar jenkins.war --prefix=/jenkins
```

これで `http://loalhost:8080/jenkins` がトップのURLとなります。


自身の環境は「CentOS6にyumで入れたもの」ですので、その場合は `/etc/sysconfig/jenkins` が設定ファイルとなります。そこに以下の設定を追加します。

```
...
JENKINS_ARGS="--prefix=/jenkins"
```

## nginxの例

先ほどの `test.conf` ファイルを「パスを下げた状態」で設定するには、

```
server {
    listen 80;
    location /jenkins {
        proxy_pass http://172.17.0.1:8080/jenkins; # １段さげて"jenkins"に
    }
}
```

と、Jenkinsのパスを１段下げた状態でバイパスすると、最初の目論見どおり `http://localhost/jenkins` でアクセス出来るようになります。

---

# 小並感

この話は「サーバのどこからどこへ中継するか」の際に、よく遭遇する問題なので「そのアプリ毎の設定」を調べる癖を付けないといけないなぁと。

転じて「自身でWebアプリを作る」際も、意識しておかないと対応できないので、意識しておきたく思います。
