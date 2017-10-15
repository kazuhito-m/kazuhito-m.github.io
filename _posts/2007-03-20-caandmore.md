---
layout: post
title: CAとか証明書とか
category: tech
tags: [linux,ssh,security]
---

ここらへんの認識甘かったの、復習をかねて、調べて設定してみました。

## ネタ元サイト

- 以下のサイトの内容を実践。
  - [http://www.aconus.com/~oyaji/www/certs_linux.htm](http://www.aconus.com/~oyaji/www/certs_linux.htm)

## メモ

```bash
openssl req -new -nodes -out sumpic_req.pem -keyout ./sumpic_cert.pem

946 openssl genrsa -des3 -out sumpic_ca.key 1024
958 openssl req -new -x509 -days 3650 -key sumpic_ca.key -out sumpic_ca.crt
963 openssl genrsa -des3 -out sumpic_ca.key 1024
967 openssl req -new -x509 -days 3650 -key sumpic_ca.key -out sumpic_ca.crt
969 openssl x509 -req -CA sumpic_ca.crt -CAkey sumpic_ca.key -days 3650 -in sumpic_req.pem -out sumpic_signed-req.pem -CAcreateserial
```

途中，自動起動できなくなったので、 [ここ](https://web.archive.org/web/20050314031832/http://mm.apache.jp/pipermail/apache-users/2001-April/000074.html)を参考。

rootにて

```bash
openssl rsa -in ./sumpic_ca.key -out ./sumpic_ca_rsa.key
```

とかやって、RSA化(？）してから、所定の場所にコピーしたらなおった。
よくわからない。調べよう。
