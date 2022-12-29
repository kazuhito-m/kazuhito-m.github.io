---
layout: post
title: CloudBeesさん提供のJenkinsを使ってSphinxドキュメントをビルドする方法

category: tech
tags: [cloudBees, jenkins, linux, phython, sphinx]
---

# 経緯

私は今、有志の勉強会の、とある「読書会」に参加しています。
ただ、その「読書の対象」が洋書でして…。

そこで、個々参加メンバーが持ち回りで翻訳することとなっているのですが、

「絶対に一人がどこかを翻訳して来るのだから、その翻訳成果をまとめて完了時には一冊和訳出来ているようにしよう！」

となりました。

しかし、当たり前ながら、それも売り物かつ著作物…公開するわけには行きません。

そこで、「メンバー達だけが編集できて、メンバー達が閲覧できる何か」が必要になってきました。

メンバーのお一方がすでに使用されていたのと、翻訳に使っている実績があるとのことで、ドキュメント形式は「Sphinx(Python製プロダクト)」と決まりました。

SphinxはTexのように「元文書はソースみたいなもので、ビルドにより成果物が出来る」タイプのものです。

なので、以下のものが必要になってきます。

1. メンバー用のコミニュティを無料かつメンバーオンリーかつクラウドで
0. メンバー用のソース管理リポジトリをメンバーオンリーかつクラウドで
0. メンバー用のビルド環境を無料かつメンバーオンリーかつクラウドで
0. メンバー用の成果物閲覧環境を無料かつメンバーオンリーかつクラウドで

そして、今決まっているのは…

1. [Google Group](http://groups.google.com/)
0. [Assenbla](https://www.assembla.com/home/)
0. 未定
0. 未定

なのです。

# やること

さて、前置きが長くなりましたが、今回は上記の3である「ビルド環境」についてです。

まだ誰にも言ってないので未定ですが、Jenkinsを使おうと思います。

「クラウドかつ無料でJenkinsが使えるところ」なんて、そうそうありません。

そこは流石の「生みの親」、川口さんの会社「CloudBees」を使わせていただきます。(ステマ

CloudBeesのデフォルト設定Jenkins(が乗っている思しきLinux鯖)は、かなり最初から盛りだくさんで、JenkinsにはGitPluginなどPluginが必要十分乗ってますし、コンソールから打てる言語もJavaは当たり前ながら、Pythonも標準装備だったりします。

ただ、今回のようにSphinxなどの「インストール要な上モノ」は自由にインストールできません。

Pythonからのインストールコマンド(easy_install sphinx)など打っても「システム域はファイル上書けないぜ！」としかられます。

なので「workspaceにDLして、ビルドして、インストールしてから、それ使ってドキュメントをビルド」というアプローチを取ります。

## CloudBeesさん提供のJenkinsを使ってSphinxドキュメントをビルドする

1. CloudBeesさんのとこ行って、アカウント作成
0. Jenkins上で「フリースタイル・プロジェクトのビルド」としてジョブを作成
0. ソース管理からSphinxドキュメントを引っ張ってくる設定
0. 「シェルの実行」を追加し、以下のコマンドを記入

```bash
export PYTHONPATH="${WORKSPACE}/lib_install/lib/python"
rm -rf ${WORKSPACE}/lib_* ${WORKSPACE}/build
easy_install --editable --build-directory ${WORKSPACE}/lib_build sphinx
mkdir -p ${WORKSPACE}/lib_install/lib/python/
cd ${WORKSPACE}/lib_build/sphinx/
python setup.py install --home=${WORKSPACE}/lib_install
cd -
rm -rf ${WORKSPACE}/lib_build
alias sphinx-build="${WORKSPACE}/lib_install/bin/sphinx-build"
# make html
sphinx-build -b html -d build/doctrees . build/html
```

解説は上記「workspaceに…」のままです。

最後の行、SphinxについてるMakefile使って"make html"したかったのですが、makeに入ってからはなぜかaliasを受け付けないので、中で使ってる思しきコマンドを直叩きしています。

また、この例では、ドキュメントのディレクトリを、ソース管理中のトップディレクトリと同じにしているため、作業に使ったものもドキュメントとして認識されてしまいます。
同構成でソース管理している場合は conf.py に以下の除外設定を追加しておいてください。

```python
exclude_patterns = ['_build','lib_install','lib_build']
```

---

# 小並感


同じことを考えられている方も多そうなので書いてみました。

読書会は「読み、話し合い、内容の理解を深める」が本質なので、回りの作業はカリッカリに自動化＝手がかからないようにしておきたいですね。

※続き - 「JenkinsでビルドしたSphinxのHTMLをGoogleAppEngineで公開する」
