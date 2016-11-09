# Chapter 19. RPM Packages and YUM Repositories

- 英語と日本語はどちらかしか書かない、併記しない


## 19.1. Introduction

RPMパッケージとRPMパッケージマネージャソリューションのyumは、Red Hat, CentOS, Fedora, Oracle Linux, SUSE, openSUSE, Scientific Linuxおよび他のようなLinuxベースのオペレーティング・システム上のデフォルトのアプリケーションのパッケージマネージャとして使用されています

「ネクサスリポジトリマネージャープロ」と「ネクサスリポジトリマネージャOSS」のyumのリポジトリのサポートを使用すると、yumのリポジトリ形式でMavenのリポジトリにホストされているRPMパッケージを公開することができます。

これは、yumのメタデータを生成、yumのサポートを備えたシステムでは、ソフトウェアパッケージのリポジトリとしてリポジトリマネージャを使用することができます。

これは、JavaやLinuxコンピュータへのMavenのリポジトリを介して他のJVMベースのアプリケーションのビルドとデプロイメントパイプラインを可能にします。

例えば、Javaのエンタープライズ・アーカイブ（EAR）またはWebアーカイブ（WAR）またはいくつかの他のアプリケーションは、Mavenのリポジトリにデプロイされます。

デプロイは、Mavenのまたは他のビルドシステムを使用して、CIサーバの構築によって、または手動でデプロイされます。

リポジトリマネージャへアプリケーションのRPMパッケージをホストすると、それをテストと本番システムでのインストールとアップデートのyumを介して検索することができます。

RPMパッケージのメタデータは、追加的に含む他の必要なパッケージのインストールを開始することができます。(例えばJavaランタイムまたはアプリケーション・サーバー、など)

## 19.2. Installation and Requirements

「Yum support」
は「プロネクサスリポジトリマネージャ」と「ネクサスリポジトリマネージャOSS」、それ以上のインストール手順は必要ありませんがバンドルされています。

これは、リポジトリマネージャサーバを実行しているオペレーティング・システムにインストールすると、PPath上で利用できるようにするためのコマンド「createrepo」と「mergerepo」に依存しています。

これらのコマンドについてのドキュメントは、「createrepoのウェブサイト」上で見つけることができます。

典型的には、「createrepo」はRPMベースのLinuxディストリビューションにインストールされ、そのように彼らはyumををサポートしたリポジトリマネージャを実行するのに適しているとされています。

望むなら、コマンドへのPathは、ユーザインタフェースで設定することができます。

---

あなたのRPMベースのシステムでは、このコマンドを持っていない場合は、実行してインストールすることができます。

```bash
yum install createrepo
```

特権ユーザでの実行が必要です。

## 19.3. Configuration

yum関係の設定は、第6.6項「アクセスと機能の設定」に記載されている機能管理で行われます。

yum機能 : 設定は、yumのサポートを有効または無効にすることができます。

createrepoとmergerepoコマンドをリポジトリマネージャによって見つけることができる場合にのみ、正常に有効化することができます。

デフォルトでは、Path上にそれらを探します。

「mergerepo」の「createrepo」とパスの構成設定のPathを使用すると、代わりに特定の絶対パスを設定することができます。

パラメータ「並列スレッドの最大数(Max number of parallel threads)」のデフォルトは”10”であり、そしてそれは「どれだけの量のスレッド群でcreaterepoとmergerepoコマンドを使ったyumリポジトリ管理をするか」を定義します。

あなたは、リポジトリの特定の構成に進む前に、「この機能が有効になっていること」を確認する必要があります。

「ステータス(Status)」タブには、createrepoとmergerepoための検出バージョンを表示し、該当するすべての問題を詳しく説明します。

### 19.3.1. Configure Hosted Yum Repositories

yumを経由して「Release」のような「Mavenのリポジトリ」を公開するには、「capabilities configuration」タブで「New」ボタンを押すと、ダイアログが表示されるので、「Type:」ドロップダウンから「Yum: Generate Metadata」を選びます。

