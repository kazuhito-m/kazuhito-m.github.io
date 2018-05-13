# GitlabサーバのAPIの使い方

## 情報

- 本家サイトのページ
  - <https://docs.gitlab.com/ee/api/README.html>
- ユーザのトークンを使ってログインする方法
  - <https://docs.gitlab.com/ee/api/README.html#authentication>

## やりかた

## 参照


## 具体的なサンプル

curl https://gitlab.example.com/api/v4/projects?access_token=uNeGKXum7ua__sTw6s1C

curl http://gitlab.example.com/api/v4/projects?private_token=uNeGKXum7ua__sTw6s1C

curl http://gitlab.example.com/api/v4/projects/10/repository/branches?private_token=uNeGKXum7ua__sTw6s1C
