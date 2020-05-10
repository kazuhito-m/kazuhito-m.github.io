docker pullが出来なかったので、野良proxy建ててしのいだ話
===

## 現象

Amazon Linux2 でながらく運営しているサーバが、いつからかわからないが、docker-hubから、イメージが落とせなくなった。

```bash
# docker pull hello-world
Using default tag: latest
latest: Pulling from library/hello-world
1b930d010525: Pulling fs layer
error pulling image configuration: Get https://production.cloudflare.docker.com/registry-v2/docker/registry/v2/blobs/sha256/fc/fce289e99eb9bca977dae136fbe2a82b6b7d4c372474c9235adc1741675f587e/data?verify=1580919344-Qn4ZPcExVVyx5TRGH5QoTIUp9eM%3D: dial tcp 104.18.122.25:443: i/o timeout
```

DNSを疑ったの、resolve.conf に 8.8.8.8 設定してみたりしたが、そもそも上の時点でIPに直せているので、それではないようだ。


```bash
# host production.cloudflare.docker.com
production.cloudflare.docker.com has address 104.18.122.25
production.cloudflare.docker.com has address 104.18.121.25
production.cloudflare.docker.com has address 104.18.125.25
production.cloudflare.docker.com has address 104.18.123.25
production.cloudflare.docker.com has address 104.18.124.25
```

そのURL自体をcurlで取得しようとすると、以下が繰り返される。

```bash
# curl -v https://production.cloudflare.docker.com/registry-v2/docker/registry/v2/blobs/sha256/fc/fce289e99eb9bca977dae136fbe2a82b6b7d4c372474c9235adc1741675f587e/data?verify=1580919344-Qn4ZPcExVVyx5TRGH5QoTIUp9eM%3D
*   Trying 104.18.121.25...
* TCP_NODELAY set
* connect to 104.18.121.25 port 443 failed: Connection timed out
*   Trying 104.18.124.25...
* TCP_NODELAY set

...こんな調子で繰り返し…
```

ちなみに、他のマシンだと

```bash
curl https://production.cloudflare.docker.com/registry-v2/docker/registry/v2/blobs/sha256/fc/fce289e99eb9bca977dae136fbe2a82b6b7d4c372474c9235adc1741675f587e/data?verify=1580922607-M1BK2XEgEZa0LZ12osQuaJ4mGws%3D

{"architecture":"amd64","config":{"Hostname":"","Domainname":"","User":"","AttachStdin":false,"AttachStdout":false,"AttachStderr":false,"Tty":false,"OpenStdin":false,"StdinOnce":false,"Env":["PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"],"Cmd":["/hello"],"ArgsEscaped":true,"Image":"sha256:a6d1aaad8ca65655449a26146699fe9d61240071f6992975be7e720f1cd42440","Volumes":null,"WorkingDir":"","Entrypoint":null,"OnBuild":null,"Labels":null},"container":"8e2caa5a514bb6d8b4f2a2553e9067498d261a0fd83a96aeaaf303943dff6ff9","container_config":{"Hostname":"8e2caa5a514b","Domainname":"","User":"","AttachStdin":false,"AttachStdout":false,"AttachStderr":false,"Tty":false,"OpenStdin":false,"StdinOnce":false,"Env":["PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"],"Cmd":["/bin/sh","-c","#(nop) ","CMD [\"/hello\"]"],"ArgsEscaped":true,"Image":"sha256:a6d1aaad8ca65655449a26146699fe9d61240071f6992975be7e720f1cd42440","Volumes":null,"WorkingDir":"","Entrypoint":null,"OnBuild":null,"Labels":{}},"created":"2019-01-01T01:29:27.650294696Z","docker_version":"18.06.1-ce","history":[{"created":"2019-01-01T01:29:27.416803627Z","created_by":"/bin/sh -c #(nop) COPY file:f77490f70ce51da25bd21bfc30cb5e1a24b2b65eb37d4af0c327ddc24f0986a6 in / "},{"created":"2019-01-01T01:29:27.650294696Z","created_by":"/bin/sh -c #(nop)  CMD [\"/hello\"]","empty_layer":true}],"os":"linux","rootfs":{"type":"layers","diff_ids":["sha256:af0b15c8625bb1938f1d7b17081031f649fd14e6b233688eea3c5483994a66a3"]}}
```

というJsonを返します。

