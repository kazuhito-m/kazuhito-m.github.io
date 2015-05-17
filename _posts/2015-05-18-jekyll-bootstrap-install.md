---
layout: post
title: Jekyll-BootstrapをGithubPagesに上げる準備こもごも
category: tech
tags: [github-pages, jekyll-bootstrap]
---

ちょっと試行錯誤があったので、メモがてら。


## インストール関連

以下を参考にさせていただきました。

+ [http://mattn.github.io/2012/03/22/installed-jekyll-bootstrap/](http://mattn.github.io/2012/03/22/installed-jekyll-bootstrap/)
+ [http://krakenbeal.blogspot.jp/2012/05/ruby-jekyll-jekyll-bootstrap.html](http://krakenbeal.blogspot.jp/2012/05/ruby-jekyll-jekyll-bootstrap.html)


手順上は「本家jekyll-bootstrapの開発githubからcloneしてそのまま自分のリポジトリにpushする」となっているので、そのままやると「本家の開発履歴やREADMEやChangeLog」も取り込まれてしまいます。

そこで、最初の"git commit/push"する前に「不要ファイルの削除」を行なっています。

以下、やったコマンド履歴。

```
git clone https://github.com/plusjade/jekyll-bootstrap.git
cd jekyll-bootstrap/
rm -rf .git
rm History.markdown 
rm changelog.md 
rm -rf _posts/core-samples/
echo > README.md # 取り敢えずクリア、後で書く
vi _config.yml # プロフィールを適当に
vi index.md  # 本家デフォルト解説文を自分用に変更
rake theme:install git="git://github.com/sodabrew/theme-dinky.git" # テーマ導入
git remote add origin https://github.com/kazuhito-m/kazuhito-m.github.io.git
git push -u origin master

```

この後の作業は「すべてgit上に乗る」ので、履歴から参照のこと。

## テーマ関連

正しく理解しているか自信がないですが…「jekyllとjekyll-bootstrapで"theme"と呼んでいるモノが違う」気がします。

+ [http://themes.jekyllbootstrap.com/](http://themes.jekyllbootstrap.com/)

ここに「プレビュー出来る一覧」があり、ページ下の"Theme Explorer"からテーマを選び、"Install Theme"をクリックすると「rakeの構文出してくれる」ので、それのコピペを叩けばテーマが適用されます。

## jekyllの基本的な使い方

+ 基本的なページの作り方

    [http://qiita.com/makoto_kw/items/38c0300cbbaf8d2f2370](http://qiita.com/makoto_kw/items/38c0300cbbaf8d2f2370)
    [http://dotinstall.com/lessons/basic_jekyll/27406](http://dotinstall.com/lessons/basic_jekyll/27406)
    
    まーーたく、材料無い状態だと「ドットインストール」はさわりを知るのに楽ですね。

+ カテゴリ周りの扱いと自分で一覧作る時の勘所

    [http://www.mumpk.com/jekyll/2013/08/27/jekyll-category-howto/](http://www.mumpk.com/jekyll/2013/08/27/jekyll-category-howto/)

## jekyllの環境周り

+ jekyll自体のインストール

    最初からGithubPages狙いなので、あまりローカルでjekyll動かす必要はありません。
   
    でも「テンプレ込で絵面を見たい」時のために、何処かにはインストールしておくと楽です。
   
    [http://akkunchoi.github.io/jekyll-github-blogging.html](http://akkunchoi.github.io/jekyll-github-blogging.html)
   
    ココを参考にしました。基本「rubyとgem入れた環境」があれば、
   
    `gem install jekyll`
   
    だけで完了…のはずです。
   

+ jekyll serverを自マシンで無く他のマシンで動かす時

    普通に"jekyll serve"してしまうと「localhostからしか応答しない」となってしまいます。

    [http://d.hatena.ne.jp/kk_Ataka/20150314/1426326141](http://d.hatena.ne.jp/kk_Ataka/20150314/1426326141)

    状況証拠としては

    `jekyll server --host=0.0.0.0 --watch`

    で「他マシンから見えた」を確認しました。
    
## 番外

直接、jekyllと関係ないのですが、微妙に調べ物があったので。

+ dockerで後からポートを公開する

    [http://qiita.com/arimakouyou/items/506416a679f0f94ff9f1](http://qiita.com/arimakouyou/items/506416a679f0f94ff9f1)
    
    既存のマシンを汚したく無かったので「以前作ったUbuntuのDockerイメージ」を使ってjekyllインストール、サーバ起動させたのですが…上記のlocalhost問題も相まってしんどかった。
    
+ aptで入れたrubyが「ruby.h無いよ」って怒る

    [http://qiita.com/marumaru8228/items/24302bc9812c820bda91](http://qiita.com/marumaru8228/items/24302bc9812c820bda91)
    
    この記事自体は「knife-soloのインストールで…」というものなのですが、事象が同じだったので。
    
---

以上、自分のための備忘録でした。