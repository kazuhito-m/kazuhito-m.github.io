---
layout: post
title: いろふさんなら横でビルドしてるけど#irof_history
category: tech
tags: [irof, irof_history, Jenkins, jenkins-plugin]
---

皆様、こんにちわろふ！

昨日の [@Posaune](https://twitter.com/Posaune) さんの「[僕のWPFがこんなにいろふさんなわけがない](http://posaune.hatenablog.com/entry/2012/12/08/011604)」に続きまして、
[いろふ Advent Calendar](https://atnd.org/events/34079) 8日目を担当致します [@kazuhito_m](https://twitter.com/kazuhito_m) と申します。

このカレンダーも８日目、皆様はいろっふぃーな日常をお過ごしでしょうか。

え、オレはどうって？ なんだよ”いろっふぃー”って？ふざくんな！

さて、いろふさんと言えば”S.G.P.G(すーぱーぐれーとぷろぐらまー)”。

実装はもちろん、テストもお手の物。

自動化アイディアもたくさん実用していることでしょう。

だれしも「あー、いろふさんが自分の近くに居てくれたら…」と思うはずです。

話は変わりますが、オレはJenkinsというCIサーバのプロダクトが大好きです。

「すごいと思うもの」と「大好きなもの」が合わさると…「デュフフ、コポォ」ってなってテンション上がっちゃいます。

ということで、そのJenkinsにいろふさんをご招待したいとおもいます♪

# いろふさんを我が家(現場)のPCにお呼びしましょう！

まず、Jenkinsをインストールします。

WinでもMacでもLinuxでも構いません。仲良くしましょう。

インストール後、 [http://localhost:8080/](http://localhost:8080/) にて、Jenkinsの起動を確認したら、「現在起動中のJenkinsのファイル展開場所」をさがします。

(Windows であれば、 `C:\Program Files\jenkins\` 以下、
Linuxの著名ディストリ(Ubuntu,CentOSなど)に放り込んでる場合は、 `/var/cache/jenkins/war` 、
tomcatなどのWebコンテナで動かしている場合は、各種展開場所を探してください。)

見つけたら、以下のディレクトリの二つのファイル

```
[Jenkins展開ディレクトリ]/images/
```

の `jenkins.png` , `title.png`
を [こちらのファイル](https://github.com/kazuhito-m/irofkins/tree/master/src/main/webapp/irof-images) に差し替えてください。

![右向きのirofさんは珍しい？](/images/2012-12-08-irofkins.png)

自家用執事「irofkinsさん」が爆誕しました。

# いろふさんに叱って貰おう！

次に、いろふさんの「ありがたい訓示」をいただきましょう。

テストにも精通したいろふさんのこと、コケているとか…きっと許せない感じじゃないかと思います。
そういうのを見つけた時には、いろふさんから表情での「お叱り」を受けるようにします。

まずは「Emotional Jenkins」というプラグインをインストールします。

左メニューから[Jenkinsの管理]-[プラグインの管理]-["利用可能"タブ]とクリックし、"Emotional Jenkins Plugin"を選択後、インストールのボタンをクリックしてください。

このプラグインは、ジョブの設定から[ビルド後の処理]で"Emothional Jenkins"を追加することにより、ビルドにエラーやテストNGが出た場合に、結果画面で「執事さんの表情が変わる」というものです。
[http://d.hatena.ne.jp/masanobuimai/20110806/1312567337](http://d.hatena.ne.jp/masanobuimai/20110806/1312567337)

そして、このプラグインの「表情画像」もいろふさん仕様にしちゃいます。

プラグインは個々環境に依存するので、”アプリ側”でなく”データ側”のディレクトリにあります。
データが入っているディレクトリは、[設定]の[ホームディレクトリ]で確認できます。

![ホームディレクトリ](/images/2012-12-08-home-dir.png)

```
[ホームディレクトリ]/plugins/emotional-jenkins-plugin/images/
```

の `angry-jenkins.png` `jenkins.png` `sad-jenkins.png`
を [こちらのファイル](https://github.com/kazuhito-m/irofkins/tree/master/src/main/webapp/irof-images)に差し替えてください。

すると、次回のビルドから、いろふさんが感情豊かに結果を伝えてくれます。

![テストNGでさめざめと悲しむいろふさん](/images/2012-12-08-sad-irof.png)
![コンパイルエラーにちょいギレのいろふさん](/images/2012-12-08-angry-irof.png)

これで「万が一ビルドが壊れた場合」も(心理的効果によって)素早く検知でき、(主に自分たちの奮闘によって)素早く直すことができるので安心ですね♪

# いろふさんにずっと居て貰おう！

さて、いろふさんをお呼びすることも、働いてもらうことも成功しましたが、このままでは「本体やEmotional Jenkins Pluginのアップデート」の度に帰られ(画像が上書きされ)てしまいます。

そこで…「ずっと引き止めておくプラグイン」を作りました。

![バージョン番号が苦労を語ります(ネタ的な意味で)](/images/2012-12-08-irofkins-credit.png)

- plugin本体 : [https://www.dropbox.com/s/np0vhzrjvgoubts/irofkins.hpi](https://www.dropbox.com/s/np0vhzrjvgoubts/irofkins.hpi)
-  source : [https://github.com/kazuhito-m/irofkins](https://github.com/kazuhito-m/irofkins)

---

- @kiy0taka 様のソースをほぼそのまま使いしました。すみません。
  - [http://www.slideshare.net/kiy0taka/jenkins-7120743](http://www.slideshare.net/kiy0taka/jenkins-7120743)
  - [https://github.com/kiy0taka/filter_sample](https://github.com/kiy0taka/filter_sample)
- アンインストールにて解除出来ます。
- あくまでも「記念アプリ」です。「他のプラグインの挙動を曲げる」などお行儀の悪いことをしていますので、良い子は真似しない＆本運用では使わないでくださいませ♪

原理的には「画像へのリクエストをすべて横取りして、別画像に差し替える」というもの。
少し処理のオーバーヘッドはかかりますが、いろふさんが居てくれるならお安いもんです♪

---

いかがだったでしょうか。

__これで「いろふさんなら今横でビルドしてるけど」を既成事実とできますね。__

でも、いろふさんは「分裂できる」と噂なので「皆様のPCに来てもらう」でみんな幸せ♪ということにしましょう。

明日は [@razon](https://twitter.com/razon) さんの「[我々はいろふだ](http://shizone.github.io/2012/12/09/0011/)」です。