このサイト以外(https://example.com/ や http://abehiroshi.la.coocan.jp/ など)は、正しく取得できます。

## やったこと

DockerのCDNが「cloudflareだったこと」もあって、なんとなーく「ブロックされてる？」って疑ったので、「公開してある野良サーバをProxyにしてアクセス」してみることにしました。

docker/docker-composeを使い、Squidを建てます。

https://thr3a.hatenablog.com/entry/20190321/1553132311

を、参考に建てました。

```bash
git clone https://github.com/thr3a/squid-docker-compose.git
cd sq*
docker-compose up
```

このままなら「すべての通信を許さない」ので、設定するために止めて下準備をします。

```bash
vi Dockerfile

# 以下の行あたりに二行足す
16 RUN ln -s /usr/share/squid/errors/en /usr/share/squid/errors/ja-jp
17 RUN chmod -R 777 /etc/
```

再度、compose up した後、編集します。

```bash
docker exec -it squid-docker-compose_squid_1 /bin/sh
## ここ以下はコンテナ内
vi /etc/squid/conf.d/default.conf
# 30行あたりに三行足す
acl targethost src [ターゲットサーバのIP]
http_access allow localhost manager targethost
http_access allow targethost

:wq
exit
```
コンテナからでたら、コンテナ指定で再起動します。

```bash
docker restart squid-docker-compose_squid_1
```

これで、ターゲットだけの通信を許すサーバが出来ました。

ターゲットのサーバ(docker pull出来ないサーバ)から、通信テストをしてみます。

```bash
curl https://production.cloudflare.docker.com/registry-v2/docker/registry/v2/blobs/sha256/fc/fce289e99eb9bca977dae136fbe2a82b6b7d4c372474c9235adc1741675f587e/data?verify=1580922607-M1BK2XEgEZa0LZ12osQuaJ4mGws%3D --proxy http://proxyサーバ:3128

{"architecture":"amd64","config":{"Hostname":"","Domainname":"","User":"","AttachStdin":false,"AttachStdout":false,"AttachStderr":false,"Tty":false,"OpenStdin":false,"StdinOnce":false,"Env":["PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"],"Cmd":["/hello"],"ArgsEscaped":true,"Image":"sha256:a6d1aaad8ca65655449a26146699fe9d61240071f6992975be7e720f1cd42440","Volumes":null,"WorkingDir":"","Entrypoint":null,"OnBuild":null,"Labels":null},"container":"8e2caa5a514bb6d8b4f2a2553e9067498d261a0fd83a96aeaaf303943dff6ff9","container_config":{"Hostname":"8e2caa5a514b","Domainname":"","User":"","AttachStdin":false,"AttachStdout":false,"AttachStderr":false,"Tty":false,"OpenStdin":false,"StdinOnce":false,"Env":["PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"],"Cmd":["/bin/sh","-c","#(nop) ","CMD [\"/hello\"]"],"ArgsEscaped":true,"Image":"sha256:a6d1aaad8ca65655449a26146699fe9d61240071f6992975be7e720f1cd42440","Volumes":null,"WorkingDir":"","Entrypoint":null,"OnBuild":null,"Labels":{}},"created":"2019-01-01T01:29:27.650294696Z","docker_version":"18.06.1-ce","history":[{"created":"2019-01-01T01:29:27.416803627Z","created_by":"/bin/sh -c #(nop) COPY file:f77490f70ce51da25bd21bfc30cb5e1a24b2b65eb37d4af0c327ddc24f0986a6 in / "},{"created":"2019-01-01T01:29:27.650294696Z","created_by":"/bin/sh -c #(nop)  CMD [\"/hello\"]","empty_layer":true}],"os":"linux","rootfs":{"type":"layers","diff_ids":["sha256:af0b15c8625bb1938f1d7b17081031f649fd14e6b233688eea3c5483994a66a3"]}}
```

よし！Proxy経由ならDockerのサイトにアクセスできそうです。

---



で、DockerにProxyを仕込みます。以下を参考にしました。


https://qiita.com/Riliumph/items/921e76444ea6ba145294

自身の環境(Amazon Linux2)では、Systemdではあるのですが、 `/usr/lib/systemd/system/docker.service` に、以下のように書いてありました。

```bash
 9 [Service]
10 Type=notify
11 EnvironmentFile=-/etc/sysconfig/docker
...
```

ということから、 `/etc/sysconfig/docker` に、以下を追加してみます。

```bash
vi

# 末尾あたりに以下を追加。

# DockerHubに繋げない対策。
HTTP_PROXY='http://proxyサーバ:3128/'
HTTPS_PROXY='http://proxyサーバ:3128/'
# 保存後、Servcie再起動。
systemctl daemon-reload
systemctl restart docker.service
docker info

...
Debug Mode (server): false
HTTP Proxy: http://proxyサーバ:3128/
HTTPS Proxy: http://proxyサーバ:3128/
Registry: https://index.docker.io/v1/
...
```

docker info で「指定した変数」が表示できればOKです。

ここで、docker pullで「イメージがオチてくるか」を確認します。

```bash
docker pull hello-world

Using default tag: latest
latest: Pulling from library/hello-world
1b930d010525: Pull complete
Digest: sha256:9572f7cdcee8591948c2963463447a53466950b3fc15a247fcad1917ca215a2f
Status: Downloaded newer image for hello-world:latest
```

おお、やった！目論見通りProxy挟んだらpullが成功しました。


## 参考
- https://urashita.com/archives/18784#Squid_HIER_NONE
- https://milestone-of-se.nesuke.com/sv-advanced/server-software/squid-conf-acl/
