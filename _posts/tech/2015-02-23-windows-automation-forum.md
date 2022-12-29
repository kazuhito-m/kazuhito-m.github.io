---
layout: post
title: 勉強会行ってみた「Windowsでの自動化について考える会」#WinAutoMate
category: study-meeting-repo
tags: [windows,automation]
---

「自動化と聞いて！」にOS関係ありませんもんね。行って来ました。

# 情報

- [申し込みサイト](http://connpass.com/event/11779/)
- [当日まとめ(Togetter)](http://togetter.com/li/786072)
- ハッシュタグ [#WinAutoMate](https://twitter.com/search?q=%23WinAutoMate)
-   何するのか :
    実は「Windowsの冠」は飾りであり、『自動化好きなデベロッパがワッショイワッショイする催し』…だったらいいなｗ

# なんで来たん？

社会人になり「自分の事はMSの社員になったと思え！」とWin95デザインガイドを抱きしめ(させられ)、デスクトップアプリ作ってた20代前半。

それがイヤで反動から「LinuxやOSSの世界」を手持の道具にした現在。

時を経て、CI(継続的インテグレーション)やCD(継続的デリバリー)知って眺めるに、浦島太郎となった「Windowsの世界」にも、 `Infrastracure as Code` 等の「新しい概念」がそろそろ来てるんじゃね？ってことで知識を仕入れるために参加です。

---

# 内容

## 1コマ目 基調講演 「Windowsでの自動化の手段」

登壇者 : ヒダリさん ([@HIDARI0415](https://twitter.com/HIDARI0415)) さん

資料:

<iframe src="//www.slideshare.net/slideshow/embed_code/key/7juGiKbnUDOC8f" width="340" height="290" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="//www.slideshare.net/ikawasho/windows-44952663" title="Windowsでの自動化の手段" target="_blank">Windowsでの自動化の手段</a> </strong> from <strong><a href="//www.slideshare.net/ikawasho" target="_blank">Hidari Ikw</a></strong> </div>

本勉強会の主催者であり『露払い』的役目のヒダリさんの発表です。(俺が遅刻して前半見てないのは言うなｗ)

自動化のための手段には「３つのレイヤー」がある…というのは、凄く納得行く良い説明ですね。

「Scripts」方面に関しては、懇親会でも話していたのですが、
(原始的側) コマンドプロンプト <-> PowerShell (プログラミング側)と、(吟味し進化したものの)両極に(まだ)振りすぎなんじゃないか？
という話をよくします。

で「頃合いのがほしいねん…」っていうlinux/UNIX好きがWindowsに「Sygwinだ、GitBashだ」と入れ始める。

その話を「宗教戦争にせず」に、要求ベースで考えると…

-   (イラっと来ず、かつ複雑でない程度の)制御構文(if,for,etc..)
-   リダイレクトやパイプなど「結果を受け継ぐ」に充実した手段(xargsとかも込で)
-   「式」も出来る限りコマンドとして(bashのforとかexprとか)

なのかなーと、漠然と。(まあ、だからといって「ご破算にして4つ目作れ」とは言いませんけどｗ)

「Build Tools」に関しては"必修！" ハイ終了。

「Executers」に関しては、やはり「MS側のJenkins-er代表」のヒダリさんの面目躍如で、そうなりますよねｗ

古い人間としては「スケジューラはサードパーティ含め数々の趨勢があった」感じがしていて、やはり「公式(タスクスケジューラ)では弱い」という認識が一般的なのではないかな？と思っていましたし、ここは「標準装備で」の進化を期待したいと思います。(だいぶ進化しましたけどね)

最後に「だがpauseお前はダメだ」で参加者(fkmtさん)から「pause陣営側からのフォロー」が入ってましたが、「自動化する時(無人自動実行バッチ)には邪魔者」ってことだと思います…ってことでヒダリさんに賛成！

## 2コマ目「Windowsの自動化今昔先夢語」

登壇者:森理 麟 ([@moririring](https://twitter.com/moririring))さん

資料:

<iframe src="//www.slideshare.net/slideshow/embed_code/key/3YOfrp1ZHxZPm6" width="340" height="290" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="//www.slideshare.net/moririring/windows-44952209" title="Windowsの自動化今昔先夢語" target="_blank">Windowsの自動化今昔先夢語</a> </strong> from <strong><a href="//www.slideshare.net/moririring" target="_blank">森理 麟</a></strong> </div>

[本も執筆](http://www.amazon.co.jp/dp/4798138223)され絶好調のモリリンさん。

この方の立ち位置って、なんとなく「ホームグラウンド/得意技を"MS系"にしている(そりゃMVPだしｗ)」のだけれど、それにとらわれず「自動化自体の実現方法と有用性を探ってる」っぽく思えて、そこが好きなんですよね。

で、良く似た事を考えてる…気がするｗ

特に「金銭のライフログ問題」とかの話されてたんですが、それもかぶってる上に高度でまた悔しい…ｗ

俺も前から「[金銭](http://natural-born-minority.blogspot.jp/2011/04/pasoriferica2moneygnucash.html)」と「健康(例:[体重](http://www.withings.com/eu/smart-body-analyzer.html)とか)」と「[勤怠](http://www.slideshare.net/miurakazuhito/automate-24393158/37)」については「[無入力ライフログ](http://www.slideshare.net/miurakazuhito/aaa-all-forautomation/96)」と名付けてライフワークにしているのですが…これは「一度二人で話し合った」ほうが良いのかもしれません。


## 3コマ目「価値あるシステムテスト自動化の実現By friendly」

登壇者 : 石川 達也 ([@StoneGuitar777](https://twitter.com/StoneGuitar777) )さん

資料:

<iframe src="//www.slideshare.net/slideshow/embed_code/key/LsHKGxffFzAxFD" width="340" height="290" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="//www.slideshare.net/tatsuyaishikawa7334/by-friendly" title="価値あるシステムテスト自動化の実現By friendly" target="_blank">価値あるシステムテスト自動化の実現By friendly</a> </strong> from <strong><a href="//www.slideshare.net/tatsuyaishikawa7334" target="_blank">Tatsuya Ishikawa</a></strong> </div>

テスト系[OSSプロダクト](http://www.codeer.co.jp/AutoTest)作成者 兼 社長
兼 MS-MVP 兼 おとん 兼 ギタリストの石川さんです。

「プレゼンの匠さ」と「扱ってるモノの良さ」も相まって「一番人の気を引いて、一番質問が多かった」セッションでした。

実はすっげー重要な事を前半言ってまして…

-   テストPGに「ある程度の抽象度」があれば「ロールを超えた共通知」に出来る可能性がある
-   Windowsクライアントのテストにも「WebにおけるPageObjectぽい考え」を入れるべし
-   その道具は「デフォで無い」ので「選ぶ/探す必要」がある(そうでなければ茨の道を…)

てな話が入ってたんじゃないかなーと思うのですが、自分のコンテキストで解釈しすぎでしょうか。

------------------------------------------------------------------------

## 4コマ目「Hyper-VとPowerShellによる仮想サーバの自動構築」

登壇者 : waka さん

資料:
[ここ](https://onedrive.live.com/view.aspx?cid=0F3E147846A50325&resid=F3E147846A50325%212752&app=PowerPoint&authkey=%21AH3HDIAwWXsEW2s)

今回は「コレを観に来た」のです。

実際、CI/CDを考える時に

-   構成をプログラムで書ける
-   (OS/ミドルの組、またそのVerの組など)組み合わせ違いの環境を簡易に用意出来る
-   クリーンな環境を用意できる

ってのは凄い「値打ち」があって、自分は「Windowsでそれやる方法」に疎かったので…。

ただ、セッション中wakaさんが「誰得」「これ役立つかどうか…」としきりに言われてたのが気になりました。
実際、仕事で…

-   個々プログラマの「開発環境端末管理」がアフォほどコストかかる
-   端末をクラウド化してVDI出来ないか
-   共通部分(OS,ミドル,プログラム)は構成管理しときたいしビルド出来るようにしたい

という要望に「なんかない？」って言われ、応えられないことがありました。

そうでなくても「Linux/UNIX界隈はいいけど、WindowsServer周りの構成管理、どうすんねん！？」って問われることが何度かありました。

ニーズは多い…いや多く無くとも「クリティカルに必要としてる所はある」と思っていて、「そういうトコと繋がってくれはったらいいなー」と(自分は何もせず他力本願に)願っています。

あ、急に話変わりますけど「自分で作るときはHiper-Vに依存しない書き方を学びたいなー」と思いました。

しっかし…「サ○ラエディタが起動する度に会場から拍手が巻き起こる」ってセッション、大爆笑しましたｗ

------------------------------------------------------------------------

## 番外 懇親会

もう掛け値なしにおもろかったです！

登壇者＋αで居酒屋に行ったのですが「自動化について全員一家言を持ってる」ってメンツと話すのが楽しくて楽しくてｗ

最終的に
「世の中のエンジニアは二つに別れる…『勤怠をつけなくてはならない』か『そうでないか』だ！」

からの「勤怠エリート」「勤怠貴族」って話のクダリがww今も腹筋をwwww


# 所感

自動化の「マインド・考え方」と「実現手段」のバランスが凄く良い、余す所無い勉強会だったと感じました。

自動化は喧伝されるより取り組んでるところはすくなく、ましてそれを軸にするエンジニア、かつ勉強会に来る人はそう多くないのかもしれない…というのが最近の感覚です。(だっていっぱいおったら仕事なくなってまうし)

ましてやWindowsっていうコンテキスト限定で30人前後集められる、というのは大成功なのではないでしょうか。

ド個人的には「次は無いんですか」ってのと「なんなら懇親会だけでも」と、運営に投げ込んでおきたいですｗ

---

主催者ならびに、スタッフの皆様、会場MOTEX様、お疲れさま＆ありがとうございました。
