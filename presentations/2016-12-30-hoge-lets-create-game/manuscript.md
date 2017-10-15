# ゲームを作り始めたんだけど全然進まない

2016/12/30 Hoge駆動忘年会 #hogedriven

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
![筆者近影](image/oukan.png)
</div>

### 三浦 一仁 (みうら かずひと)

+ 通称 : みうみう、「なんで来たん？」氏
+ Twitter : [@kazuhito_m](https://twitter.com/kazuhito_m)
+ github : [kazuhito-m](https://github.com/kazuhito-m)
+ 老害度 : 39歳、独身、意識低い系
+ 職業 : プログラマ(SIer、ビジネスアプリ属)
+ 好きなもの : 自動化、「継続的なんちゃら」
  + CI/CDとか大好物
  + 「楽する」ためには「苦労は厭わない」
----

# まえからね…

---

## 「作品アイディアリスト」ってのがあった

[https://trello.com/b/u0XWIjlm/-](https://trello.com/b/u0XWIjlm/-)

---

## そのうちから…

「企画書」も作ってた

[https://app.simplenote.com/publish/MkQcrf](https://app.simplenote.com/publish/MkQcrf)

作成日付を見ると「1034日前」になってる…。


---

## でも三浦さんはサボり魔なので…

企画立てた時点で進まなくなった…。

---

## しかし！

__今年11月から!__

作成を開始した。

---

## どんなもんか


[https://github.com/kazuhito-m/twitter-battler-primitivetimes](https://github.com/kazuhito-m/twitter-battler-primitivetimes)

----

# 一作目(お試し版)の解説

---

## 構造の設計

…は、今書きます。


---

## 使ってる道具

- 言語
  - Scala,es2016(babel,Brouserify)
- 永続化/外部
  - Redis
  - Twitter
- FWなど
  - SpringBoot
    - Spring Data Redis

----

# なんでやりたかったのか？

---

## やりたかった理由

- 「自由の効く自分のプロダクト」が欲しかった
  - 実体験をもとにしか、学びやモチベが続かん感じがしてきた
    - たとえばCIとかは「空想したハリボテサンプル」じゃ「モチベ」も「学び」もない
    - 仕事で知見たまっても、外に出せないから発表できないことばかり
^ 単純に「自分の考えたもの」を作ってみたkった
  - 人生では「人が考えたものを実現する」ばかりだから

---

## やりたかった理由

- 「今勉強したいもの」を全部ぶち込んだ
  - そのせいで「カタチがいびつ」に
    - scalaで(酢豚と戦わず)gradleで(playとかじゃなくて)springbootでDDDでes2016でgulpbrowserifyでそのくせJSのFWは使わず生で…

---

## 勇気をもらったもの

- クッキークリッカーに勇気をもらった
  - [アレ](https://www55.atwiki.jp/cookieclickerjpn/pages/22.html)は２かいくらい作りなおされている
  - ああいう「生産して数字をひたすら上げていく」という一点突破でもエンタメ提供できるんや！


----

# 現状

---

## 困ってることは…

- アイディアにメイクが追いつかない
  - なんか得意なとこにいってまいがち
    - gulpとgradleいじりとCI/CDが大半の時間を「気になる！」をしてる
  - オレて「作るものを考える」のほうがテンション上がる人なんや
- 「全部初物」なので調べベースですべてがすすむ
  - これは今必要なんや…と言い聞かせてる

---

## 困ってることは…

- いろいろ「アカンことをしている」っぽい？
  - そもそも調べてないが
  - ガイドライン的にはいろいろ
    - "Twitter/ツイッター"ってつけてはいけないらしい
    - APIの使用規約、そこから取ったデータ使い方など
  - ま、展開する気はないから罰せられん程度にきにしょっかな

----

# まとめ

---

## こんだけグダグダ魅せつけたなら…

あとは向上してくだけっすねｗ

生暖かく見守ってください。
