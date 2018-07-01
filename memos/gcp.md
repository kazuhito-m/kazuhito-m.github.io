# GCP で k8s と アプリケーションデプロイ をするまで


## GCP自体の入門

- GCP入門
  - <https://qiita.com/NagaokaKenichi/items/449902074e9994803cb8>
- GCP事前準備
  - <https://www.topgate.co.jp/gcp-getting-started-02>

## Compute Engine の話

- GCEの入門
  - <https://www.topgate.co.jp/gcp03-google-compute-engine-launch-instance>

### sshで端末から入っていく方法

基本的に「Webでコンソール操作」なので、クライアントからはできない。手間をかけて設定をしていく必要あり。

- gcloud compute ssh で入る方法
  - <https://www.topgate.co.jp/gcp03-google-compute-engine-launch-instance>
  - でもこれも「普通のsshじゃない」ので、準備がいる


## Kubernates engine
