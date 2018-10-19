GKEにGrowiを立てるまで
==================

# 概要

GKE上で、Growiを起動させる。

基本的には「Growi公式のdocker-compose構成を模倣」する。

https://github.com/weseek/growi-docker-compose/blob/master/docker-compose.yml

# やること

## 用意

```bash
sudo apt-get update && sudo apt-get --only-upgrade install kubectl google-cloud-sdk google-cloud-sdk-app-engine-grpc google-cloud-sdk-pubsub-emulator google-cloud-sdk-app-engine-go google-cloud-sdk-cloud-build-local google-cloud-sdk-datastore-emulator google-cloud-sdk-app-engine-python google-cloud-sdk-cbt google-cloud-sdk-bigtable-emulator google-cloud-sdk-app-engine-python-extras google-cloud-sdk-datalab google-cloud-sdk-app-engine-java
```

## GCP内にプロジェクト作成

```bash
gcloud init
gcloud config set compute/zone asia-northeast1-a
```

プロジェクト名は `kfa-growi-on-gke` とした。

## Dockerイメージをアップロード

Growiのdocker-composeで「その場でビルドするファイルはGrowi本体のDockerfileだけ」である。

それをビルドし、GCP上にUploadする。

```bash
GCP_PROJECT=$(gcloud config get-value project)
echo ${GCP_PROJECT}

GCP_PROJECT=$(gcloud config get-value project)
git clone https://github.com/weseek/growi-docker-compose.git growi
cd growi

# Container Registryの格納先をタグにしてDockerイメージをビルドする
# タグの形式は、asia.gcr.io/[GCP_PROJECT_ID]/[IMAGE_NAME]:[TAG]
docker build -t asia.gcr.io/$GCP_PROJECT/growi-for-compose:3.0 .

# DockerイメージをContainer Registryにアップロード
# ※GCP APIに課金設定をしてない場合、途中で止められるので表示されるURLから設定する事。
gcloud docker -- push asia.gcr.io/$GCP_PROJECT/growi-for-compose:3.0

```

## 永続ディスク(PersitentVolume)を作成する

本家は、docker-composeで「volumes」作成しているところを、Persistent Volumeで代用する。

```bash
gcloud compute --project=$GCP_PROJECT disks create growi-disk \
  --zone=asia-northeast1-a \
  --type=pd-ssd \
  --size=10GB
```

が、結局使わなかった(いまは繋いでない)ので、消した。

## GKEのクラスタを作成

```bash
gcloud container clusters create --num-nodes=1 --disk-size=32G kansai-free-alliance-wiki
# 削除したい場合は、以下
# gcloud container clusters delete kansai-free-alliance-wiki
```

作成できたら、コマンドを其のクラスタに、 `gcloud container clusters get-credentials xxx` つなぐ。(コンソールのUIから「接続」を押せばClopBordにコピーされる)

## GKEにGrowi用のコンテナ３つ立てる

[こちらのやりかた](https://github.com/kazuhito-m/cloud-orchestration/tree/master/gcp/gke/growi#instration) で、クラスタにコンテナを３つ建てます。

## Growiのデータの復元する

[こちらのやりかた](https://github.com/kazuhito-m/cloud-orchestration/tree/master/gcp/gke/growi#other) で、以前 `mongodump` で取得した、データを復元します。

ただし、「パスワードがダメになる」ので管理者権限で発行する必要があります。

# 参照

## 入門・概要把握

- Kubernetesを用いてGoogle Container Engineでコンテナクラスタをデプロイする〜入門編〜
  - <https://qiita.com/yusukixs/items/11601607c629295d31a7>
- Kubernetes こと始め (1)
  - <http://taizo.hatenablog.jp/entry/2016/09/11/213005>
- Kubernetes 速習会
  - <https://qiita.com/koudaiii/items/d0b3b0b78dc44d97232a>
- Deployment
  - <https://cloud.google.com/kubernetes-engine/docs/concepts/deployment>
- Kubernetesを用いてGoogle Container Engineでコンテナクラスタをデプロイする〜設定ファイル編〜
  - <https://qiita.com/yusukixs/items/f2cafb5ae2e770571d39>
- GKEでkubernetesを理解する
  - <https://qiita.com/ntoreg/items/74aa6de2f8f29b4a3b79>
- Google Container Engine (GKE) での Dockerイメージを使ったコンテナの起動方法！
  - <https://www.topgate.co.jp/gcp07-how-to-start-docker-image-gke>

## kubectl

- kubectlチートシート
  - <https://qiita.com/mumoshu/items/19392308cdadf8667fdd>
- kubernetes : kubectlコマンド一覧
  - <https://qiita.com/suzukihi724/items/241f7241d297a2d4a55c>

## ネットワーク周り

- 逆引き GKE ネットワーク編
  - <https://qiita.com/nirasan/items/dc65b813dd754f8df2ed>
- Kubernetes1.10 Cluster内DNSの挙動確認
  - <https://qiita.com/sugimount/items/1873d9d332a25f5b0167>
- Google Compute Engineでssh接続、ポート開放
  - <https://qiita.com/tukiyo3/items/03ceb69e97e8cb89f624>
- GKEでコンテナ作成／管理しよう！
  - <https://blog.grasys.io/post/dokuma/1st-step-kubernetes/>

## yamlの書き方

- Define Environment Variables for a Container
  - <https://kubernetes.io/docs/tasks/inject-data-application/define-environment-variable-container/>

## DockerhubとContainer Repository周り

- kubernetes 上で Docker Hub にあるイメージからコンテナを立ち上げる
  - <https://hawksnowlog.blogspot.com/2018/03/run-docker-hub-images-on-kubernetes.html>


## ストレージ(永続化)系を同扱うかばなし

- KubernetesのConfig＆Storageリソース
  - <https://thinkit.co.jp/article/14195>
- GKEでPersitentVolumeを使う
  - <https://akaimo.hatenablog.jp/entry/2018/05/25/232515>
- kubernetesでPersistent Volumesを使ってみる
  - <https://ishiis.net/2017/01/08/kubernetes-storage/>

## DNS関連

- kubernetesにingressを導入する方法
  - <https://qiita.com/Hirata-Masato/items/8e6b4536b6f1b23c5270>

## dashbotd関連

- Kubernetes Dashboardにcluster-admin権限でSign inする
  - <https://qiita.com/h-sakano/items/79bb15f7a0661e141c75>

## エラー解析系

- Kubernetes Engineでの Cloud Endpoints のトラブルシューティング
  - <https://cloud.google.com/endpoints/docs/troubleshoot-gke-deployment?hl=ja>
- GKEでEXTERNAL-IPがpendingのとき
  - <https://qiita.com/m2mtu/items/dcb02e9ee2f34b78ead7>
- GKEを使用している時に陥りがちな罠とトラブルシューティングについて
  - <https://qiita.com/tkow/items/e256c0a50c4b2c832c52>
- fit failure summary on nodes : Insufficient cpu (1)
  - <https://qiita.com/mochizukikotaro/items/ea22b77be3d1d00e2af7>
- トラブルシューティング
  - <https://cloud.google.com/kubernetes-engine/docs/troubleshooting?hl=ja&_ga=2.210494869.-1209171872.1533100153#workload_issues>
