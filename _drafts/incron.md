---
published: false
layout: post
title: Ubuntuでファイル変更を検知して「何か」実行して通知する方法
category: tech
tags: [ubuntu,incron,notify-send,bash,tips,howto]
---

いつも「そんなもん、手段くらいあるやろ…」と思っては、うまいこといかなくて諦めてたこのテーマ。

今回「一通り答えにたどり着いた」ので、メモを残すことにしました。

# 主旨

以前から「ローカル端末で変更を検知して、テストしたりビルドしたりしたい！」と思うことが多いのです。

理由は言わずとしれて「フィードバックの最短を受け取るため」。

というと「〜言語なら常識！」みたいなの(RubyのGuardやgolangのLooper)飛んできたりするのですが、
「エコシステムやオプションに組み込まれている言語」は良いとしても
「JSとか無いどうすんの？」とか「複合のやつどうすんの？」とか例外系は出てくるだろうなーと。

そこで「自身端末に仕込む汎用的な方法」を模索しました。

# 前提

+ linux & bash
+ git導入 & コマンドからアカウント入力不要に設定済み
+ もうカレントディレクトリが「対象のリポジトリをcloneしたところ」に居ること


# オペレーション

※破壊的「一回きり操作」なので、真似してミスっても [kazuhito_m](https://twitter.com/kazuhito_m)に訴えない事。

```bash
# master以外のリモートブランチをすべてローカルに落とす。
for i in $( git branch -a | grep remotes | grep -v master ) ; do git checkout -b ${i#*origin/} ${i#remotes/} ;done

# masterに戻り
git checkout master

# ローカルブランチをことごとく殺す。
# (master以外のすべてのローカルブランチを殺すので、
# 作業が途中のものが在る場合は、実行しない or Grepを工夫すること)
git branch | grep -v master | xargs git branch -d

# リモートブランチ名を削って、ローカル「ブランチ消した」という操作をpush。
for i in $( git branch -a | grep remotes | grep -v master ) ; do git branch -d :${i#*origin/} ; done
```

---

ずっと探してた「やりたいことが簡単に出来る道具」を手に入れて満足です。

また、例えば…

+ 作った途端に「補正が必要」なものの自動補正(HTMLとか)
+ 何か「加工品の一次ソース」になるものの自動変換(SphinxのReSTとかMarkdownからHTMLとか)
+ 静的HTML生成

など、自身の一過性の作業(とはいえ2日くらいとかね)に凄い使えそうだなーと夢がひろがりんぐです♪

#参考

以下を参考にさせていただきました。ありがとうございます。

+ [http://qiita.com/futoase/items/259c9e3a1e75e4cb0fbe](http://qiita.com/futoase/items/259c9e3a1e75e4cb0fbek)
+ [http://qiita.com/okitan/items/25238a9b836c14d52cbd](http://qiita.com/okitan/items/25238a9b836c14d52cbd)
