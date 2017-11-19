# RPMビルド入門

2017/11/19 Linux Kernel勉強会　2017年11月 - [#Linuxカーネル勉強会](https://twitter.com/search?q=%23Linuxカーネル勉強会&src=typd)


----

## よく考えたら…

Linux Kernelじゃなかった。

内部じゃないし、ディストリの領域。

そして、どちらかというと「運用」の類なので「利用者」側のお話。

ただ…「苦手なので勉強したかった」のです。(普段はUbuntu)

ご愛嬌でご勘弁ください。

----

## RPMとは何か

- `パッケージ管理システム` ならびに `ファイル形式`
  - 拡張子でもある

- `RPM Package Manager` と再帰的な名前になってる。
  - もともとは `Red Hat Package Manager`

---

## RPM…の前に

大きくは…

- パッケージ管理システム
  1. rpm : RedHat系
  0. dpkg : Debian系
  0. その他
    - pet : puppy linux
- パッケージ配布&管理システム
  1. rpm系
    - yum : RedHat,CentOS,AmazonLinux...etc
    - yast2 : SUSE
  0. dpkg系
    - apt : Debian,Ubuntu...etc

---

## RPMでは何が出来るのか

- Linuxディストリビューションへのパッケージのインストール行為全般
  - パッケージ: アプリ,コマンド,サーバ,マニュアルなど
- 同一のパッケージの更新
  - 付属の設定ファイルなどあればそのマイグレーションも
    - UIで選ばせることも多い


---

# …がっ！

思ったより、[広大](https://vinelinux.org/docs/vine6/making-rpm/make-spec.html)だ！

単位時間じゃ「ﾁｮｯﾄﾃﾞｷﾙ」出来ない！

---

## 最小セットでやってみよう

よく使う「元、先、対象ディレクトリを渡せば一括置換してくれるクソダサスクリプト」を、

「RPM作ってインストールする」と「全ユーザで使えるコマンドになる」を実践してみます。

---

## 環境整備

ご家庭にございますお手元のDockerから

```bash
docker run -i -t centos -v '[ホストの放り込みたいとこ]:/tmp/work'  /bin/bash
```

立ち上がったら

```
yum install rpmdevtools yum-utils
rpmdev-setuptree
```

※お好みでsudoなど
----

# 参考
