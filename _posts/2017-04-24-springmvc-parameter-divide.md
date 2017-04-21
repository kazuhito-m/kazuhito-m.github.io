---
layout: post
title: SpringMVCのRESTコントローラでリクエストを「パラメータの値によって」分岐する方法
category: tech
tags: [spring,spring-mvc,rest]
---

SpringMVCについては詳しくないので…「自分はこれが必要でこうした」という備忘録です。

(設計は自分じゃないのでアレですが、やり方については「もっと良いのあるよ！」等ツッコミ・助言お待ちしております)

# これを読んで得られるもの

- SpringMVCのRESTコントローラにおいて `@RequestMapping` を「パラメータの値によって」分岐する方法

# 経緯

とあるREST-APIのサンプル実装を作ることになりまして、SpringBootで作ることとしたのです。

「世のふつー」なRESTチックにつくれば良いか、と思って仕様を聞いたのですが…。

```
なお、URLは、一律に

http://[サーバ]/rest/api

にPOSTで受けることとし、
"behavior" パラメータによって振る舞いと受け取る値を決定するとする。
例: "getUser"でユーザ情報取得、 "getVersion"でシステムのバージョンを取得。
```

…

__俺の教わってきたRESTとちゃう！__

となったものの、まーやらなしゃーないので方法を調べてみました。

# 前提

- Java8
- SpringBoot:Ver.1.4.5.RELEASE

# やりかた

## やりたいこと

そりゃ

- `/rest/api` へのリクエストをRESTコントローラの1メソッドで受ける
- そこでパラメータの値でif文なり書いて分岐処理

を書けばいいのですが、やりたくない　& 多くのSpringMVC典型例のようにしたいので、

- 送信時のパラメータ1種類ごとに、RESTコントローラの1メソッドが受ける
- それをアノテーションだけで実現する

を狙うこととします。

## やったこと

上記の仕様を例に、 `RestController` を組むとすると…

```
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/rest/api")
public class SampleController {
    @PostMapping(params = "behavior=getUser")
    User getUser(@Validated @ModelAttribute Condition condition) {
        ...
    }

    @PostMapping(params = "behavior=getVersion")
    String getVersion() {
        return "1.0.0";
    }
}
```

という風に `@PostMapping` アノテーションの `param` にパラメータ名と値を `=` で続けて書けば「その送信値の条件を満たした時だけ動くメソッド」が出来るのですね。

( `@RequestMapping` , `@GetMapping` も同様です。)

もちろん、指定の値(behavior)自体も、それ以外のパラメータも `@ModelAttribute` や `@RequestParam` で受け取ることができます。

---

# 小並感

わかってしまえば、簡単に安全に書けるので、この仕様でやれ！バリエーション増やせ！っていわれても(設計におかしいやろ！と文句言いつつも)作っていけそうです。

…世にそんな人が少数派であることを切に願いますが。

熟達者の方たちには「は？あたりまえやろ」や「常識やろ」かもしれませんが、わりかしたどり着くまで時間がかかったので備忘で残します。
