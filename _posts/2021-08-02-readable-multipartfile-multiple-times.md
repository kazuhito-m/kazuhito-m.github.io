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

「Javaの `ServletRequest#getInputStream` メソッドは、複数回読むことができない(実行すると二回目が `IllegalStateException` を吐く)」

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

# 所感


# 参考資料

- <https://the-codeslinger.com/2020/09/06/spring-multipart-file-can-i-read-inputstream-multiple-times/>
  - この記事自体がこのサイトの翻訳のようなものです、感謝