図19.1、「ホストされているリリースのリポジトリのyumの設定」。

「Repository」ドロップダウンあなたがホストされているMavenのリポジトリを選択することができます。

リリースだけでなく、スナップショットポリシーのリポジトリを設定することができます。

一度設定すれば、ホストされたMavenのリポジトリに追加されたRPMパッケージがyumを介して利用可能です。

Mavenのベースのアクセスに使用されるリポジトリの同じURL、例えば…

`http://localhost:8081/nexus/content/repositories/releases`

そして、リポジトリ管理エリアのリストに表示され、yum設定でのyumリポジトリのURLとして使用することができます。


yumの統合リポジトリ上のバージョン管理ビューをサポート。

URL `http://localhost:8081/nexus/service/local/yum/repos/releases/1.2.3/` が、 `releases` リポジトリ内のバージョン1.2.3を持つすべてのパッケージをyumのリポジトリを公開しています。

カスタムrepodataフォルダがコンテキストで利用可能です。

`Aliases` フィールドは、特定のバージョンへの代替アクセス・パスを定義するために使用することができます。

たとえば、あなたはの別名値を以下のように設定出来ます。

```
production=1.2,testing=2.0
```

この設定値では、順番に version 1.2 なら `http://localhost:8081/nexus/service/local/yum/repos/releases/production/`、 version 2.0 なら `http://localhost:8081/nexus/service/local/yum/repos/releases/testing/` というふうにURLを公開します。

静的なURLは、新しいバージョンへのアップグレードを可能にするので、単純に別名を変更することにより、ターゲットサーバー上のyum設定でこれらのURLを使用でき、例えば `production=1.3` 、ターゲットサーバ上のyum updateコマンドを実行できます。

"capability administration"にエイリアスを維持することに加えて、コマンドラインでのエイリアスを作成または更新することが可能です。

```bash
curl -d "1.0" --header "Content-Type: text/plain" http://localhost:8081/nexus/service/local/yum/alias/releases/development/
```

エイリアスベースのURLの使用方法は、通常のyumの構成例を介して行われます。

例えばファイル `/etc/yum.repos.d/nexus-production.repo` と以下の内容

```
[nexus-production]
name=Production Repository
baseurl=http://localhost:8081/nexus/service/local/yum/repos/releases/production/
enabled=1
protect=0
gpgcheck=0
metadata_expire=30s
autorefresh=1
type=rpm-md
Promote RPM through Stages
```

新しいバージョンを展開し、バージョンにエイリアスの関連付けを切り替えることにより、対象サーバにRPMアーカイブの新バージョンのロールアウト制御を達成することができます。

設定オプションの `Process deletes` と `Delete process delay` は、yumのメタデータへの更新を可能にするために使用することができます。Mavenのリポジトリにrpmパッケージの削除操作を以下に示します。

`Yum groups definition file` の設定を使用すると、パッケージグループの設定ファイルへのパスを設定することができます。

このファイルは、典型的には、　`comps.xml` という名前で、RPMパッケージのグループを定義するために使用することができます。

このようなグループは、`yum grouplist`、`yum groupinstall`と `yum groupremove` のようなコマンドを使用して管理することができます。

保存されると、`Status`　タブには、リポジトリにアクセスするための例のyum設定を表示します。

リポジトリにデプロイされている各RPMはすぐにyumのメタデータを更新するためのリポジトリマネージャが発生します。

yumをで使用されるメタデータは、repodataコンテキストで利用可能です。

例えば、 `…/nexus/content/repositories/releases/repodata` 以下のファイルがそうです。

別のrepomd.xmlファイルは、ファイルはキャッシュの問題を回避するために、名前の一部として一意のハッシュ値で先頭に追加されます。

- repomd.xml
  - このXMLファイルは、他のメタデータファイルに関する情報が含まれています。
- hash-primary.xml.gz
  - このzip形式のXMLファイルには、リポジトリ内の各RPMアーカイブの主メタデータを記述する。
- hash-filelists.xml.gz
  - このzip形式のXMLファイルには、各RPMアーカイブに含まれるすべてのファイルについて説明します。
