# .NET CoreのプロジェクトをCIする方法

サンプル : https://ci.appveyor.com/project/KazuhitoMiura/dotnetcoresample/history


MSの.NET系のCI…といえばAppVeyorなのですが、.NET Coreのやつは「今まだ対応されてない」ので、 `appveyor.yml` という設定ファイルを書きます。

UIと両方できるのですが、設定ファイルに書きます。

https://github.com/Remote-Pairpro/DotNetCoreSample/blob/master/appveyor.yml

ランナーはxunitをつかってるので、いくつかのサイトでは「特殊な設定が必要」て感じなのですが、自分のプロジェクトでは `dotnet test` だけで行けました。

---

でも、AppVeiyrの売りは

「MS系の.NetのプロジェクトをCIビルド出来る、何も書かなくてもビルドコマンド探したりテスト種探したり、ある程度自動でアジャストしてくる」
ことにあると思うですが、ビルドもテストも書いてしまうなら、その利点も薄れます。

そう、 `.Net Core` なんだから「Linux系のCIサービスでもテスト実行出来る」わけです。

(CircleCIの例とか載せる)

## 参考資料

https://github.com/StevenLiekens/dotnet-core-appveyor/blob/master/appveyor.yml

https://xunit.github.io/docs/getting-started-dotnet-core.html

https://github.com/xunit/xunit/issues/1331
