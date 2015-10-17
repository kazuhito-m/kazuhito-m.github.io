---
layout: post
title: gitのリモートリポジトリを全殺しする方法
category: tech
tags: [git,bash,tips,howto]
---

やろうと思うと「感嘆な方法が思いつかない…」となって…でも「滅多に使わない」ので、
ブログにて、メモを残します。


# 前提

+ linux & bash
+ git導入 & コマンドからアカウント入力不要に設定済み


# オペレーション

※破壊的「一回きり操作」なので、真似してミスっても [kazuhito_m](https://twitter.com/kazuhito_m)に訴えない事。

```bash
# master以外のリモートブランチをすべてローカルに落とす。
for i in $( git branch -a | grep remotes | grep -v master ) ; do git checkout -b ${i#*origin/} ${i#remotes/} ;done

# masterに戻り
git checkout master

# ローカルブランチをことごとく殺す。
# (master以外のすべてのローカルブランチを殺すので作業と途中のものが在る場合は実行しないorGrepを工夫すること)
git branch | grep -v master | xargs git branch -d

# リモートブランチ名を削って、ローカル「ブランチ消した」という操作をpush。
for i in $( git branch -a | grep remotes | grep -v master ) ; do git branch -d :${i#*origin/} ; done
```
---

恐らく、1年に1度使うかどうかなのですが「覚えるには複雑」「調べるにはメンドクサイ」ので、まあ自分用に備忘録です。
