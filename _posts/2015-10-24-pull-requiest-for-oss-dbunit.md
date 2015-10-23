---
published: true 
layout: post
title: 人生初プルリクをOSSに投げ込んでみた結果　#dbunit
category: tech
tags: [test,dbunit,oss,git]
---

![親方！サイトに俺の名前がっ！](/images/2015-10-24-baban.png)

少し前の話しなのですが…もうなんだか「すごく嬉しかった」ので、恥ずかしながら書いていきます。

# OSSのプロダクトに自分の変更を取り込んでいただきました

仕事で使う目的で家でちょこちょこ触っていました「DBUnit」に、俺の変更を取り込んでいただきました。

([ここ](http://dbunit.sourceforge.net/changes-report.html#a2.5.1)の "Upgrade Apache POI library from ..." が「自分のプルリクの内容」です。)

# 自分、よく考えたら他人に"pull request"とかしたこと無かったんです

よく考えなくともですが、仕事でgit使った事(その当時)ないし、多人数開発してないし、GitHubの垢あるけど他人にプルリク投げたことないし…。

そういう初物づくしだったけど「ま、こんだけ初物だらけやったらミスっても凹まんやろ」
ってのと「そろそろミソギが必要かな？」って思ってたので、勢い出してやってみたです。

# 経緯

ざっくり言えば「DBUnitのExcel読み書きを、xlsx形式にも対応した」だけです。

ドSIerな現場で「自動テストの事前条件流し込みの仕組みを考える」という仕事をした際に、
「皆が使えるつったらExcelだよな…」ということから、横の人に「死んだプロダクトを？いまさら？w」
とかなんとか言われつつも、DBUnitを使う事としました。

で、現場ではExcel2007だったので「xlsxで書いてもらえばいいか…」と思っていたのですが、
DBUnitは2007未満の形式であるxls形式にしか対応していなかったんです。

内部でExcelの読み書きに使っているPOIは、早々と対応していたし、
「対応する」というイシューも数年前に出てる…のに頓挫しているようでした。

そこで、自身の仕事の進みも関係あるので、直してプルリクしよう！と思ったのが発端です。

# 具体的な変更点と利用方法

## 変更の概要

DBUnitの「Excelファイル <-> DB インポート/エクスポート機能」に、[xlsx形式(Excel2007からのファイル形式)](http://mitsutakauomi.com/?p=362)に対応しました。(今まで出来なかったのです)

```
xls形式,xlsx形式ファイル --> DBUnit(XlsDataSet) --> DB
DB --> DBUnit(XlsDataSet) --> xls形式ファイル
```

インポート時には「ファイル形式は自動判定」で読み込まれます。

エクスポート時は今まで通りxls形式ファイルがデフォルトですが__「少しの改造でxlsx形式を吐けるよう」__にしました(つもりです)。

## 具体的な使い方

### 前準備

例によりMaven Centralから「DBUnitを自プログラムに読み込む」ようにして下さい。

Mavenを使っているなら、pom.xml の`<dependencies>`タグに以下ですね。

```xml
<dependency>
	<groupId>org.dbunit</groupId>
	<artifactId>dbunit</artifactId>
	<version>2.5.1</version>
</dependency>
```

### インポートの実装方法

xlsx形式で読み込みたい場合は「いままで通りの実装方法」でOKです。

例えば、ExcelワークシートのデータをDBへインポートする一般的なコード…

```java
public static void main(String[] args) throws Exception {
    IDatabaseConnection con = null;
    try {
        con = getConnection();
        IDataSet dataset = new XlsDataSet(new File("Excelのデータファイル"));
        DatabaseOperation.CLEAN_INSERT.execute(con, dataset);  // deleteしてからinsert
    } finally {
        if (con != null) {
            con.close();
        }
    }
}
```

があるとした際に、`"Excelのデータファイル"` が、xlsでもxlsxでも意識せず読み込みます。

あとは、おそらく使ってる方としては「自前FWとかなんかかぶせて使ってる」と思われるのですが

+ プログラム中に埋まってるExcelファイル名の文字列修正(.xls -> .xlsx)
+ Excelファイルの変換

くらいが仕事かと思われますが「ファイルサイズが小さくなる」など[それなりのメリット](http://www.itmedia.co.jp/enterprise/articles/0702/08/news051.html)に魅力があるなら移行されたらいかがでしょうか、というところで。

### エクスポートの実装方法

xlsx形式で書き込みたい場合「既存の実装を改造」する必要があります。

例えば、DB中のデータをExcelワークシートへエクスポートする一般的なコード…

```java
public static void mail(String[] args) throws Exception {
	IDatabaseConnection con = null;
	try  {
		con = getConnection();
		IDataSet dataset = con.createDataSet();
		XlsDataSet.write(dataset, new FileOutputStream("Excelのデータファイル"));
	} finally {
		if (con != null) {
			con.close();
		}
	}
}
```

があるとした場合、上記の

```java
XlsDataSet.write(dataset, new FileOutputStream("Excelのデータファイル"));
```

の箇所は、内部の実装を展開すると

```java
XlsDataSetWriter writer = new XlsDataSetWriter();
writer.write(dataset, new FileOutputStream("Excelのデータファイル"));
```

となるのですが、この"XlsDataSetWriter"のメソッドを一部オーバーライドすることにより、xlsx形式で出力できます。

実際に書いてみますと…

```java
public static void main(String[] args) throws Exception {
	IDatabaseConnection con = null;
	try  {
		con = getConnection();
		IDataSet dataset = con.createDataSet();
		XlsDataSetWriter writer = new XlsDataSetWriter() {
			@Override
			public Workbook createWorkbook() {
				return new XSSFWorkbook();
			}
		};
		writer.write(dataset, new FileOutputStream("Excelのデータファイル"));
	} finally {
		if (con != null) {
			con.close();
		}
	}
}
```

と「６行追加」の対応となります。

※割と煩雑ですね…今考えると、

+ XlsDataSet.writeX()みたいなの作る
+ XlsxDataSetWriter作る 
+ XlsDataSetWriterにフラグでもなんでもつける

など出来そうなのですが、当時(後述する理由で)ヘタレまくっていたのでいたしかたありません。

# 頓挫していた(と思しき)理由

※俺は「英語力がクリオネばり」ですので、推測を多分に含むということを前置きしておきます。

この対応の要求は[こちら](https://sourceforge.net/p/dbunit/feature-requests/161/)に5年前に出ていたのですが…どうして「長らく対応が無かったか」というと…

0. チケット作った人「POI(Excelのライブラリ)の最新に対応してくれ。パッチ作ったし反映してよ。」
0. チケット作った人「(無言でパッチのファイル貼る)」
0. コミッタAさん「最新に上げる事の理由て何？で何か解決したん？バグフィックス？彼ら(POIチーム？)は『治すとなんか壊す』からな…」
0. チケット作った人「はい理由あります。データ6万6千件(xls形式の上限)以上扱う必要がある。自分のパッチなら両方イケる！」
0. 〜〜ここから一年後まで音沙汰なし。ポツポツ「俺もほしいわー」な投稿〜〜
0. 2012年の人「2年たったしDBUnit最新版出たけど…これ対応する予定あります？私も興味あるんですけど…」

ときて、

+ __Jeff Jensenさん(能動的に動いてるコミッタさん)「この対応を必要としてる人のために、最新のPOIを機能させるために必要な変更だけのクリーンパッチを添付してください。(チケット作った人が作った)添付のパッチでは、スペース->タブに変えるとか不必要な変更が入ってますから。」__

からの三年が今年。

「世の中って、こういうふうに停滞してくんだなぁ」という感じを垣間見ました。

## そこにプルリク送ろうとした俺なわけですが…

なんとなく「うわぁ…ようSIer案件で見る『その話しはもう終わったことになってるから触れたらあかんヤーツ』っぽいわぁ…」と思いまして。

+ 修正は十分に簡単であること
+ テスト付きで下位互換は取ってること
+ 多くの人がこの問題に個別対応してバッドノウハウが広がってること
+ それを止めたいこと
+ この対応がマズければ蹴ってくれていいから、とりあえず見てほしいこと

をアピりながら、プルリク投げました。

# この対応で気をつけたこと

## コミニュケーション

すべては「英語でのやりとり」につきます。(自身の英語力は小学生以下なので…)

経緯から「ありのままを伝わるカタチで書かないと蹴られるor無視されるだろう」と推測したので…

0. プルリク自体の[コメント](http://sourceforge.net/p/dbunit/code.git/merge-requests/6/)
0. sourcefoge.netのTicketに対しての[お願い投稿](https://sourceforge.net/p/dbunit/feature-requests/161/#aa08)

と「理由や経緯や願いを書く機会」があったのですが、すべてで

+ できるだけ具体的に細かく
+ 思いの部分はそれと解かるように
+ 思いの部分以外は公正に
+ 翻訳サイト２つ以上で、日->英->日して「意味が変わってない」のを確認する

を行い、投稿してました。

## プログラム

プログラムについては

0. テストを頃合いにつける
0. 下位互換を死守する
0. 修正点は少なく簡易である

を心がけました。

### テストを頃合いにつける

経緯的に「Ticketの最初の人がテスト無しで蹴られている」ので、テストが「適切なカタチ」で存在しないと受け入れられないだろうと。

とはいえ…

+ テストが無駄に多すぎてもダメ
+ 足りなくてもダメ
+ 意味が伝わらなくてもダメ
+ 自身のテストスキルはゴミクズ(自分の考えは信用出来ない)

なので、受け入れられるのは難しいと思っていました。

幸い今回の「変更の特性」が「既存のものにもう1パターン対応する」性質のものだったので、

+ 既存のテストをコピーして増やす

に徹しました。(普通はアカンけど)

### 下位互換を死守する

「よく知られ利用者も多い(だろう多分、だって俺でも知ってるし使ってんだもんw)プロダクト」なので
「既存の仕様をビタ一文変更してはならない」と心に決めて対応しました。

上にも書きましたが、「今回の対応で出力側もxlsx形式に変更する」ことも出来たのですが、

+ 多くの利用者のコードを変更する必要があるだろうこと
+ その仕様を議論・結論付ける交渉に自信が無かった

ので、

+ デフォルトの出力はxlsのまま
+ 変更しようと思えば簡易なように「オーバーライド可能なメソッド」を用意

にしました。(これも本当はプロダクトのためにはアカンかもしれないし、ヘタレてるけれど)

### 修正点は少なく簡易にする

そもそも目的が「使用しているライブラリの更新」なので、そんなに膨らまない性質のものなのですが…。

それでも「極力変更せずに目的を達成する」ことを頭に置きました。

具体的には「[プロダクトコードは、3ファイルにそれぞれ30行以下に抑えて](https://sourceforge.net/u/kazuhito-m/dbunit/ci/c6a6ba9e4fe929865c147af8e44eb35ea234ceca/)」という感覚に(最終的に)なりました。

# なんだかんだで「言いたかった事」は！

なんとなく、記事中から「ドヤ顔ダブルピース」な感じが出てるのはなんとなく自覚の上ですが…。

「初老」だろうが「人生初」だろうが「トイメンが英語な人ら」だろうが「有名・無名」だろうが「変更内容がカスみたいなモノ」だろうが…
「とりあえず変更を投げてみた」ら良いと思ったんです。

受け入れられると超ハッピー！で、受け入れられなくとも経験になるし、なんか臆してたのがもったいないと思いまして。


たとえば…　

+ お試しで「改造したちょこっとしたもの」をプルリクにまとめて送ってみる
+ (自由の効く環境なら)仕事でした対応を「本家に投げてもよいか」を責任者に掛けあってみる
+ 仕事でした対応を家で思い出して再現、プルリク送ってみる
+ 仕事で使う内容を家であらかじめお試し…したものをプルリク送ってみる(今回の俺ね)

などを「生活に支障のない程度に狙ってみる」のも、なんとなく楽しくなれるかもしれません。

俺みたいな「底辺落ちこぼれギョームプログラマー」でも(時と場合により)世界は優しいです。

---

以上、嬉しかった体験報告でした。

# 参考

以下を参考にさせていただきました。ありがとうございます。

+ [http://qiita.com/wheatter/items/77dc40e0bb526660af3a](http://qiita.com/wheatter/items/77dc40e0bb526660af3a)
+ [http://hermesian.hatenablog.com/entry/2014/06/21/141720](http://hermesian.hatenablog.com/entry/2014/06/21/141720)
+ [http://www.52testing.com/showart.asp?id=180](http://www.52testing.com/showart.asp?id=180)
+ [http://blue-red.ddo.jp/~ao/wiki/wiki.cgi?page=JUnit](http://blue-red.ddo.jp/~ao/wiki/wiki.cgi?page=JUnit)
+ [http://irof.hateblo.jp/entry/20100703/p1](http://irof.hateblo.jp/entry/20100703/p1)
+ [http://mitsutakauomi.com/?p=362](http://mitsutakauomi.com/?p=362)
+ [http://www.itmedia.co.jp/enterprise/articles/0702/08/news051.html](http://www.itmedia.co.jp/enterprise/articles/0702/08/news051.html)
+ [http://www.techscore.com/tech/Java/Others/DBUnit/2-3/](http://www.techscore.com/tech/Java/Others/DBUnit/2-3/)
+ [本家サイト系から拝借したURL](http://dbunit.sourceforge.net/)
    + [http://dbunit.sourceforge.net/changes-report.html#a2.5.1](http://dbunit.sourceforge.net/changes-report.html#a2.5.1)
    + [http://sourceforge.net/p/dbunit/feature-requests/161/](http://sourceforge.net/p/dbunit/feature-requests/161/)
    + [http://sourceforge.net/p/dbunit/code.git/merge-requests/6/](http://sourceforge.net/p/dbunit/code.git/merge-requests/6/)
    + [http://sourceforge.net/u/kazuhito-m/dbunit/ci/c6a6ba9e4fe929865c147af8e44eb35ea234ceca/](http://sourceforge.net/u/kazuhito-m/dbunit/ci/c6a6ba9e4fe929865c147af8e44eb35ea234ceca/)
