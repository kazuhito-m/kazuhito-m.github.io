---
published: false
layout: post
title: gitのリモートリポジトリを全殺しする方法
category: tech
tags: [git,bash,tips,howto]
---


# Gitのリモートブランチを全チェックアウト＆全殺し

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
