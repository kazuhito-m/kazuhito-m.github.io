---
layout: post
title: Microsoft Translator Text APIを使う(2017/04版)
category: tech
tags: [groovy, ms-traslator-text-api, azure, cognitive-services]
---

最初は「gitの日本語ブランチ名むかつく！変換したろ」から「タダである程度使える翻訳APIを」と思ったのですが…なんかハマってしまいまして。

# これを読んで得られるもの

- 一定文字数までは月額無料の高品質な翻訳をプログラムで使う手段
- `Microsoft Translator Text API(Azure:Cognitive Services)` の利用方法

# 経緯

無料の翻訳APIを探して、 `Microsoft Translator API` にたどり着いたのですが、サンプルの通り書いても「翻訳できたり[エラー起こしたり](https://www.drupal.org/node/1705828)」となって…「これ、ホンマに信頼あるAPIなん？」と思ったんです。

ま、それは「やり方おかしい」のだろうとおもうのですが、どうやら…

- 2012年くらいからある `Microsoft Translator API` は一旦廃止になる
  - 古いURLとトークン取得しているところはこの3月中に書き換えてね(つまり今ホントは使えない)、とのこと
- `Azure` の `Cognitive Services` の一部に同等のサービスが組み込まれる
  - 後継は `Microsoft Translator API` 中の `Text API` となる
    - `Speech API` もあるのでこんな感じに
  - 料金条件は一緒、「二百万文字までは無料」も健在

という話なようです。


# 前提

- Azureのアカウントは登録済み
- 実装はGroovy
  - JenkinsのPipelineスクリプト(Jenkinsfile)での使用想定

# やりかた

## 実装

Groovyにて実装した例を示します。

※上記の前提のため「極力原始的なJavaのAPIで組んで」ます。

```Groovy
import javax.net.ssl.HttpsURLConnection
import java.net.URLEncoder

def getToken(key) {
  def authenticationUrl = "https://api.cognitive.microsoft.com/sts/v1.0/issueToken"
  def conn = new URL(authenticationUrl).openConnection()
  conn.setRequestMethod("POST")
  conn.setDoOutput(true)
  conn.setRequestProperty("Ocp-Apim-Subscription-Key", key)
  conn.getOutputStream().write(0)
  return conn.getInputStream().text
}

def translate(target, from, to, token) {
  def appId = URLEncoder.encode("Bearer ${token}", "UTF-8")
  def text = URLEncoder.encode(target, "UTF-8")
  def translatorTextApiUrl = "https://api.microsofttranslator.com/v2/http.svc/Translate?appid=${appId}&text=${text}&from=${from}&to=${to}"
  def conn = new URL(translatorTextApiUrl).openConnection()
  conn.setRequestMethod("GET")
  conn.setRequestProperty("Accept", "application/xml")
  def withTag = conn.getInputStream().text
  return withTag.replaceAll("<.+?>", "");
}

// 実行部

def SUBSCRIPTION_KEY = "[ご自身の取得されたサブスクリプションキーを設定]"

def from = "ja"
def to = "en"
def target = '日本語から英語へと訳すことは可能ですか？'

def token = getToken(SUBSCRIPTION_KEY)
def result = translate(target, from, to, token)

println "翻訳結果 : ${result}"
```

上記ソースの`from`,`to`は「翻訳言語の指定」です。

実行すると、

![こんな感じ](/images/2017-04-15-exec-traslate.png)

な感じ。

## 事前準備として「AzureのCognitive Servicesのサブスクリプション」作成

上記ソース内で「環境設定に類するもの」は `SUBSCRIPTION_KEY` の「サブスクリプションキー」(サブスクリプションIDと言うハッシュっぽいやつとは別、ややこしい)だけです。

順序前後しますが「これを取得する方法」を説明します。

…と、言っても[リンクに丸投げ](https://docs.microsoft.com/en-us/azure/cognitive-services/cognitive-services-apis-create-account)なのですがｗ

少し前のAzureですので、若干UIが異る＆英語表示ですが、適宜なんとかしてください。

登録後、そのサブスクリプションを選び、 `keys` をクリック、 `key1`,`key2` のどちらかの値をスクリプトに仕込んでください。

![Azure内のサブスクリプションキー取得](/images/2017-04-15-get-subscription-key.png)

---

# 小並感

日付を限定してググっても「古い方の情報ばかり出てくる」ので、案外この情報にたどり着くのは困難なんだろうなーと思いました。

…使ってる人少ないんかな？

# 参考URL

以下を参考にさせていただきました。感謝です。

- [参考にさせていただいたソース(Java製)](http://stackoverflow.com/questions/42891510/microsoft-translator-api-java-how-to-get-client-new-id-with-azure)
- [Text Translation API一覧](http://docs.microsofttranslator.com/text-translate.html)
- [公式の](https://www.microsoft.com/ja-jp/translator/getstarted.aspx)
- [AzirePortalでCognitiveServiceAPIのアカウントを作る方法](https://docs.microsoft.com/en-us/azure/cognitive-services/cognitive-services-apis-create-account)
- [新の例（JS）](http://qiita.com/helicalgear/items/d34fac20d68f17e75406)
