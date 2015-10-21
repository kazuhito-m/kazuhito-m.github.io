---
published: false
layout: post
title: LinuxデスクトップでディレクトリをCLIから英語名にする方法
category: tech
tags: [linux,ubuntu,desktop,howto,tips]
---

Linuxには「デスクトップ運用する場合のユーザのホームディレクトリに最初からあるディレクトリと意味」が決まっています。

(freedesktop.org で提唱されている概念っぽい。[サイト](http://freedesktop.org/wiki/Software/xdg-user-dirs/)では「"well known" user directories」と解説している。ツール等では「xdg-user-dirs」と表現されていることが多い。)


それは「概念的なディレクトリ」であり、初回ディレクトリ時に「言語ロケールごとに実ディレクトリ名がローカライズされ」ます。

![こんな感じのです](/images/2015-10-21-well-known-dirs.png)

これは「意味のある特別扱い」のディレクトリで、アイコンも代わり、例えばファイル選択ダイアログに意味に追うじて最初から入っているなど、扱いが違います。

ですので、おいそれとリネーム/移動などは出来ず「設定と一緒に変更する」必要があります。

メカニズム的には、`~/.config/user-dirs.locale` ファイルに、「概念的なディレクトリと実ディレクトリ名のマッピング」が管理されている感じです。

そんなスペシャルなディレクトリですが、日本語環境だと「コンソールから移動するのに入力が面倒」という理由から「ロケールを英語圏にしてアルファベットに変えてしまう」という知見が、
[世では多く在り](https://www.google.co.jp/search?sourceid=chrome-psyapi2&ion=1&espv=2&ie=UTF-8&q=ubuntu%20%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%20%E8%8B%B1%E8%AA%9E%E5%8C%96&oq=Ubuntu%20%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%20%E8%8B%B1%E8%AA%9E&aqs=chrome.1.69i57j0l5.12343j0j7)ます。
## 一般的な変更方法。

コンソールから、

```bash
LC_ALL=C xdg-user-dirs-gtk-update
```

とやると、ダイアログが表示されるので…

![xdg-user-dirs-gtk-updateリネーム確認ダイアログ](/images/2015-10-21-xdg-user-dirs-gtk-update.png)


「Update Names」をクリック。するとディレクトリ名がアルファベットにリネームされます。

---

でも、自分は「環境のAsCode」を目指して居るので「出来ればCLIでやりたい]のです…。


# コマンドのみで英語名にする方法

「gtkはGUIのキット」ということで、コマンドから削ると、変更することができました。

```bash
LC_ALL=C xdg-user-dirs-update --force 
```

ただ…「GUI版と違ってリネームではなくディレクトリ作成＆設定変更」な機能のようで、結局「日本語名のディレクトリも残ってしまう」状態になります。

![だめだわー](/images/2015-10-21-all-dir.png)

うーん、一つ解決すると一つ上手く行かないものですね。

## いろいろかなぐり捨ててとりあえずの強引な解決

なんとか「冪当を確保しつつ」「オプションを工夫して」「ループしてコピーしてファイルを維持して…」など試行錯誤したのですが、
上手く行かなかったので…。

0. 冪当を捨てる(環境構築時一回だけ走らせる想定)
0. ホームディレクトリのトップには日本語ディレクトリを置かない運用

と決め打ちで、

```bash
# 設定変更 ＆ 英名への変更
LC_ALL=C xdg-user-dirs-update --force
# ホームディレクトリにある「名前に２バイト文字を含む」全てのディレクトリをデストロイ。
find ~/ -maxdepth 1 -type d  | LANG=C grep  -v '^[[:cntrl:][:print:]]*$' | xargs rm -rf
```

という「短さ重視の２行」で片付けました。

---

すごく「これやったんや、俺の欲してたものは！」というコマンドｎ出会っても、
対話型だったりダイアログ上がってくるのが必須だったりして、
「CLIだけで片付かないもの」が多く在ります。

今回は「たまたまコマンド叩いてみて見つけた」レベルなのですが、
「これに対応する(CLIの）コマンド無いかな？」
という嗅覚と視点で、コマンドを探して行きたいなと思います。

# 参考

以下を参考にさせていただきました。ありがとうございます。

+ [http://freedesktop.org/wiki/Software/xdg-user-dirs/](http://freedesktop.org/wiki/Software/xdg-user-dirs/)
+ [https://ja.wikipedia.org/wiki/Freedesktop.org](https://ja.wikipedia.org/wiki/Freedesktop.org)
+ [http://qiita.com/taiko19xx/items/d1a001bfc25245b91354](http://qiita.com/taiko19xx/items/d1a001bfc25245b91354)
+ [http://oshiete.goo.ne.jp/qa/5382554.html](http://oshiete.goo.ne.jp/qa/5382554.html)
