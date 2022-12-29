---
layout: post
title: Fedora8に「ファイル名が日本語になる」解凍モジュール導入
category: tech
tags: [linux,archiver,install,japanize]
---

ここの記事を参考に…

[http://fun.poosan.net/sawa/index.php?UID=1195295202](http://fun.poosan.net/sawa/index.php?UID=1195295202)

以下からRPM落として導入。

[http://www.mediamax.com/ikoinoba_sawa/Fedora8/x86_64/](http://www.mediamax.com/ikoinoba_sawa/Fedora8/x86_64/)

- unzip-5.52-5.fc8_ja.x86_64.rpm
- lha-1.14iac20050924p1-2.fc8.x86_64.rpm

Unzipは、以前に入れていたので、RPMのオプション指定で、無理からねじ込みました。

```bash
rpm -i --replacefiles --oldpackage unzip-5.52-5.fc8_ja.x86_64.rpm
```

おお、ZIPの内容が日本語に！これは少し幸せかも。
