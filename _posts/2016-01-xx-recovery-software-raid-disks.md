---
published: false
layout: post
title: Linux Software RAID(md)のRAID1ディスクを一撃で認識不能にした話
category: tech
tags: [linux,debian,servcie,iss]
---

# 現状確認

以下の状態になり…顔面蒼白である

+ mdのディスクの健康状態から、一本ディスク抜く
+ 新しい新品のディスクを交換すべく筐体あけて取り替え
  + その際一つ前のディスク(/dev/sdc,dがRAID1で、/dev/sdbのディスク)は破損状態だったので物理的に撤去
+ ドライブレイターずれているにもかかわらずRAID1のあーだこーだして再起動
+ あれ、RAIDアレイ消えてるぞ？
+ 元のディスク両方からRAID情報が消失臭い(判定をされている)

# やったこと
