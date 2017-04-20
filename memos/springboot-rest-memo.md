# Sparing Boot でREST作るメモ

ちょっと全然つくりかたわかってないので、メモ。

## 参考リンク

- 教科書
  - https://speakerdeck.com/haljik/shi-lu-spring-mvc
- RESTの典型例
  - http://nave-kazu.hatenablog.com/entry/2015/04/03/135526
- RequestBodyで取得する例
  - http://kuwalab.hatenablog.jp/entry/spring_mvc/006
- 送信値->フィールド名へと変換する例
  - http://qiita.com/tag1216/items/01f469aeb49402fb0dc6
- バリデーションの例
  - https://terasolunaorg.github.io/guideline/public_review/ArchitectureInDetail/Validation.html
- バリデーションに指定できる「payload」について
  - http://d.hatena.ne.jp/gloryof/20131016/1381882607
  - カテゴライズのためクラスを指定し、それが取得できる…以外には使いみちは無いようだ
- バリデーションを何例か(Range等)
  - http://yamato373.hatenablog.jp/entry/2015/03/14/173810
- 例外を「一律に処理する」コントローラの定義方法
  - http://int128.hatenablog.com/entry/2016/11/27/230529
  - これを使えば「一律の処理」ができそう

### ちょっとした話

- @RequestBody + Stirng で「生データ」を取れる
- 「バリデーションを例外で受け取る」ためには「ただ `BindingResult bindingResult` を受け取らない」だけでよい


## その他

### SOAPの資料

- https://www.codenotfound.com/2016/10/spring-ws-soap-web-service-consumer-provider-wsdl-example.html
