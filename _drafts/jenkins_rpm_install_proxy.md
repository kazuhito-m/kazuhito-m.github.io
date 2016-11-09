# RPMで入れたJenkinsにプロキシを仕込む方法

## やりたいこと

Jenkinsでシェルを起動するときに、HTTP/HTTPSにはプロキシサーバが効いてほしい。

Pluginのとこのプロキシでなく、ジョブ実行時の「シェルの実行」の部分。

## 問題

Redhat系(RPM系)のディストリに、本家サイトのRPM or rpm importでkey指定にて、Jenkinsをインストールした場合、設定ファイルは `/etc/sysconfig/jenkins` になります。

しかし、デフォルトのパラメータ群に「全体のProxy指定変数」みたいなのは無いし、`JENKINS_ARGS` も「Jenkinsのパラメータ列挙するところ」なので、javaのオプション(-Dhttp.proxyHost)とか指定しても、起動できなるなるだけしかありません。

そのため、ネットの情報などでは「起動スクリプト(`/etc/init.d/jenkins`)を直接弄れ」となってるものも多いようですが…。

## (比較的良さそうな)やりかた

その起動スクリプトである`/etc/init.d/jenkins` を読むと…

「"." 使って `/etc/sysconfig/jenkins` をスクリプトとして読み込んで続行してる」

ということが解るので、この特性を利用します。


"." 読み込みしてるってことは、フッツーに `.bashrc` 読むのと同じ容量でプロキシ指定をができるということです。

```bash
vi /etc/sysconfig/jenkins

# 末尾に
export HTTP_PROXY=http://proxy.server:port/
export FTP_PROXY=http://proxy.server:port/
```

など書けば、設定ファイルを弄るだけでJenkins全体にプロキシサーバが効きます。

---

ちょっと「中身を知ってるから出来ること」をやっちゃってるので、RPMのバージョンアップや方式変更には追随できない可能性もありますが、自分は当面これで行きたいと思います。