- hash-other.xml.gz
  - このzip形式のXMLファイルには、各RPMアーカイブに関するさらに、雑多な情報が含まれています。

### 19.3.2. Proxying Repositories

yumの統合（機能）は、リモート・ネクサスリポジトリマネージャサーバからのyum対応のMavenリポジトリのプロキシすることができます。

これらのリポジトリ内のメタデータは、絶対URLが含まれており、これらのURLを使用することがyumを引き起こします。

機能`Yum: Proxy Metadata`は、プロキシリポジトリ上で設定することができます。

これは、メタデータ内のURLを書き換え、現在のリポジトリマネージャのために修正されるようになります。

これは、プロキシリポジトリは、リポジトリ・グループの一部であるとグループにマージされたメタデータの作成を経て、正しいyumのメタデータを公開することができます。

### 19.3.3. Configure Repository Group for yum

yumするMavenのリポジトリのグループを公開するには、単純にタイプ`Yum: Mearge Metadata`を追加し、Groupドロップダウンでリポジトリのグループを選択します。

図19.2、「ホストされているリリースのリポジトリのyum設定」 は、yumのために構成された `Public Repositories` の `Settings` タブを示しています。

この構成では、リポジトリグループ内のすべてのリポジトリのyumのメタデータをマージするリポジトリマネージャが発生します。

メタデータの生成は、グループの一部として公開されるように、所望の個々のリポジトリのために設定されなければなりません。

リポジトリグループのURLは、今yumの設定でのyumリポジトリのURLとして使用することができます(同じメタデータ・ファイルが維持され、ホストされたリポジトリ内のような　`repodata` コンテキストを介して公開されているので)。

### 19.3.4. Scheduled Tasks

特定のリポジトリのための `createrepo` とyumのメタデータを生成するために実行することができる`:Yum: Generate Metadata` 「yumサポート」と呼ばれるスケジュールされたタスクが含まれています。

典型的には、このタスクを実行する必要はありませんが、RPMファイルが既にリポジトリに存在したり、メタデータの手動でトリガ更新を必要とするいくつかの外部モードで展開されている場合、それが役立ちます。

`Optional Output Directory` パラメータは、リポジトリのルートのデフォルトの `createrepo`  とは別のフォルダに作成されたメタデータを取得するために使用することができます。

yumのメタデータを作成する際に考慮にMavenのリポジトリ内のディレクトリごとに1つだけのRPMファイルを取るためにタスクをデフォルトで有効と原因とされるパラメータ `Single RPM per directory`。

「完全な再構築(`Full Rebuild`)」パラメータは、メタデータ作成のために考慮する必要があるRPMファイルを見つけるために、リポジトリ内のすべてのディレクトリを横断するリポジトリマネージャを強制的に活性化することができます。

このオプションはデフォルトで無効になっており、更新のための基礎として、既存のメタデータ・キャッシュを取るために、リポジトリマネージャを引き起こします。

---

19.4. Example Usages


---

## 19.5. Staging with RPMs

ネクサスリポジトリプロでのみ利用可能。

ネクサスリポジトリマネージャのプロの`Staging Suite`は、あなたのRPMパッケージのリリースプロセスを最適化することを可能にするのyumリポジトリとして利用可能です。


この機能は `Yum: Staging Generate Metadata`に `Staging Profile` のためにyumを設定することができます。

ステージングプロファイルを介した展開から作成されたすべてのステージングリポジトリは自動的にyumのリポジトリとして構成されています。

前述の「Yum: Generate Metadata」は、「Aliases」の設定は機能と同じメカニズムを可能にします。

機能 `Yum: Staging Merge Metadata` 構築推進プロファイルと添付リポジトリのグループのためにyumのメタデータの作成を構成するために使用することができます。

ステージングリポジトリやプロモーションのリポジトリを構築するが、yumのメタデータ生成用に設定され、yumのメタデータのマージのために設定されているリポジトリ基を介して露出されている場合は、ステージングからのメタデータが適切にマージされます。
