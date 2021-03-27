---
published: true
layout: post
title: .Net5(.NetCore)でSpringBoot(SpringDI)風のAutoScanを実装する
category: tech
tags: [Dotnet5, DotnetCore, c#, DI, GenericHost]
---

# これを読んで得られるもの

- .Net5(.NetCore)でUIアプリケーション作成時、SpringBoot感覚のDI出来る仕組みが手に入る
  - GenricHost&DIで「注釈ベースのAutoScan(自動検索・登録)」なDIが出来るようになる

# 経緯

15年ぶりくらいに「WindowsのGUIアプリ(Windowsのクライアント)」を作成することになったのですが、Javaでサーバアプリを組むことが多かったので、「はあ、レイヤードアーキテクチャとDIで組みたいなぁ」と思ったのです。

.Net系は長く「スタンダードなDIがない(あるが割拠している)」と思っていたのですが、 昨今は「常駐系のアプリは全部コレ使え」な `Generic Host` への統一が促進される中で、MS謹製の `Microsoft.Extensions.DependencyInjection` というDIが付いてきたので飛びつきました。

ただこのDI「自力で登録する」式のやつで…JavaかつSpringBootでの「ここ以下と指定してアノテーション付けときゃ勝手にDI管理してくれる」の書き心地を知ってると、少々面倒…。

ということで「SpringBoot風の注釈で勝手にDI登録できる仕組み」を作ってみます。

# 前提

この記事は以下の前提で書かれています。

- VisualStudio2019がインストールされている
- `.NET5` がインストールされており、 `dotnet` コマンドが使える
- 作る対象のアプリはWindowsのGUIアプリケーションである

また、実装されたものが [こちらのリポジトリ](https://github.com/kazuhito-m/Dotnet5GUIWithSpringBootLikeDI) にあります。

# 設計

- SpringBootのDIの自動スキャン(Component Scan)を真似たものにする
  - C#ではアノテーションではなく `属性(attribute)` なので「classに特定の属性がついていたら」を条件とする
- SpringBootでのアノテーションと同等の属性を用意する
  - `Component`, `Repository`, `Service` あたりがあれば
  - `Controller` は、少し違うのでForm等のために `View` という属性にしてみる
- コンストラクタインジェクションのみを対象とし、それだけで良しとする
- オブジェクトのスコープは `Singleton` のみ
  - `Scoped`, `Transient` があるが今回は対応しない


# 準備作業

## 対象となるソリューション/プロジェクトの準備

対象となるアプリと「DIが出来る状態」までを事前に作ります。

1. VisualStudio2019にて新しいプロジェクトの作成から「Windowsフォームアプリ」を選びソリューションを作成
   - ターゲットフレームワークは `.NET 5.0` を選択する
2. プロジェクトへライブラリを導入する
   - 以下のコマンドにより `Generic Host` と `WindowsFormsLifetime` を加える

```DOS
cd [プロジェクトのフォルダ]
dotnet add package OswaldTechnologies.Extensions.Hosting.WindowsFormsLifetime
dotnet add pacakge Microsoft.Extensions.Hosting
```

3. `Program.cs` の `Main` メソッドを書き換える
   - `Generic Host` 式の起動方法に書き換える
     - 説明は割愛するが「GUIかつDI使える状態」が一番手っ取り早く使える方法
   - 「デバッグ開始」でForm1が表示され、「×」クリックで

```c#
static class Program
{
    static void Main() => CreateHostBuilder().Build().Run();

    public static IHostBuilder CreateHostBuilder() =>
        Host.CreateDefaultBuilder(Array.Empty<string>())
            .UseWindowsFormsLifetime<Form1>()
            .ConfigureServices((hostContext, services) => { });
}
```

## 対象となるアプリの実装

実際の実装は [こちらのリポジトリ]() になります。

「参考のための実装」なので、簡単な解説だけにします。

- `MiuraService.Get()` -> `IMiuraRepositry.Get()` から実装である `MiuraDataSource.Get()` が呼び出され `TheMiura` オブジェクトが取り出される
- `MiuraService` に `MiuraDatasource` がコンストラクタによりフィールドにオブジェクトがセットされる予定
- `Form1` には `MiuraService` がコンストラクタでフィールドにセットされる予定
- `Form1` は `Load` イベントで「 `TheMiura` オブジェクトからの文字列がタイトル部分に表示される」実装になっているが、現在は `NullReferenceException` で落ちる

![対象となるアプリの実装その1](/images/2021-03-28-implement-01.png)
![対象となるアプリの実装その2](/images/2021-03-28-implement-02.png)

# 「SpringBoot(SpringDI)風のAutoScan」の実装

## 属性(attribute)の作成

以下の実装を行います。

```c#
[AttributeUsage(AttributeTargets.Class)]
public class ComponentAttribute : Attribute { }

[AttributeUsage(AttributeTargets.Class)]
public class ServiceAttribute : ComponentAttribute { }

[AttributeUsage(AttributeTargets.Class)]
public class RepositoryAttribute : ComponentAttribute { }

[AttributeUsage(AttributeTargets.Class)]
public class ViewAttribute : ComponentAttribute { }
```

本家を踏襲し、`Component` を基本に、それ以外は継承した形としています。

## 属性を解釈しDIに自動登録するクラスの作成

「対象のアセンブリ中、特定の属性が付与されたクラスはDI登録する」という拡張メソッドを定義したクラスを作成します。

`IServiceCollection` をへの拡張クラスとして実装することとします。

```c#
public static class AttributedClassScannerExtension
{
    public static void AddAttributedClassOf(this IServiceCollection services, Assembly scanTargetAssembly)
    {
        scanTargetAssembly.ExportedTypes
            .Where(type => type.IsClass && !type.IsSubclassOf(typeof(Attribute)))
            .Where(type => type.GetCustomAttributes<ComponentAttribute>().Any())
            .ToList()
            .ForEach(type => RegisterDI(type, services));
    }

    private static void RegisterDI(Type type, IServiceCollection services)
    {
        if (type.GetInterfaces().Any()) 
            services.AddSingleton(type.GetInterfaces()[0], type);
        else services.AddSingleton(type);
    }
}
```

少々分かり辛いかもですが、以下を行っています。

1. 指定されたアセンブリ中から「クラス」かつ「属性でないもの」をフィルタ
0. `ComponentAttribute` あるいはそのサブクラスの属性が付いたものをフィルタ
0. 上記のフィルタを抜けたものを `IServiceCollection` へシングルトンでDI登録
  - インターフェイスを実装していなければクラス自身を、実装していればインターフェイスの1つ目を型として登録

## `Generic Host` から「DIに自動登録するメソッド」を呼ばせる

準備作業で書き換えた`Program.cs` をさらに書き換えます。

```c#
using [先程追加した AttributedClassScannerExtension のnamespace];

(省略)

static class Program
{
    static void Main() => CreateHostBuilder().Build().Run();

    public static IHostBuilder CreateHostBuilder() =>
        Host.CreateDefaultBuilder(Array.Empty<string>())
            .UseWindowsFormsLifetime<Form1>()
            .ConfigureServices((hostContext, services) =>
            {
                // ↓ここを追加
                services.AddAttributedClassOf(typeof(Program).Assembly);
            });
}
```

自身アセンブリを引数に、先程定義した拡張メソッドを呼ぶようにします。

拡張メソッドなので、`using` に対象クラスの `namespace` 記述を忘れないように。


## DIに登録したいクラスに属性を追加

DI登録の対象にしたいクラスに属性を追加していきます。

使う側からは、Attributeクラスの `Attribute` を除いたクラス名を属性として指定します。

例えば、

```c#
[Service]
public class MiuraService
{ /* 省略 */ }

[Repository]
public class MiuraDatasource : IMiuraRepository
{ /* 省略 */ }

[View]
public partial class Form1 : Form
{ /* 省略 */ }
```

と言った感じでクラスに付与します。

## 画面から「DIしたサービス」を呼び出し値を表示してみる

実際にDI登録・オブジェクトの取り出しとコンストラクタインジェクションが行われているかを動かして確認します。

VS2019で作ったままの `Form1` というFormがあるので、そのウィンドウタイトルに「Serviceから取得した値」を表示してみます。

`Form1` に以下の実装を行います。

```c#
[View]
public partial class Form1 : Form
{
    private readonly MiuraService service;

    public Form1(MiuraService service)
    {
        InitializeComponent();
        this.service = service;
    }

    private void Form1_Load(object sender, EventArgs e)
    {
        var miura = service.Get();
        Text = miura.ToString();
    }
}
```

起動したウィンドウのタイトルに "Kazuhito Miura" が表示されれば、Form -> Service -> Datasource(Repository) -> ドメインオブジェクト と辿って値を取得したということ。

つまりは「DIが属性ベースで自動登録されている」ということです。

![成功した場合のWindow表示](/images/2021-03-28-i-di-success-view.png)

# 所感

自分も、自身が所属しているチームも、普段は「Javaでサーバサイドを作ってるチーム」であり、「C#でクライアントを実装する」というのは寝耳に水でした。

せめて「書き心地を似せられないか？」と思ってDI部分をSpringBootに寄せてみました。

普段も「シングルトン期待で複雑な機能は使ってない」ので、それさえサポートすれば十分使えると思ってたので、狙い通りのものは出来た感じです。

…チームの仲間が無茶を言うてこなければ、ですが。

# 参考資料

- <https://blog.piyosi.com/entry/2019/12/26/224719>
  - ほぼこの記事のアレンジです、感謝
- <https://qiita.com/TsuyoshiUshio@github/items/20412b36fe63f05671c9>
- <https://ufcpp.net/study/csharp/sp_attribute.html>