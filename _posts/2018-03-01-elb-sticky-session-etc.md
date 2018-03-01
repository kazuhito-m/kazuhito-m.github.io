---
published: true
layout: post
title: ELBとStickySessionについて(2018/03現在)
category: tech
tags: [aws,elb,stickysession]
---

今回は、完全に「未来の自分への備忘禄」です。

（何かを伝えようとか読みやすいようにとかありません、あしからず）

# これを読んで得られるもの

- 2018/03現在のELB周りのあらまし
  - ELBの種類
  - ELBでのStickySession設定でできること

# 「理解済み」の前提

- 一般的な「スティッキーセッション」の定義
  - <https://code.i-harness.com/ja/q/a021df>
- ELBのスティッキーセッションについてまとめてみた
  - <http://blog.serverworks.co.jp/tech/2017/01/05/elb-sticky/>


# わかったこと

- AWS Elastic Load Balancer(以下ELB)の種類は現在三種類
  - Application Load Balancer(以下ALB)
  - Network Load Balancer(以下NLB)
  - Classic Load Balancer(以下CLB)
- 上記のうち「StickySessionを扱える」のはニ種類
  - ALBとCLB
- ALBのStickySession設定
  - 日本語ローカライズでは「維持設定」
  - 設定は「ターゲットグループ」に対して行う
    - 「ターゲットグループ」は「LBする対象の設定」だけ切り離したもの
      - ALBに「くっつける」ような設定する
    - 「属性の編集」から、維持設定の「有効化」をON
  - 「時間が設定できるだけ」で、あとは「ALBに任せ」で行われる
    - Cookie名は `AWSELB` 固定
- CLBのStickySession設定
  - 日本語ローカライズでは「維持設定」
  - 設定は「CLB自体」に対して行う
    - 「維持属性の編集」から「維持の無効化」以外を選ぶと有効化
  - 方式はニ種類
    - ロードバランサーによって生成された Cookie の維持を有効化
      - ALBのとほぼ同じ、Cookie名も `AWSELB`
    - アプリケーションによって生成された Cookie の維持を有効化
      - アプリや自身で設定したCookie名をチェックする
      - `Cookie 名` に任意の名前を入力する
        - JavaのWebコンテナなら `JSESSIONID` とかですね
  - 「アプリケーションによって生成された Cookie の維持を有効化」側を使っても、独自のCookieは必ず作る
    - 判定につかわないが必ず Cookie名 `AWSELB` なCookieを作る

# 気になって試したこと

せっかく「CLBでアプリのSession用のCookie名を指定して」も「結局使わないのに `AWSELB` なCookie作る」のがシャク(感情論)なので、 「アプリケーション側のSessionIDを格納するCookie名を一緒」にして、以下の２パターンで動かしてみました。

- ALB
- CLBで「アプリケーションによって生成された Cookie の維持を有効化」

アプリ側は、SpringBootなやつだったので、

```java
@SpringBootApplication
public class Application {
    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }
    @Bean
    public ServletContextInitializer servletContextInitializer() {
        return servletContext -> servletContext.getSessionCookieConfig()
            .setName("AWSELB");
    }
}
```

を仕込んでビルド、LB対象のEC2にデプロイしました。


結果は「StickySessionにならず振り分けまくられる」でした。

よく考えればそらそうですわな。「LB側で書いたものをアプリ側で同一名で書き直している」のだから、別モンと認識される…ということだろうと思います。

# (自分的に)覚えておきたいこと

- ELBでStiｃｋｙSessionを実現する場合、Cookie名を指定出来るのはCLB(古いやつ)だけ
- CLBでCookie名を指定しても、かならず `AWSELB` という名のCookieが作られてしまう(邪魔)

# 所管

…なんとなく、「思ってたのとちゃう！」ってなりました。

---

# 参考

- <https://dev.classmethod.jp/cloud/aws/alb-application-load-balancer/>
- <https://dev.classmethod.jp/cloud/aws/elb-sticky-session/>
- <https://docs.aws.amazon.com/ja_jp/elasticloadbalancing/latest/application/load-balancer-target-groups.html#sticky-sessions>
- <https://recipe.kc-cloud.jp/archives/8782>
- <http://unot13.hatenablog.com/entry/2017/06/04/202307>
- <https://qiita.com/eiryu/items/4b071bf0a194ea7abbf3>
- <https://stackoverflow.com/questions/34309576/how-to-manage-the-session-in-tomcat-load-balancing?rq=1>
- <https://shlomoswidler.com/2010/04/elastic-load-balancing-with-sticky-sessions.html>
