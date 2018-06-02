# TypeScript + WebPack でSourceMapを有効にする

TODO 大まかには描いているが、未完成なので盛る。

https://stackoverflow.com/questions/42088007/is-there-source-map-support-for-typescript-in-node-nodemon

これを元に実践。

## npmで「サポートライブラリ」のインストール

```bash
npm install --save-dev source-map-support
```

## エントリポイントになるtsファイルに以下のコードを追加

```bash
// Support source map.
require('source-map-support').install()
process.on('unhandledRejection', console.log);
```

## tsconfig.json に設定を足す

```json
"compilerOptions": {
  // なんかなんか
  "inlineSourceMap": true,
  // なんかなんか
}
```

その場合、

```json
"sourceMap": true,
```

があると「競合してトランスパイルエラー」になるので、コメントアウトする。
