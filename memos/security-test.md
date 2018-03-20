# セキュリティテスト関係

## サイト

- <https://observatory.mozilla.org>
- <https://www.ssllabs.com/ssltest/analyze.html>

## Content Security Policy (CSP)

自身サイトや指定したサイトからしか、JS/CSSを取らせない仕組み。

`Content-Security-Policy: default-src 'self'`

- 仕様説明
  - <https://developer.mozilla.org/ja/docs/Web/HTTP/CSP>
- Googleによる説明
  - <https://developers.google.com/web/fundamentals/security/csp/?hl=ja>
- SpringBootでの仕込み方
  - <https://qiita.com/opengl-8080/items/4e800eb6990653b0395c#content-security-policy>

## X-Frame-Options レスポンスヘッダ

iFrameを使わせないヘッダ。

DENYが望ましいが、怖いのでSAMEORIGINを設定っした。

`X-Frame-Options SAMEORIGIN;`

- 仕様説明
  - <https://developer.mozilla.org/ja/docs/Web/HTTP/X-Frame-Options>


## Strict Transport Security (HSTS)

httpをhttpsに飛ばすHTTPヘッダ。

- 仕様説明
  - <https://qiita.com/takoratta/items/fb6b3486257eb7b9f12e>
- SpringSecurityへの仕込み方
  - <https://qiita.com/opengl-8080/items/4e800eb6990653b0395c#strict-transport-security>
- SpringSecurityへの仕込み方2
  - <https://docs.spring.io/spring-security/site/docs/current/reference/html/headers.html#headers-hsts>

## SecureCookie

Cookieにセキュアオプションつける。

つけるには、ServletInitializerを弄う…が「つけることには成功したが挙動しなくなった」ので、断念。

- 概念と仕込み方
  - <https://qiita.com/dmnlk/items/b7d189d4dc09df1ee6b6#>
- httpsしかないサイトには設定してもあんま意味ないかもよ？の話
  - <http://d.hatena.ne.jp/masakiti2005/20060131/1138670266>
