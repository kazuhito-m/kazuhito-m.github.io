---
layout: post
title: Dockerのイメージ/コンテナを他マシンへ移設するに最終的に"うりゃ！"っとしたはなし
category: tech
tags: [docker,backup]
---

あんまり…「成功例」でもないので…うまいことできる方、教えてください！

# これを読んで得られるもの

- 本家のインストール法でUbuntuに入れたDockerデータの「別マシンへの」引っ越し方法

# 前提

- 移行元 : Ubuntu 16.04 LTS -> 移行先 : Ubunut 16.10
- Docker version 1.12.5, build 7392c3b (移行元/先ともに)
  - Dockerのインストールは [本家のやり方](https://docs.docker.com/engine/installation/linux/ubuntulinux/) で `sudo apt-get install docker-engine` でおこなっている
- Dockerの設定はデフォルトで弄ってない
  - `/usr/bin/docker` に [setuid](https://ja.wikipedia.org/wiki/Setuid) で+sして一般ユーザで叩けるようにしたくらい
  - 「Dockerのデータファイル群のpath」はデフォルトの `/var/lib/docker`

# やったこと

## コマンドでなんとか…したかった

まずは「Dockerの標準装備で」なんとかしようとして…

```bash
#!/bin/bash

mkdir -p docker_all_export/{containers,images}

# image export
for i in $(docker images -q) ; do
  docker save $i > ./docker_all_export/images/$i.tar
done
docker images -a > ./docker_all_export/images/summary.txt

# container export
for i in $(docker ps -aq) ; do  
  docker export $i > ./docker_all_export/containers/$i.tar
done
docker ps -a > ./docker_all_export/containers/summary.txt

# archive
tar czf ./docker_all_export.tgz ./docker_all_export/
rm -rf ./docker_all_export/
```

みたいなスクリプトを作り「吐き出しまではやった」のですが、これを「取り込み」しようとした場合…

- save=イメージ -> load=イメージ
- export=コンテナ -> import=イメージ

なので

- どちらにしろ`Dockerイメージ`にしかならない
  - コンテナの復元は別途何かの手段で行わねばならない
- イメージ名、タグ、コンテナ名など「いろいろメモっといて手で復元」せなあかん

となれば「なんか思てたんとちゃう！」となったのです。

## しゃーなしで”うりゃ！”っと「ファイル一式コピー」

[前やった経験](/tech/2016/12/01/move-docker) を元に「もういっそのことファイル構造ごとコピーしたらいけんじゃね？」のノリで大雑把な仕事をしました。

### 移行元マシンでの作業

まずは「Dockerのデータディレクトリ」をごっそりtarで固めます。

```bash
# まず止める
sudo systemctl stop docker.service
# 一式固める
cd /var/lib
sudo tar czf /tmp/docker.tgz ./docker
```

### 移行先マシンでの作業

そして、Dockerインストール済みの移行マシンでそのファイルを取ります。(移行元にSSHだけは通してあります)

```bash
# こっちでも、まず止める
sudo systemctl stop docker.service
# ファイル取得
scp user@otherhost:/tmp/docker.tgz /tmp/
# 展開
cd /var/lib/
sudo mv ./docker/ ./docker_org/
sudo mv /tmp/docker.tgz ./
sudo tar xzf ./docker.tgz
# 再起動
sudo systemctl start docker.service
# 認識しているか確認
docker ps -a
CONTAINER ID IMAGE COMMAND CREATED STATUS PORTS NAMES
... なんかコンテナが出てたらOK ...
```

この後、`docker restart コンテナ名` で、他マシンで動かしてたコンテナを動かしてみましたが、今のところ「遜色なく使えて」います。

---

# 小並感

今のところ問題は起きていませんが、おそらく「Dockerの入れ方、Versionが一緒」だからなんとかなったのであって、わりかし「危ない橋(Version違いならいろいろ不具合出るたかも？)」ではないかと思います。

それもあって「おそらく、世の中には"正規の手段かつ楽ちん"がある」と思うので、そういうものがあれば教えて欲しく思います。

# 参考URL

以下を参考にさせていただきました。感謝。

- [http://uxmilk.jp/55512](http://uxmilk.jp/55512)
- [http://qiita.com/curseoff/items/a9e64ad01d673abb6866](http://qiita.com/curseoff/items/a9e64ad01d673abb6866)
