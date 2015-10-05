---
layout: post
title: 勉強会行ってみた「秋の関ジャバ祭り」#kanjava
category: study-meeting-repo
tags: [java,lang]
---

Javaは「落ちこぼれの俺」の新人時代に「寄してもらえな」かった
「アレやらしてもらえるのはすごい人！」の憧れの言語でしてね…。

# 情報

+ [申し込みサイト](http://kanjava.connpass.com/event/14086/)
+ ハッシュタグ : [#kanjava](https://twitter.com/search?q=%23kanjava)
+ 何するのか : Javaの最新動向や実例、技術情報などをセッション形式で発表する勉強会。今回は「関東で行われたCCC/JavaDayTokyoの再演」

# なんで来たん？

仕事上、一番使う機会の多いJava…ながら自身の知見も狭く、コアになるものもない。

せめて「最新動向や皆さんがどうされているか」の情報収集のため、参加して知識を浴びてこよう、
そういう目論見で参加しています。

あと [@irof](https://twitter.com/irof)さん、[@s_kozake](https://twitter.com/s_kozake)さん、[@jyukutyo](https://twitter.com/jyukutyo)さんといった「世界の〜」が冠につく人の登壇は見たいですし。

## 1コマ目「クリスマスを支える俺たちとJava」

+ 登壇者 : 阪田 浩一 さん( [jyukutyo](https://twitter.com/jyukutyo) )
+ 資料: ※これじゃないかも

<iframe src="//www.slideshare.net/slideshow/embed_code/key/MfZjSJ69snKO1b" width="425" height="355" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="//www.slideshare.net/jyukutyo/jjug-ccc-2015ab4" title="クリスマスを支える俺たちとJava(JJUG CCC 2015 Spring AB4)" target="_blank">クリスマスを支える俺たちとJava(JJUG CCC 2015 Spring AB4)</a> </strong> from <strong><a href="//www.slideshare.net/jyukutyo" target="_blank">jyukutyo</a></strong> </div>

※見れてないので、あとで資料を拾った結果から書きます。

プリントシール機械のバックエンドを、Javaで運用しているじゅくちょーさんの奮闘記です。

---

Swift,GlasterFSなど、分散ファイルシステムには興味が合ったのですが、「MogileFS」は知らなかったので、
特性など色々と知りたくなりました。

---

サーバ台数の話しは、「敵が物量なら、札束で殴れ」という言葉を最近そこかしこで聞くのでタイムリーでした。

逆に言えば「いかにスケーリング可能にしておくか」が昨今の設計での要になるのだなーと。

---

DBチューニングの件は、
自身では他人に「状況を限りなく本番に近づけないと意味ないよ！」と言う原理主義者が俺です。

でも最近「状況が許さないから…」と言った理由で「全然違う環境で計測・チューニングする」
ということが２例くらい周りで続いてたのですが
「それにより気付かれず金が無尽蔵に吸われる可能性が在る」のは明日は我が身と怖くなりました。

---

阪田さんは長く付き合ってこられてもちろん含蓄があるのですが「JVMは人類の英知」というセリフ、
すごく素直に頷けます。(Java以外のJVM言語が台頭してきているのもその証左かなあと)

割と「Javaを取り巻くインフラ周りの話し」が多かったので「Java(JDK)の特性をわかりつつインフラを設計する」
というのが勘所なのかなーと推測しました。

## 2コマ目「あなたとAndroid!? 今すぐダウンロード！～Android開発で変わるSIerのJava技術事情について～」

+ 登壇者 : 小酒 信一さん( [s_kozake](https://twitter.com/s_kozake) )
+ 資料: ※これではないかもしれません。
<iframe src="//www.slideshare.net/slideshow/embed_code/key/MGhGOBdfOJ6vwo" width="425" height="355" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="//www.slideshare.net/s_kozake/android-53545715" title="あなたとAndroid!?今すぐダウンロード" target="_blank">あなたとAndroid!?今すぐダウンロード</a> </strong> from <strong><a href="//www.slideshare.net/s_kozake" target="_blank">Shinichi Kozake</a></strong> </div>

「会場は硬いと思うのですが…僕が一番やらかいと思うのでｗ」

と言うつかみからスタートしたセッション。

ご自身がシスアーキとして参加された「業務系Android大規模案件」の話しをされていました。

---

自身は「Andoid出たてに少し触ったことがある」程度ですが…

全く知らないことが多く、途中から、

_「俺がこのプロジェクトに入った時に戦力になるか？」_

を考えて聞いていました。

「知ってる」と「使える」とは全然レベルが違うので、じゃあ「知ってる」だけでもどうなんだ？と照らして当てはめてみると…

<table>
	<tr>
		<th>カテゴリ</th>
		<th>要素</th>
		<th>知ってるか判定</th>
	</tr>
	<tr>
		<td>言語</td>
		<td>AndroidJava(っぽい言語)</td>
		<td>△</td>
	</tr>
	<tr>
		<td>IDE</td>
		<td>AndroidStudio</td>
		<td>×</td>
	</tr>
	<tr>
		<td>ビルドツール</td>
		<td>Gradle</td>
		<td>△</td>
	</tr>
	<tr>
		<td>ライブラリ</td>
		<td>AndroidAnotations</td>
		<td>×</td>
	</tr>
	<tr>
		<td>ライブラリ</td>
		<td>SQLightOpenHelper</td>
		<td>×</td>
	</tr>
	<tr>
		<td>ORM</td>
		<td>ActiveAndroid</td>
		<td>×</td>
	</tr>
	<tr>
		<td>HTTP</td>
		<td>OKHTTP</td>
		<td>×</td>
	</tr>
</table>

なんと見事な役立たずｗ

---

気になったのは「自動生成がどんなものか」ということでした。

(自動生成といえば「まゆをひそめる方がいる」ってのは俺ですねｗ)

+ 自動生成が出来るということはロジカルである
+ 「自動生成でソース吐く」というのは「手で作るのはしんどいが変更する可能性があるもの」事情から
+ ましてや「自動生成ソースは変更しない」のであれば益々ライブラリやFW側に倒すべき

と言う持論がありまして。

やんごとなき理由があったのでしょうから、それが知りたかったです。

---

AndroidでORMってのは「あるだろうけれど重そう」って思っていたので、
軽さと「固定された端末」というものがどんな感じかが気になりました。

---

「おそらくすごく検討されて、混みいった話しもあり、そうしたのだろうが、俺では頭悪くてわからん」
というハイコンテキストな感じが多かったです。

次お会いするときには、なぜなに坊やになってお話しようと思います。

## 3コマ目「これからのJavaの取っ掛かりを掴む」

+ 登壇者 : irof さん( [irof](https://twitter.com/irof) )
+ 資料 : ※捜索中

irof さんの

+ 「こざけさんが場を冷やしたおかげで…」
+ 「こざけさんのおかげで順番がかわったいろふです。」

の声から始まったセッション。


「Javaの過去、現在、未来」を自身が思われる「(他の多くの)技術者として視点」で考え方のヒントを撒く、
そんな感じのセッションでした。。

---

ダイアモンドオペレーターは、自身は「自動生成されても断固消す！」ってする俺は異端なのかもなと思いました。

---

自分は

+ 文字列の判定のif〜else祭りは大っっっっっっっ嫌い！
+ 条件と処理をもっと近い形で宣言的にかけたら良いのになぁ

という願望を持っていました。

例えば「ある文字列で計算方法が変わる」メソッドがあるとして

```java
public int calcValue(String type , int value) {
    if ("a".equals(type)) {
        return value + 1;
    } else if ("b".equals(type)) {
        return value - 1;
    } else {
        return 0;
    }
}
```

こんな感じですかね。これが大嫌い。

他言語から来た者としてはString Switch個人的には待望だったので

```java
public int calcValue7(String type , int value) {
    if (type == null) {
        return 0;
    }
    switch (type) {
        case "a" :
            return value + 1;
        case "b" :
            return value - 1;
        default:
            return 0;
    }
}
```

は、なかなか満足でした。(要らん判定増えてるやろ！は自分の納得の前では見えない)

しかし「関数を値的に扱えたらペアとして扱えるよな」みたいな感慨になり、

```java
public int calcValue8(String type , int value) {
    final Map<String , IntUnaryOperator> fs = new HashMap<>();
    fs.put("a", v -> v + 1);
    fs.put("b", v -> v - 1);
    IntUnaryOperator f = fs.get(type);
    if (f == null) {
        return 0;
    } else {
        return f.applyAsInt(value);
    }
}
```
と、この書き方が出来るようになったのを満足し、
「好きだった割りにはStringSwitchの寿命は短かった」という結果となりましたｗ

---

+ 「あれのことをラムダって言うのか！」
+ 「あれをMethod Referenceって言うのか」

という「道具使ってるのに解ってない」ダメ人間さを露呈しました。

---

バージョンアップの問題は「ほんと追随していきたい」と思いました。

「距離が短いウチはまだ助かる」というのをいろんな現場で経験しているので。

ただし「自身はその決定を出来る立場に居たことがない」ので、思いは届かないのですが…。

---

自身は「中途半端に旧石器人」ということがわかりました。

それだけに「これからどう掴んでいくか」の「考える起点」を、このセッションに貰ったのは来てよかったと思います。

# 小並感

「解ってないことが解ってなかった、ということが解った」ということが収穫でした。

憧れだったJava…を使って(偉そうに)仕事してるつもりが、全然わかって無いと。

努力が足りない。だけどどうしたら良いのか…。

仕事で「Autoで身につくわけではない」でも「明日出来るようになったりしない」…
小学生並にぐるぐる悩んだ結果、

「ちょいずつちょいずつ、現代人に近づかないとな」

という月並みな結論となりました。

何かで触る。無理にでも触る。怒られても触る…という強引なドリブルをしていくべきで。

客観的であるべきで悲観することも禁物ですが、楽観なんかしてるとたちまちオマンマ食い上げになりそうです。
