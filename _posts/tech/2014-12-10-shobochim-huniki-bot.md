---
layout: post
title: しょぼちむも”ふんいきbot"にして「条件反射」機能をつけた
category: tech
tags: [coffeescript、Kuromoji, conscript, docker, github, shobochim, jsorp, redis, ubuntu, hubot]
---

この記事は [しょぼちむ Advent Calendar 2014](http://www.adventar.org/calendars/327) 10日目の記事です。

昨日は [@cocoatomo](https://twitter.com/cocoatomo) さんの「[Syobochim and Kotlin Advent Calendar 12/09](http://tink.elliptium.net/2014/12/09/syobochim_and_kotlin_advent_calendar_12_09.html)」でした。

---

# 俺としょぼちむ

俺はこの「しょぼちむ」という人をこれっぽっちも知りませんが、そのしょぼちむ嬢、いや姫？ いやベムラーだったか…敬称はなにかも忘れましたけっども、確か出会ったのは「すっげー寒い冬の日」だった気がします。

なんか、たんご( [@tan_go238](https://twitter.com/tan_go238) )さんから「おおさかじょうでぷろじぇくしょんまっぴんぐやるからYouきちゃいなYO!」って言われて、「あ、若いお嬢さんも来るから」みたいなって、しばらくすると「ビール瓶を背中に背負ったコザケ( [@s_kozake](https://twitter.com/s_kozake) )さんが現れて「呑もやｗ」みたいなって、その後「すごく美人っちゃあ美人なんだけど、俺に執拗にダチョウ倶楽部のネタ振りをしてくる女性」が居て、その女性にお肉買って貰って餌付けされて、「怪獣、かわいいっしょ！かわいいっしょ！！」みたいなって、ほいでその女性と俺両方とも「人の名前を間違える」つー失礼ぶっこいて、梅田でスイーツ食って…

あ、この話すごくどうでもいいですね。

# しょぼちむさんは素敵な方です

例により、前回「[某氏アドカレ](http://natural-born-minority.blogspot.jp/2014/12/bot-irofhistory.html)」で作った「[ふんいきbot](https://github.com/kazuhito-m/funiki-hubot)」を活用(べ、別に手抜きじゃないんだからねッ！)して、「しょぼちむbot」作ろうってんで…。

ま、ネタかぶりは、[始まる前から鉄板予想されてた](https://twitter.com/kazuhito_m/status/530354021899304960)んで、全然キニシナイとしまして。

「ストーキング対象といくつかの「コメントテンプレート」を設定すると、頻出名詞を交えて"それっぽいツイート”してくれる」bot

でして、その名前は俺が勝手に提唱しているだけです。

※ちなみに「[ご当人もbot作ってる](https://github.com/syobochim/jyoshiryoku-bot/tree/jyoshiryoku)」のを後で知るのですが…色々かぶってる上に「そっちのが高度かつカオス」ですので…「こちとら雰囲気重視！」と虚勢を張っておきましょう。

# 実際見てみると…

まずは、「ふんいきbot」を しょぼちむアカウントに向けて、仕込みます。

[こんな感じ](https://twitter.com/syobochirn) になります。

ちなみに「常時つぶやくテンプレートのラインナップ」は…。

```bash
DEL comment_template
RPUSH comment_template '#{noun}〜'
RPUSH comment_template '#{noun}だっ！'
RPUSH comment_template '#{noun}だぜっ！'
RPUSH comment_template '#{noun} それですｗ'
RPUSH comment_template 'うわあああああああ！！！！！！！！！'
RPUSH comment_template 'おいやめろー！'
RPUSH comment_template '#{noun}！！？？！！！？！！？？！！！？！！？？！！！'
RPUSH comment_template '#{noun}に嫉妬！'
RPUSH comment_template '#{noun}！！！'
RPUSH comment_template "('ω'≡'ω'≡'ω'≡'ω')"
RPUSH comment_template '#{noun} ちゃうで！！！'
RPUSH comment_template 'その話、#{noun}感ある。'
```

こんな感じにしました。

…単文系が多いな…。

# でもしょぼちむさん、気難しい一面もあって…

どうも、俺こと [@kazuhito_m]() からのツイートはお気に召さないらしく、。

<blockquote class="twitter-tweet" data-conversation="none" lang="ja">
<a href="https://twitter.com/kazuhito_m">@kazuhito_m</a> <a href="https://twitter.com/Anubis_369">@Anubis_369</a> <a href="https://twitter.com/hyperkinoko">@hyperkinoko</a> <a href="https://twitter.com/s_kozake">@s_kozake</a> うるせーんだよみうみう！！<br />
— しょぼちむ@精進します (@syobochim) <a href="https://twitter.com/syobochim/status/541564102900858880">2014, 12月 7</a></blockquote>
<script async="" charset="utf-8" src="//platform.twitter.com/widgets.js"></script>

と返してきます。

きっと前世で、俺に親でも殺されたのでしょう。致し方ありません。

そしてもちろん！ うらがみさんには最高の笑顔で返します。

```
うらがみさん ////
```

きっと前世でも、うらがみさんがイケメンだったのしょう。致し方ありません。

他にも `女子力`,`ことりん` という言葉にも敏感なようで…。

仕様上「確実に決まるInとOut」なので、実装していきます。

# 条件反射(パブロフの犬)機能の実装

というわけで、「特定の人や特定の言葉(あるいは両方が揃う時)に無条件である文字をつぶやく」という「条件反射機能」を付けたいと思います。

"ふんいきbot"の永続化層はRadisです。

そのデータをネタ元にしたいのですが、この"ふんいきbot"の永続化層は"Redis"にしてしまいました。

Redisは「かなりKeyValue感ある」ので、単純には「値一つのデータの羅列」しか持てません。

そこで…

```bash
RPUSH dog_of_pavlov '<TwitterID>,<引っ掛けたい本文の正規表現>,<返信の文字>'
```

__出、出〜ｗｗｗｗ 「一つのフィールドにカンマ区切りでデータ入れ」奴ｗｗｗｗｗ__

「イケてない怠惰根性丸出し」の実装で行きます。。o O (ええねんもう今日は動いたら！)

こんな感じで

「Bot宛のメンションで、TwitterID(全一致)か、正規表現か、どちらかに引っかかったやつだけ、特定のコメントを返す」

という条件で行こうかと思います。

で、出来た定義データが…

```
RPUSH dog_of_pavlov 'kazuhito_m,,みうみううるせー！！'
RPUSH dog_of_pavlov 'backpaper0,,うらがみさん////'
RPUSH dog_of_pavlov ',.*ことりん.*,やめろー！ことりんのことは…みうみううるせー！！'
RPUSH dog_of_pavlov ',.*女子力.*,女子力？わたしそのものですよね！！'
```

お、俺…いったい何やってんだろうなぁ…。

(只今深夜の４時を回ったところです。)

# 実装してみる

やっつけ仕事ですが…付け焼刃のCoffeeなんちゃらーで書きます。

```coffeescript
# 相手のメンションが、Radisで設定したキーワードに合致した場合に条件反射でメンションを返す。

# 定数

TEMPLATE_KEY='dog_of_pavlov'

# 前準備、Redisクライアント用意
client = require('redis').createClient()

# Redisから条件のLISTを配列で一撃で持ってくる
key = TEMPLATE_KEY
templates = null
client.llen key , (err,count) ->
 client.lrange key , 0 , count-1 , (err,value) ->
   templates = value

# 本処理
module.exports = (robot) ->
# とりあえず「何が投げられても」拾って、自力で正規表現で判定する。
robot.hear /.*/i, (msg) ->
  twitterId = msg.envelope.user.name
  menthion = msg.message

  # 予め取得したテンプレート(CSV)を全件回しながら
  for i in templates
    [id , regex , comment] = i.split(",")
    # id未指定 or 一致したら
    hitId = id.trim().length == 0 || twitterId == id
    # もしくは、regex未指定 or 正規表現にひっかかったら
    hitRgx = regex.trim().length == 0 || ///#{regex}///.test(menthion)

    # 指定されていた条件に、どちらかにあてはまってたら、条件反射してしまうコメントをつぶやく
    if hitId && hitRgx
      msg.send "@#{twitterId} #{comment}"
      break
```

稚拙だから見ないで、見ないでよ〜。(ﾁﾗｯﾁﾗｯ

# しょぼちむ(bot)に挨拶してみる

無事出来たことですし、しょぼちむ(偽)にメンション送ってみましょう。

(俺に対しては「うるせー！」しか言ってくれないので、他の方の力も借りましょう)

![みうみうの反応](/images/2014-12-10-syobochirn01.png)

![ことりんの反応](/images/2014-12-10-syobochirn02.png)

![女子力の反応](/images/2014-12-10-syobochirn03.png)

…なんでしょうか、完成したのにちっとも嬉しくありません。

ああ、ウラガミさんの場合の返事のテスト？ まあいつか見れるんじゃないすかー？ (投げやり

# 感想・所管

- 簡単なことなのに結構時間がかかりました
- 雰囲気出すには「人間の設定」が大事だし、タイムリー性と運営考えたら「自動収集」が望ましいし…考えは尽きないですね
- 固定のコメントは別にいいとして、その中にも通常コメントみたいにランダムワード使えるようにしたいですね
- 果ては「そのコメントテンプレート」すらも「頻出類似文章」から作れる…とかならもっと本物っぽくて、できたらいーなー

# 結論

- しょぼちむは、みうみうに厳しい。(笑いの道的な意味で)

# PS:
うらがみさん、話しかけたようです。

![うらがみさんへの反応](/images/2014-12-10-syobochirn04.png)

よかったね [@syobochirn](twitter.com/syobochirn) ♪ ※これ…編集してありますが、返信になってないので修正しました。

---

明日は [@uemmra3](https://twitter.com/uemmra3) さんの「[扶養～とは](http://d.hatena.ne.jp/Uemmra3/20141211/1418333078)」です。
