---
layout: post
title: AWSのUbuntuにVNC経由のデスクトップ環境を最速で立てる方法
category: tech
tags: [linux,aws,setup,howto,ubuntu,desktop,vnc]
---

以前、[Docker内のCentOSでVNCデスクトップ](https://github.com/kazuhito-m/dockers/blob/master/desktop_and_browser_vnc/Dockerfile) はやってたのですが、今度はそれの「AWS✕Ubuntu版」をやってみたので、記録しておきます。

最早を目指したので「こまけーことはいいんだよ！」仕様になっておりますが、それでも良いならご参考に。

# 前提

+ AWS上はUbuntu14.04
+ ポートは〜〜でTCP:5901を開放している事

# オペレーション

# Unityはむつかしそう(俺調べ、確定じゃないです)

本来は、上記の作業で「Unity入りのデスクトップが立ち上がる」はずなのですが…。

スクリーンショットを見て頂ければ解るのですが、「GNOMEデスクトップ」です。

「マシンがUnityに対応しているか？」の[日本チーム公式のチェック方法](https://wiki.ubuntulinux.jp/UbuntuTips/Desktop/HowToUseUnity)を試しても、

```bash
/usr/lib/nux/unity_support_test -p

Error: unable to open display
```

と表示されてしまいます。

どうも[世界の人の例(何例か)](https://www.youtube.com/watch?v=ljvgwmJCUjw)を見ていると「ここまでで完成にしてる」ことが多いので「完全再現は難しい」のかもしれないなーという結論で終わらせています。

---

「デスクトップ環境が動けば」という簡易手段や、GUIでのテストもあるので、アイディア次第では使えるのではと思います。



# 参考

以下を参考にさせていただきました。ありがとうございます。

+ https://wiki.ubuntulinux.jp/UbuntuTips/Desktop/HowToUseUnity

