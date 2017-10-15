# Gradleでbuildscript.dependenciesで指定したJarを取得する

とあるgradle pluginにて「JDBCドライバーJarの実pathを直書きしなくちゃいけない」ということがありました。

しかし、そのプロジェクトの「JDBCドライバーJarの指定」は `buildscript.dependencies` にしかなく、それが唯一でした。

```
buildscript {
    repositories {
        mavenCentral()
    }
    dependencies {
        classpath 'org.postgresql:postgresql:42.0.0'
    }
}
```

ので「それを落としてきたものを使いたい」となりました。

てなこって「buildscript.dependencies に指定されている依存性の実Jarを近所にコピーする」タスクを書きました。

```
task copyDatabaseDriverJar << {
    project.buildscript.configurations.classpath
      .findAll { it.name.contains("postgres") }
      .each { cp ->
        copy {
          from cp.absolutePath
          into project.buildDir.absolutePath + "/driverJar"
        }
      }
}
```

これで、自身のプロジェクトフォルダの `./build/driverJar` にjarがコピー出来るようになりました。

あとは、gradle pluginのタスクを叩く前に、必ずこれを実行するようにすれば、特定の場所のJarを取得できるようになるでしょう。

---

ちなみに、元の「やりたかったこと」であるgradle prluginは 'org.jumpmind.symmetric.schemaspy:schemaspy:5.0.0' というものだったのですが、動きませんでした。
