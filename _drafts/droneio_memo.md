最近は「DockerとGOで出来た」という<br/> __[drone.io](https://drone.io/)__ を気に入ってるので、それでやります。

もうすでに

+ アカウント作成済
+ ログイン済

を前提として進めます。

---

## CI準備

まず、画面上部の「New Project」をクリックして下さい。

![NewProject!](images/drone_new.png)

---

## CI準備

次に、今回のプログラムは「github.comに上げてる前提」ですので、
「Repository Setup」から「Github」をクリックして下さい。

![Github!](images/drone_reposelect.png)

---

## CI準備

「github上自分のリポジトリの一覧」が表示されますので、
「今回のプロジェクト」を選び「Select」をクリックして下さい。

![Select!](images/drone_projselect.png)

---

## CI準備

プログラミング言語を聞かれますので「Go」をクリックして下さい。

![Lang!](images/drone_langselect.png)

---

## CI準備

ここまできたら「実行するコマンド」を聞いてくるので
「今回作ったビルドスクリプト」を指定して下さい。

![Script!](images/drone_script.png)

これで「設定」は終了です。<br/>
「Build Now」をクリックして「[一回目のビルド](https://drone.io/github.com/kazuhito-m/go-first-project/1)」を走らせましょう。

![BuildNow!](images/drone_buildnow.png)

---

## CI準備

drone.io ですが、

+ 思ったより設定簡単
+ (実行開始反応＆終わりが)超早い！
+ OSSなので融通効かなければローカルにインストール可

てなところ、気に入りました。

例により「READMEにバッジ貼っとく」とかっこいいかも？

![SuccessBadge!](images/drone_badge.png)
