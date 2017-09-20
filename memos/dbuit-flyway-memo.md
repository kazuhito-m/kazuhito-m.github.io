# DBUnit & Flyway 設定一本化 メモ

DBUnit と Flyway を別々に導入し、同一に扱わなかった場合に、後から統合する方法についてのメモ。

また、SpringBootを使っていない(テスト時にプロパティから取れない)前提も加える。

## SpringBootでDBUnitとFlywayのサンプル

- 大畔さんの例
  - <https://github.com/bigro/matcheam/pull/98/files>
- Spring BootとMyBatisで複数のDBを扱う
  - <http://progmemo.wp.xdomain.jp/archives/839>

## DBへのコネクションをプロパティファイルから取る例

- 一例
  - <https://www.journaldev.com/2509/java-datasource-jdbc-datasource-example>
-

## DBUnitの基礎知識

- DBUnit本家
  - <http://dbunit.sourceforge.net/howto.html>
- DBUnitに触る
  - <http://muimi.com/j/test/dbunit/>



## Gradle内で「プロパティファイル」のようなものを参照する手段

- 「ディレクトリ」の変数群
  - <http://waman.hatenablog.com/entry/2014/05/25/064736>
- プロパティファイルの扱い
  - <http://npnl.hatenablog.jp/entry/20101121/1290356773>
