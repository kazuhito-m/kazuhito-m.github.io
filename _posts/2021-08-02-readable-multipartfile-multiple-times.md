---
published: true
layout: post
title: Springの MultipartFile#getInputStream は何回呼んでも中身が取り出せる
category: tech
tags: [java, spring, multipartfile, mvc]
---

# これを読んで得られるもの

- 「 ` org.springframework.web.multipart.MultipartFile` の `getInputStream()` メソッドは何回呼んでも中身が取り出せる」ということの実証

# なぜ「読めない」と思い込んでいたのだろうか

本記事は [この記事](https://the-codeslinger.com/2020/09/06/spring-multipart-file-can-i-read-inputstream-multiple-times/) の翻訳&実証みたいなものなのですが…。

タイトルの通り __「Springの MultipartFile.getInputStream() は何回呼んでも中身が取り出せるのだ」__ ということを確認しました。

と、言うのも

__ 「Javaの `ServletRequest#getInputStream` メソッドは、複数回読むことができない(実行すると二回目が `IllegalStateException` を吐く)」 __

というよく知られた挙動があり、以前に「無理やり複数回呼べるように対応した」経緯から、 「 `MultipartFile#getInputStream` もどーせ複数回読めないんでしょ？」と思い込んでいたのです。

が、先の記事と「実際、読めたのを実証した」ので記録しときます。

## 実証

### 準備

1. [spring initializr](https://start.spring.io/) サイトで「SpringBootの雛形」を作成・DL
    - サンプルは Project: `Gradle Project',  Group: `com.kazuhitom`  とし、それ以外はデフォルト
    - Dependencies に `Spring Web` を加える
0. DLした `demo.zip` を展開

### 実装

展開したZipのフォルダに、 `package` の階層だけあわせて、以下のクラスを作成します。

<script src="https://gist.github.com/kazuhito-m/c8018d8888aef192dfd867aa124aad5a.js"></script>

`uplaod_test.sh` はテスト用のスクリプトなので、プロジェクトの直下など好きなとこに置いてください。

### 実行

`bash` を実行できるコンソールを開き、展開したZipフォルダまで移動、`gradle` にてSpringBootのWebアプリケーションを起動してください。

```bash
./gradlew bootRun
```

また別の `bash` を実行できるコンソールを開き、前述の `upload_test.sh` を実行してください。

```bash
chmod u+x ./upload_test.sh
./upload_test.sh
```

すると、SpringBootを起動した側のコンソールに、

![実行した際のSpringBoot側のコンソール](/images/2021-08-02-execute-springboot-console.png)

と出力され「 `multipartFile#getInputStream` が複数回呼び出されて、かつファイルの内容で読み出せてる」ことがわかります。

# 所感

最初に `以前に「無理やり複数回呼べるように対応した」`　と書きましたが、そのソース内でチームメンバーが「 `multipartFile#getInputStream` を二回呼んでいる」というコードを書いたので、それをレビューしたのですが…

「当人は動くと言っている…がそれが”以前の無理やり対応”によるものか、元々の仕様としてそう振る舞うのか」

が解らず、指摘すべきかを迷ったのです。

指摘するにも「実際に検証しないと指摘にもならない」ので、調べ始めた…のがこの記事の発端です。

「思い込みによるイチャモン」にならず、実際動かすことにより確証が得られたので良かったです。

---

ただ、これは「Streamとは別にメモリ中(あるいは一時ファイル)にデータを持っている」ということを意味するのかも？

ということは

- ちょっとずつ読み出しても意味ない(メモリの節約にならない)
- `readAllBytes()` とかしちゃうと、最低でも「実ファイル * 2の容量」のメモリを食う

かもしれませんね…。

# 参考資料

- <https://the-codeslinger.com/2020/09/06/spring-multipart-file-can-i-read-inputstream-multiple-times/>
  - この記事自体がこのサイトの翻訳のようなものです、感謝
- <https://stackoverflow.com/questions/4449096/how-to-read-request-getinputstream-multiple-times>
  - こちらは `ServletRequest#getInputStream` の振る舞いについて、二回以上呼ぶためには…の議論