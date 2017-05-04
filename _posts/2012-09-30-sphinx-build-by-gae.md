---
layout: post
title: JenkinsでビルドしたSphinxのHTMLをGoogleAppEngineで公開する

category: tech
tags: [cloudBees, google-app-engine, linux, phython, sphinx]
---

※Jenkins/Sphinxの装備・環境などは[前回](/tech/2012/09/19/sphinx-build-by-cloudbees)を参照してください。

Sphinx一切出てこないし、Jenkinsである必要もありませんが、「前回を前提に話す」のでご容赦を…。

ま、この話自体がポシャってしまったのですが、
「Sphinxドキュメントを無料にて多人数翻訳し公開する方法」の続きです。

# 経緯

翻訳に必要なものを以下のように定め、具体策を思案していました。

1. コミニュティ
0. ソース管理
0. ビルド環境
0. 成果物公開場所

で、前回1,2を決め、3は前回のテーマの通り「CloudBees:Jenkins」。

そして検討の結果、4は以下のようにしようかと…。

1. [Google Group](http://groups.google.com/)
0. [Assenbla](https://www.assembla.com/home/)
0. [CloudBees:Jenkins](https://www.cloudbees.com/)
0. [Google App Engine](https://cloud.google.com/appengine/docs?hl=ja)

なぜGAEにしたのか…今考えると、それである必要は無いのですが、

- 前から使って見たかった
- 閲覧制限させるのに、アクセス制限機構を自分で作りたくなかった
- コミュニティにGoogleGroupを使っており、絶対に垢あるし、親和性があると思って
  - 最初は「Group使ってアカウント管理を代行できないか？」を模索していた
- サーバ側はPythonが標準言語の一つで相性良いかなと。
- という「エゴと希望の入り混じった私的趣向」だったりしますw

---

# やること

さて、やりたいことは「GAEを無料の”成果物公開場所”としてHTMLなど静的ファイル置く」という話なのですが、本来の使い方ではないため、それ用のご作法(制約)と付帯作業があります。

この話には、先駆の方が多くいらっしゃるので、そちらを参照。

## 前提知識

- [https://developers.google.com/appengine/docs/python/gettingstarted/?hl=ja](https://developers.google.com/appengine/docs/python/gettingstarted/?hl=ja) (公式チュートリアル)
- [http://tatsuyaoiw.hatenablog.com/entry/20120209/1332065303](http://tatsuyaoiw.hatenablog.com/entry/20120209/1332065303)

## 事前作業

Sphinx関係なく、フツーにこの「HTMLを上げて公開する」作業のあらましは、

1. GAEのアカウント作成
0. 開発環境用意(今回ならPythonプロジェクトと見立ててPytonインストール)
0. GAE用開発環境「AppEngineSDK」をダウンロード、展開
0. 上げたい静的ファイルの構成に設定ファイルやらいくつかのファイルを装備する
0. デプロイ用コマンド(appcfg.py)を叩く

といった感じになります。

これを踏まえ、実際に構成を作っていく話へとすすめていきます。

## 前提

具体的な作業となるため、前提を置かせていただきます。異なる場合は適宜読み替えてください。

- ローカル(作業する自端末)はLinux(Ubuntu12.0)
- Python、Sphinxは導入済み(sudo apt-get install python-sphinx)
- Sphinxドキュメントの構成は本家チュートリアルにあるそのまま(sphinx-quickstart叩いた直後のもの)
- [http://sphinx-users.jp/gettingstarted/make_project.html](http://sphinx-users.jp/gettingstarted/make_project.html)
- ClowdBeesアカウント登録済み、Jenkinsジョブ作成済み(前回の記事)
- GAEアカウント作成済み

## Sphinxドキュメントへの「構成作り」とローカル(作業する自端末)からのデプロイ　

Jenkinsに「自動転送設定を作る」…の前に、準備とテストを兼ね、Sphinxドキュメントのディレクトリに装備を整え、自端末(ローカル)から、GAEに一度アップロードしてみます。

最終的にこんな感じの構成にします。

![ディレクトリ構成](/images/2012-09-30-sphinx-build-by-gae.jpg)

github(今回の場合は「Assenbla」)に、この形でコミットします。

追加部分は、"deploy"ディレクトリと、ファイル二つです。(この後に説明していきます)

このdeployディレクトリが、「GAEへのアップロード作業をする場所」という定義に思ってください。

※実際にsphinx-quickstartで作成した直後には、各ディレクトリはアンダーバー付きで生成されます。
しかし、「git上のディレクトリ名規則に違反」するため、この例では、ディレクトリ名と設定ファイルを変更しています。

conf.py の以下のパラメータ変更しておいてください。

```python
templates_path = ['templates']
exclude_patterns = ['build']
html_static_path = ['static']
```

ここから、装備を整えていくわけですが、まずは「ビルド（HTML成果物作成)」を実行します。

前回でこれは可能になっているはずですので、"sphinx-quickstartで作った基本構成"に移動し、

```bash
make html
```

すると `./build/html` に成果物が作成されます。

と、ここまでが前回クリアした箇所です。

GAEのアプリケーションの作成は、以下のページに行って、行ってください。(手抜

[https://appengine.google.com/](https://appengine.google.com/)

アプリケーションの作成の際、「認証オプション」の箇所は"Open to all Google Accounts users (default)"を選んでください。

deployディレクトリを作成し、設定ファイルを作成します。

```bash
mkdir ./deploy
cd ./deploy
vi app.yaml
```

ここで作成した `./deploy` ディレクトリが主なワークスペースと定義します。
viでなくともエディタは何でも良いのですが、 `app.yaml` 編集します。

このファイルは「GAEにPythonアプリケーションをデプロイする際の設定ファイル」で、公開ディレクトリや権限に関しての設定を指定するところです。

以下のように記述しましょう。

```
application: [あなたのアプリケーション名(URLの前半部分)]
version: 1
runtime: python
api_version: 1
handlers:
- url: /
  static_files: html/index.html
  upload: /
- url: /
  static_dir: html
```

上記の内容は

- アプリケーションの言語はPython
- 静的にトップディレクトリとして公開するのは `./html` (static_dir)
- ページ未指定時(/終わり)で表示するのは `./html/index.html` (staitc_files)

を表しています。

アップロードするのは `./html` と定義しましたので、最初に作成したHTMLを、作業場である deploy にコピーしておきます。

```bash
cp -r ../build/html/ ./
```

次に「GAEへデプロイする道具」をダウンロードし、展開します。

GAE用開発環境「AppEngineSDK(Python用)」です。

このページから、最新を確認してください。

[https://developers.google.com/appengine/downloads?hl=ja](https://developers.google.com/appengine/downloads?hl=ja)

現時点の最新は1.7.2ですので、ダウンロードします。

作業ディレクトリから一段上がり、Sphinxのトップディレクトリに移動し、DL・解凍します。

```bash
cd ../
wget http://googleappengine.googlecode.com/files/google_appengine_1.7.2.zip
unzip google_appengine*
```

これで道具はそろいました。デプロイしてみましょう。

```bash
./google_appengine/appcfg.py update ./deploy
```

途中、gmailのアドレスとパスワードを聞かれますので、入力してください。

正常に終われば、GAEに正しくHTMLがアップされます。

以下のURLから閲覧出来るか確認してください。

__http://[あなたのアプリケーション名].appspot.com/__

さて、無事にデプロイできたようなら、後片付け＆git反映します。

その際、先ほどのデプロイで生成された一つのファイルを、 `./deploy` ディレクトリにコピーしておきます。(理由は後の説明に)

```bash
cp ~/.appcfg_cookies ./deploy/
rm -rf ./build/* ./google_appengine* ./deploy/html/
git commit ./deploy -m 'うんたらかんたら'
git push
```

## CloudBees:Jenkinsからのデプロイ

ここまでくれば、後は「CloudBeesのJenkinsに同じコマンド仕込むだけ」なのですが、問題があります。

初回デプロイ中にあった「パスワードが打てない」のです。

そこで、先ほどコピーした .appcfg_cookies をつかいます。

このファイルは「2度め以降に、gmail/パスワードを打たなくても良くするファイル」で、実行ユーザのホームディレクトリ(~/)に配置すると自動認識します。

これを利用して、多少強引ですが、毎回実行ユーザ(jenkinsさん…だったと思います)のホームディレクトリに.appcfg_cokiesをコピーします。

(CloudBeesさん的には「ワークスペースを越えるファイル弄くり」は嫌がられると思いますが…)

上記を加味し、CloudBees:Jenkins上での作業は以下になります。

1. CloudBeesさんのJenkinsへログイン、前回作成したジョブの設定画面へ
0. 「シェルの実行」を追加し、以下のコマンドを記入(同じにも出来ますが、因果関係は無いので前回と分けてみましょう)

```bash
wget -q http://googleappengine.googlecode.com/files/google_appengine_1.7.2.zip
unzip google_appengine_*.zip > /dev/null
cp -r ${WORKSPACE}/build/html ${WORKSPACE}/deploy
cp ${WORKSPACE}/deploy/.appcfg_cookies ~/
${WORKSPACE}/google_appengine/appcfg.py update ${WORKSPACE}/deploy
rm -rf ./build/* ./google_appengine* ./deploy/html/
```

あとは、Jenkinsジョブの設定の[ビルド・トリガ]から[SCMをポーリング]をチェック、gitリポジトリに迷惑かけない程度の間隔(15分や1時間、あるいは日に一回など)にしておけば

__「gitコミットでGAEに自動的にデプロイされるSphinxドキュメント」__

の出来上がりです。

## 解決しきれなかった問題

Google側からGAE用開発環境「AppEngineSDK(Python用)」の新しいバージョンが提供されると、古いバージョンではデプロイ出来なくなるようです。

その場合、新しいのが出た都度

- ローカル端末で最新のSDKでデプロイを実行、.appcfg_cookiesをコピーしなおしgitコミット
- Jenkins側のコマンドのwget部分を新SDKのURLに変更

という作業が発生します。

## 閲覧制限について

GAEの設定ファイル app.yaml を変更することで、3種類の閲覧制限を掛けることができます。

1. 制限なし
0. Googleアカウントでログインした場合のみ
0. Googleアカウントがアプリケーションの管理者であり、ログインした場合のみ

上記の作業では、1.の状態となっています。

2. or 3. に変更するには、 `app.yaml` に以下の変更を行ってください。

```
application: [あなたのアプリケーション名(URLの前半部分)]
version: 1
runtime: python
api_version: 1
handlers:

- url: /
 static_files: html/index.html
 upload: /
 login: login (もしくは admin)
- url: /
 static_dir: html
 login: login (もしくは admin)
```

上記、 `login` 部分を追加してください。
"login"を指定した場合は2.、"admin"を指定した場合は3.の閲覧制限になります。

`admin` の場合、「アプリケーションの管理者に登録することで閲覧を許可していく」という運用になります。 ( [https://appengine.google.com/](https://appengine.google.com/) )

ダッシュボードから、[Administration - Permissions]をクリック、[Invite a user to collaborate on this application]へ「閲覧させたいGoogleアカウントのgmailアドレス」を指定してください。

(Roleは「設定変えられても困る」ので"Viewer"が良いでしょう。)

---

いかがだったでしょうか？

持ち運びと再現性を考え、「すべての道具は、都度ダウンロードして実行する」というアプローチをとりましたが、なにせ遅いのでこれが最善とは思いません。

「私はこうしていますよ！」というのがあれば、コメントでお教えください。
