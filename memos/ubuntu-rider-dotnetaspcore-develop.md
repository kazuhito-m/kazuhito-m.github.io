# UbuntuとRiderで「ASP.NET Core」の開発環境を整える

※要点だけ

# 得れるもの

- Ubuntu(Linux)オンリーでASP.NET CoreのWebアプリを開発する方法

# インストール

順番に入れる

- https://www.microsoft.com/net/core#linuxubuntu
  - 最後までやる
- 一応、Weｂアプリサンプルも作成＆起動させてみる

```bash
mkdir webapp
cd webapp
dotnet new web
dotnet restore
dotnet build
dotnet run
# localhostで"Hello World！"なWeｂアプリが動いてればOK
```

- Rider入れる
  - https://www.jetbrains.com/rider/download/ へ行って.tar.gzを落としてくる
  - 解凍し、 `./bin/rider` を蹴る
- Riderで `ASP.NET Core Web App` のプロジェクトを作成する
  - New -> ASP.NET Core Web APP を選びCreateボタンを押す
- Riderを閉じ、dontetコマンドでrestoreする
  - ハマり点
  - 何故か「作った直後は、System系のオブジェクトが軒並Notfound」「アセンブリも落とせない」
  - ので、プロジェクトまで降りて行って、一度 `dotnet restore` する
- 再度Riderでソリューションを開き、実行
  - Run -> Run Default で、ビルドが成功し、 `http://localhost:5000` でページがが確認出来る

## 感想

Ubuntuの環境ですべてが出来る、というのは精神衛生上も良いし、コンソール使えるので捗る。

## その他

- 作っていく上での勉強ページ
  - https://blogs.msdn.microsoft.com/nakama/2016/07/07/aspnetcore10/
