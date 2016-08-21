# Sonarqubeで"SonarQube is under maintenance"と出た場合とその対処

## バイナリだけ新しくした場合などに

↑のようなメッセージが出る場合がある。

(画像とれたら取る)


これは…


## DBをマイグレーションする

以下のURLを叩くとマイグレーションが始まる。

http://[sarvername]:9000/setup

## はまりどころ

### Update直後、起動しない場合

```
Caused by: java.lang.IllegalArgumentException: Mapper for [ruleKey] conflicts with existing mapping in other types:
[mapper [ruleKey] has different [index] values, mapper [ruleKey] has different [doc_values] values, cannot change from disabled to enabled, mapper [ruleKey] has different [analyzer], mapper [ruleKey] is used by multiple types. Set update_all_types to true to update [search_analyzer] across all types., mapper [ruleKey] is used by multiple types. Set update_all_types to true to update [search_quote_analyzer] across all types.]

```
のようなログが出て、起動しない場合。

http://stackoverflow.com/questions/37781951/elasticsearch-bulk-index-error-on-sonar-startup

Elasticsearchのディレクトリをクリアする

$SONAR_HOME/data/es/ を削除後、sonarを再起動する。

### Findbugsなどが0％

データを全削除・テーブル再作成

http://qiita.com/a-suenami/items/e231adc2e083ef9449f6

※今までのデータを捨てることになるのは、人によっては痛手かもしれないが。
