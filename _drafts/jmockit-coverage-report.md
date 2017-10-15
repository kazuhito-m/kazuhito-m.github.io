# JMockitのカバレッジの設定をGradleに仕込む方法

## Jmockit自体の導入

```groovy
dependencies {
    testCompile org.jmockit:jmockit:1.23'
    testCompile org.jmockit:jmockit-coverage:1.23'
}

```

## パラメータの設定値

http://jmockit-ja.nyamikan.net/tutorial/CodeCoverage.html#maven

の値。

## build.gradleへの仕込み方

```groovy
test {
    systemProperty 'coverage-output', 'serial'
    systemProperty 'coverage-outputDir', 'build/reports/jmockit/coverage'
    systemProperty 'coverage-srcDirs', 'src/main/java'
    systemProperty 'coverage-excludes', 'jp.networkprint.core.mock.*, jp.co.sharp.prnsys.mock.*,jp.co.sharp.prnsys.tools.*'
}
```
