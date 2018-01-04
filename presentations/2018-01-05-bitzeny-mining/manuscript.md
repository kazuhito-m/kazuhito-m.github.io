# 仮想通貨のマイニングに「適してる」のは？

----

## 今回は…

---

こんな感じ

![OrangePIタワー](image/tower.jpg)

に「廉価PCクラスタ」を組むつもりでしたが…。

---

## さーっぱりできなかった

ので、別のテーマとします。


----

## RPMとは何か

- `パッケージ管理システム` ならびに `ファイル形式`
  - コマンド名 `rpm` でもある
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
docker run -i -v ${PWD}/[お好みで]:/var/tmp/work -t centos /bin/bash
```

立ち上がったら

```
yum install rpmdevtools yum-utils
rpmdev-setuptree
```

※お好みでsudoなど
---

## 必要なフォルダ作成

```bash
mkdir -p build/{SOURCES,SPECS}
```

`build/SOURCES` に

- インストールしたいものを tar で固めたもの
- `*.spec` ファイル

を配置します。

---

## SPECファイル(.spec)について

もう[ここ](https://vinelinux.org/docs/vine6/making-rpm/make-spec.html)に頼りきり…。

---

## ビルド

```bash
rpmbuild -bb SPECS/searchandconv.spec
```

---

## インストール

```bash
rpm -ivh RPMS/noarch/searchandconv-1.0-1.noarch.rpm
```

---

# …がっ！

ビルドエラーで時間切れ！

教訓: コピペもいいけど…意味はわかろうね！

…今日中になんとかしよう…。
