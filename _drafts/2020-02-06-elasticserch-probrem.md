

こんな感じで定義してるdocker-compose.ymlがありました。

```yaml
version: '3'

services:
  sonarqube:
    image: sonarqube
    container_name: automation_sonarqube
    ports:
      - 9000:9000
      - 9200:9200
    volumes:
      - /var/local/sonarqube/plugins:/opt/sonarqube/extensions/plugins
    restart: unless-stopped
```

機嫌よく動いていたのですが、いつからかのコンテナ作り直しから、以下のエラーが出て動かなくなりました。

```log
automation_sonarqube | [1]: max file descriptors [4096] for elasticsearch process is too low, increase to at least [65535]
automation_sonarqube | [2]: max virtual memory areas vm.max_map_count [65530] is too low, increase to at least [262144]
automation_sonarqube | 2020.02.05 17:21:37 WARN  app[][o.s.a.p.AbstractManagedProcess] Process exited with exit value [es]: 78
automation_sonarqube | 2020.02.05 17:21:37 INFO  app[][o.s.a.SchedulerImpl] Process[es] is stopped
```

要約すると「Sonarqubeのコンテナに内包するElasicSearchの起動でエラーが出ている」といっていて、

1. VM設定である `vm.max_map_count` が小さい
2. ファイルディスクリプタの最大数が小さい

という問題のようです。

##  VM設定である `vm.max_map_count` が小さい の対処

https://software.fujitsu.com/jp/manual/manualfiles/m170012/j2x18086/01z201/dash/dash-t-tune-sys-prm.html

こちらのものを参考にすると「/etc/sysctl.conf を修正して再起動」となるようですが…。

AmazonLinux2であるサーバをかくにんすると、

```bash
cat /etc/sysctl.conf

# sysctl settings are defined through files in
# /usr/lib/sysctl.d/, /run/sysctl.d/, and /etc/sysctl.d/.
#
# Vendors settings live in /usr/lib/sysctl.d/.
# To override a whole file, create a new file with the same in
# /etc/sysctl.d/ and put new settings there. To override
# only specific settings, add a file with a lexically later
# name in /etc/sysctl.d/ and put new settings there.
#
# For more information, see sysctl.conf(5) and sysctl.d(5).
```

なんとなく、 「 `/etc/sysctl.d` に置いたファイルを読むよ」って言う感じがします。

実際調べると、

```bash
ls -l /etc/sysctl.d/


total 12
-r--r--r-- 1 root root 507 May 18  2019 00-defaults.conf
-rw-r--r-- 1 root root 279 Mar  9  2019 99-amazon.conf
lrwxrwxrwx 1 root root  14 Feb  5 20:56 99-sysctl.conf -> ../sysctl.conf
```

なるほど、先約が居ますね。ここに置けば良さそうです。

```bash
echo 'vm.max_map_count = 262144' > /etc/sysctl.d/01-vm.conf
```

リブート後、確認してみます。

```bash
/sbin/sysctl -a 2>/dev/null | grep 'vm.max_map_count'

vm.max_map_count = 262144
```

上手くいったようです。

##  ファイルディスクリプタの最大数が小さい

こちらの問題は「コンテナ内で起こっていること」なのがポイントです。

docker-compose.yml に「ファイルディスクリプタの上限緩和」を記載します。

```yaml
version: '3'
services:
  sonarqube:
    image: sonarqube
    ...
    restart: unless-stopped
    ulimits:  # elasticsearchでの下限チェック対策
    nproc: 65535
    nofile:
      soft: 65535
      hard: 65535
```

nproc はあまり関係なく、ファイルディスクリプタの緩和は、nofileなんですが、「プロセス数制限もElasticSearchのチェックに引っかかる」というのを記事で見たので、一応上げておきます。


中に入って、確かめてみます。

```bash
$ docker exec -it automation_sonarqube /bin/bash
# ここからDockerコンテナ内
ulimit -n
65535
```

上手くいったようです。

## 参考

- https://qiita.com/ryuji_i3/items/9fdce7d770911442bb8d
- https://software.fujitsu.com/jp/manual/manualfiles/m170012/j2x18086/01z201/dash/dash-t-tune-sys-prm.html
- https://swfz.hatenablog.com/entry/2017/03/02/033957
- http://docs.docker.jp/compose/compose-file.html
- https://www.sambaiz.net/article/41/
