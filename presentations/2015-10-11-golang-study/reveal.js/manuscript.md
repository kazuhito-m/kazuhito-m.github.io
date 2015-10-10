# 周回遅れのgolang

2015/10/11 第01回関西golang勉強会LT

----

# お前だれやねん？

---

## 自己紹介

<style type="text/css">
div.picleft {
   float: left;
}
</style>
<div class="picleft">
![筆者近影](images/oukan.png)
</div>

### 三浦 一仁 (みうら かずひと)

+ 通称 : みうみう、「なんで来たん？」氏
+ Twitter : [@kazuhito_m](https://twitter.com/kazuhito_m)
+ github : [kazuhito-m](https://github.com/kazuhito-m)
+ 老害度 : 37歳、独身、意識低い系
+ 職業 : プログラマ(SIer、ビジネスアプリ属)
+ 好きなもの : 自動化、「継続的なんちゃら」
  + CI/CDとか大好物
  + 「楽する」ためには「苦労は厭わない」

---

## golangは？

## -> 好きです。今からはじめます。

---

# golangは今からはじめます。

※ここ重要。

----

# なんで来たん？

---

## golangは…

+ 「小さい」「スループットを求めるモノ」を作りやすい
+ 簡易さと奥深さが絶妙(素人意見)
+ いくつかの「宗教戦争」を言語仕様で潰してある

と「新しく「使う言語」を目標設定しよう」
と思っていた俺にとても良い感じにうつりました。

---

## なので…

![瞬間勉強会化](images/study_meeting_trans.png)

---
## つぶやいたら…

# 瞬間勉強会化！

---

意気揚々と「第０回(企画会議)」に出かける三浦…

だが、この時には知らなかったのです。

## 自分の迂闊さ

というものを…。

---

## ※ここからは三浦の<br/>「当時の心象風景」<br/>をお楽しみ下さい

---

![茶番01](images/golang_cora01.jpg)

---

![茶番02](images/golang_cora02.jpg)

---

![茶番03](images/golang_cora03.jpg)

---

![猛ッ者猛者やで！](images/mossamosa.png)

---

## このままではっ！

初心者(主にオレだけ)の心がくだけてしまうッ！

初心者達(主にオレだけ)でもほっこりできるような…

あるいは「新しく興味を持ってくれる人」(主にオレ)の
裾野を広げるような「大丈夫だよ〜怖くないよ〜」な
「ミニチュアのハードル」のような(オレ向けな)セッションをしないと…。

---

## 万が一

背伸びして勉強会に出ていた疲れからか、

不幸にも黒塗りの高級車に追突してしまう。

後輩をかばいすべての責任を負った三浦に対し、

車の主、暴力団員谷岡に言い渡された示談の条件とは…。

## …なことになりかねない！

(主にオレが)

---

## (こんだけハードル下げといたらなんとかなるやろ…)

----

# このLTの向かうところ

---

## 目標

### とある「落ちこぼれ技術者」がgoで「曲がりなりも一つプログラムを作るまで」

---

## 持って帰ってもらうもの

+ 「すでにgolangを使ってる」方or猛者の皆様
  + もう二度と味わえない「始めたての頃」の気持ち
  + 初学者へのアプローチ
  + 「これから始める方」へのおすすめ材料
+ 初学者orこれから始める方(orオレ)
  + だれでも出来る「はじめるまで」Howto
  + 「こんなヤツでも出来る(?)んや！」という自信

---

## 前提(縛り)

+ 使う道具は「誰でも手に入る」モノ
  + タダ
    + OSSとか言うと「崇高な思想」勢から怒られそう…
    + なので下衆く
  + netから手に入る
+ OSはLinux、ディストリはUbuntu
  + しゃーないやろ！これしか持ってへんねんし…
  + 詳しくは「Ubuntu 15.04」

---

# 題して

---

# 周回遅れのgolang
---


# あらため！

---

# 実録！カタチから入るgolang

2015/10/11 第01回関西golang勉強会LT

----

# 実践

---

## goilangインストール

### Ubuntuの場合は主な手段は３つ

0. Ubuntu公式リポジトリからインストール
0. Ubuntu向けGO側リポジトリを追加してインストール
0. gvmインストールしてgo自体を取得＆自前ビルド

今回は「比較的簡単で比較的新しい」2.で入れた

---

## goilangインストール

```bash
sudo add-apt-repository ppa:evarlast/golang1.5
sudo apt-get update
sudo apt-get install golang
```
### 楽勝！

+ 2015/10現在
+ Ubuntu公式のパッケージは古くておすすめできません
  + なので外リポジトリから取ってます
+ 最新で行くなら当然ながらgvmになります
  + groovyの環境マネージャと名前被ってるねんけど…

---

## GOPATH設定

$GOPATHのには２つの役割が在ります。

0. ビルド時のインポートパス(":"で複数指定可)
0. "go get"での外部パッケージDL先(複数指定のひとつ目)

とりあえず
「go関係はLibも自ソースもHomeディレクトリの /go に入れる」
と決めて…。

```bash
mkdir ~/go
echo 'export CUR_GO_PROJ=go-first-project' >> ~/.bashrc
echo 'export GOPATH=~/go/third:~/go/${CUR_GO_PROJ}' >> ~/.bashrc
echo 'export PATH=${PATH}:~/go/third/bin:~/go/${CUR_GO_PROJ}/bin' >> ~/.bashrc
```

で片付けました。

※$CUR_GO_PROJ は「プロジェクト始めるごとに切替」前提

---

## IDEインストール

IDEは
「InteliJ IDEA Community Edition」+「go-lang-idea-plugin」
で行こうと思います。

```bash
# リポジトリ追加
sudo add-apt-repository
ppa:ubuntu-desktop/ubuntu-make
sudo apt-get update
sudo apt-get upgrade
# Ubuntu make インストール
sudo apt-get install ubuntu-make
# InteliJ自体のインストール
umake ide idea
Choose installation path: /home/[おまえさん]/tools/ide/idea
```

「Ubutntu make」という「公式と別のパッケージ管理」経由です。
時間はかかりましたが、トラブル無く完了。

---

## IDE設定

IDEAに「go-lang-idea-plugin」を入れていきます…。

が、GUIなので手順だけ。(詳しくは[こちらのサイト](http://stormcat.hatenablog.com/entry/2015/04/13/)へ)

0. Preference -> Plugins -> Browse Repositories から「Manage repositories」ボタン押す
0. 開いた「Custom Plugin Repositories」で"https://plugins.jetbrains.com/plugins/alpha/list"を追加する
0. Browse Repositoriesに戻り、足したリポジトリでフィルタ
0. "Go"というプラグインが表示されるので「Install Plutin」
0. 再起動後、Project Structure -> Platform Settings -> SDKs で
「Add New SDK」押す
0. golangの場所を指定

---

## (俗に言う)プロジェクト作成




---

## テスト準備

TODO

---

## CI準備

TODO

---

## CI通知系準備

TODO

---

## チュートリアルこなす

TODO

---

## 実際にモノ作る

TODO

----

# まとめ

---

## 感想(小並)

+ わりかし簡単に始められる
  + モダーンな開発にもサッとたどり着く
+ 「金を積む」「特殊状況下」などでなくても出来る
  + 「開発対象の環境」と「MacOS/linux以外」の組み合わせによっては解らないけれど…
+ おっさんでもなんとかなる！

---

## 。o O (本当の戦いはこれからだけど…)

---

# 要は…

## 達人も初学者もこれからの人も一緒にやってこうぜい！


----

# 以上

ご清聴、ありがとうございました。

質問あらば、どうぞどうぞ！
