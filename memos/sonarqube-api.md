# SonarQubeサーバのAPIの使い方

## 情報

- 本家サイトのページ
  - <https://docs.sonarqube.org/display/DEV/Web+API>
  - ここには「呼び方」しか書いてない
- SonarQubeサーバ中のヘルプページ
  - 基本、 `/web_api` で「そのサーバが使えるAPI」が表示出来る

## やりかた

## 参照

- pythonから実行
  - <https://www.monotalk.xyz/blog/sonarqube-web-api-を-python-から実行する/>

## 具体的なサンプル

f347c9ef07291e391f4a7a313e2550e8244b670c

curl -u THIS_IS_MY_TOKEN: https://hostm/api/f347c9ef07291e391f4a7a313e2550e8244b670c/search

curl -u jenkins:sniknej0 https://host/api/f347c9ef07291e391f4a7a313e2550e8244b670c/search

curl -u jenkins:sniknej0 https://host/api/issues/search

curl -u f347c9ef07291e391f4a7a313e2550e8244b670c: http://host:9000/api/issues/search


curl -u f347c9ef07291e391f4a7a313e2550e8244b670c: http://host:9000/api/projects

curl -u admin:admin http://host:9000/api/projects

curl -u f347c9ef07291e391f4a7a313e2550e8244b670c: http://host:9000/api/project_branches

curl -u f347c9ef07291e391f4a7a313e2550e8244b670c: http://host:9000/api/favorities


curl -u admin:admin https://host/api/projects/search

curl -u admin:admin https://host:9000/api/projects/search?ps=500

curl https://host/api/projects/bulk_delete -u admin:admin -X POST -d "projects="

curl -u admin:admin https://host:9000/api/projects/delete?project=product:master -X POST

curl -u admin:admin https://host:9000/api/projects/bulk_delete -X POST -d "projects=product:master"


curl https://host:9000/api/projects/delete -u admin:admin -X POST -d "project=product:なし" --verbose
