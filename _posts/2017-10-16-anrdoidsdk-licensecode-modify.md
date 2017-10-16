---
layout: post
title: 2017年10月中旬くらいからAndorid SDKのコンソールからのダウンロードが出来なくなる問題
category: tech
published: true
tags: [android,build]
---

時勢のものなんで、たぶん今月くらいしか役に立たない記事ですが、ハマったんで書いときます。

# これを読んで得られるもの

- AndroidSDKをコンソールからダウンロード( `gradle test` 等で)運用している場合のトラブルシュート

# 経緯

自分は「ポータビリティを持った”Android画面テスト環境”を作りたい」ということから、[AndroidSDKをセットアップするDockerfile](https://github.com/kazuhito-m/dockers/tree/master/android-emulator-headress) を作成しています。

その `docker build` が「2017年10月12日から失敗するように」なりました。

## 詳細

`Android Studio` で作られたプロジェクトを `gradle` でコンソールからテストする場合、予め `android-sdk_r24.3.4-linux.tgz` など `Android SDK` をダウンロード/配置した後、

```
./gradlew test
```

を実行すれば出来ます。(初回実行時にSDK絡みの必要なファイルをダウンロードします)

その際「(GUI等で)ライセンスに同意したか」を確認するため、

- `${ANDROID_HOME}/licenses/android-sdk-license`
- `${ANDROID_HOME}/licenses/android-sdk-preview-license`

というテキストファイルの存在と内容を確認します。

そこを回避するため「SDKインストール後に、予めファイルを配置しておく」という"やり方"があります。

- <https://qiita.com/Nkzn/items/b9a0ddd1345fb78d7d44>
- <http://d.hatena.ne.jp/itog/20170414/1492146400>

(SDKインストールした他端末から持ってきても良いですし、そのファイル内容も固定でなので拾ってきてもOKです)

## で、今回の問題

…のはずで実績ありだったのですが、2017年10月12日から失敗するようになりました。(Dockerイメージのキャッシュがあったので、少しもっと前からかもしれません)

```
./gradlew test

...(中略)...

Download https...(略、リポジトリからjar群ダウンロード)

File /root/.android/repositories.cfg could not be loaded.
Checking the license for package Android SDK Build-Tools 21.1.2 in /opt/android-sdk-linux/licenses
Warning: License for package Android SDK Build-Tools 21.1.2 not accepted.
Checking the license for package Android SDK Platform 23 in /opt/android-sdk-linux/licenses
Warning: License for package Android SDK Platform 23 not accepted.

FAILURE: Build failed with an exception.

* What went wrong:
A problem occurred configuring project ':app'.
> You have not accepted the license agreements of the following SDK components:
  [Android SDK Build-Tools 21.1.2, Android SDK Platform 23].
  Before building your project, you need to accept the license agreements and complete the installation of the missing components using the Android Studio SDK Manager.
  Alternatively, to learn how to transfer the license agreements from one workstation to another, go to http://d.android.com/r/studio-ui/export-licenses.html

* Try:
Run with --stacktrace option to get the stack trace. Run with --info or --debug option to get more log output.

BUILD FAILED
```

licenseで文句言われてる…が、変えた覚えないで！

# やったこと

## 原因

許可される `${ANDROID_HOME}/licenses/android-sdk-license` ファイルの内容が変わったようです。

([ちょうどその日でStackOverflowにコメント](https://stackoverflow.com/posts/46686336/revisions)が付いていました。)

`android-sdk-license` が

```

8933...(略
```

と、(空行が一行目で)二行だったものが、

```

8933...(略

d56f...(略
```

の四行に成ったのかな？(特性上、なんとなくハッシュを書くのをためらうな)

## 修正

配置する `android-sdk-license` ファイルを、前述の原因の通りに変更しました。

自分の場合は、`Dockerfile` 内で `echo` 使ってファイルを作ってるので…

```
RUN echo -e "\n8933...(略)" > "$ANDROID_HOME/licenses/android-sdk-license"
```

を、

```
RUN echo -e "\n8933...(略)\n\nd56f5...(略)" > "$ANDROID_HOME/licenses/android-sdk-license"
```

にしました。

---

# 所感

ググッても「困ってる人」が居ない感じ(だから自分はトラブルシュートに時間がかかった)でした。

もしかしたら「コンソールオンリーでAndroidSDK動かしたい人」「AndroidStudioのインストールをせずにビルドしてる人」があまり居ないのかな？…はたまた「常識レベルの話」で話題にすらでないのか。

なんか「やり方間違えてる」んじゃないかと不安です。
