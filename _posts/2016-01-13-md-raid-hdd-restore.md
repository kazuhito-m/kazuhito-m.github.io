---
published : false
layout: post
title: LinuxのソフトウェアRAID"md"で既存の構成(RAID0)に容量アップ方向でHDDを交換する
category: tech
tags: [linux,raid ,software_raid,md]
---

久しぶりのHowtoモノですが…自身の構成にしか適用できないのでメモです。

# 前提

+ 対象となる筐体はARMのNAS（[KURO-NAS/X4](http://archive.kuroutoshikou.com/modules/display/?iid=1264)）
+ 入っているOS(Linuxディストリビューション)は”Debian GNU/Linux 6.0（squeeze）”
+ Linux Software RAID(通称"md"かな？)でRAID１（ミラーリング）を組んでいる
+ そのRIAD1の論理ディスク(/dev/md0)を/homeにマウントしてある

# やりたいこと

+ mdで組んだRAID1を新しく大きなHDDに交換したい
  + 現在1TBのディスクが生きているが双方を3TBのディスク2つ換装したい
+ 「RAID作りなおしてコピー」とかじゃなくて「交換を装ってひとつずつ換えつつ拡張」したい
  + 一つを離脱 → 新しいのに交換 → もう一つも離脱 → 新しいのに交換 という流れでいきたい

# やったこと

## 現状の構成の確認

## 片方のディスクを交換

## 構成として認識

## もうひとつのディスクも交換

## 容量アップ
