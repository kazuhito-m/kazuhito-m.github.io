---
layout: post
title: HP t5730w Thin Client の設定
category: tech
tags: [windows, thin-client]
---

![全体](/images/2010-08-15-overview.jpg)


日本橋のPC-NETというところで、6,980円で売ってたので、サーバーできんじゃん！と思って購入しました。

動作確認に、HP公式サイトから落とせる「Windows XP Embedded」を入れてみたところ、「い、家にあるすべてのマシンよりUI- 動画サクサクじゃん？」てな感じになったので、「XP運用」できないかと試行錯誤しました。

(おめーん家がしょぼいってことだｒ（ｒｙ)

# 方針

- 既存構成はできるだけ触らない(不自由な点のみロックを外していく、てな要領で)
- USBメモリをHDD替わりにする(Dドライブとして外さない)
- Program Filesとマイドキュメントは、Dドライブに同一構成作って、極力そっちへ持ってくよう努力する運用(人力てｗアホっぽいｗ)

# やること

## 前提

- 以下の物体を用意
  - 本体
  - ディスプレ、マウス、キーボードとかあれやこれや
  - USBメモリ(HDDの代わりで運用します大きさはお好みで(8G以上推奨))
- HP純正「WindowsXPEmbdedd」イメージ　※[ココ](http://h20565.www2.hp.com/portal/site/hpsc/template.PAGE/public/psi/swdDetails/?sp4ts.oid=3634724&spf_p.tpst=psiSwdMain&spf_p.prp_psiSwdMain=wsrp-navigationalState%3Dlang%253Dja%257Ccc%253DJP%257CprodSeriesId%253D3634720%257CprodNameId%253D3634724%257CswEnvOID%253D1058%257CswLang%253D25%257CswItem%253Dvc-80430-1%257Caction%253DdriverDocument&javax.portlet.begCacheTok=com.vignette.cachetoken&javax.portlet.endCacheTok=com.vignette.cachetoken) からダウンロード


## 作業

- ダウンロードしたExeから、USBにOSイメージを書き込む
- USB差して内部SSDにOS書き込む
- Shift押しながら起動。Administrator/Administratorでログイン。
- 右端のタスクトレイから、EWFは「ライトフィルターを無効化」にする。(これでHDに書き込める）
- プログラムの追加と削除から、要らないものをアンインストール（容量削減と管理外のものをおいておきたくないため）
  - Altiris client Agentz
  - HPCA Registration And Loading Facility
  - Symantec Endpoint Protection Firewall
  - Vmware View Client(要る局面はあるかもしれないが、あくまでも「使えるXP端末を作る」なので…)
  - HP device Advice Eagent
  - HP Sygate Security Agent
  - Java(TM) 6 Update 14
- 管理ツールから、UserManagerでログインユーザの整え
  - Kazuhito追加
  - KazuhitoをAddministratorグループへ追加
  - Userを削除
- レジストリエディターから、オートログイン設定を消す。
  - `\HKEY_LOCAL_mACHINE\software\Microsoft\Windows NT\currentViersion\WinLogon\`　らへんから、
　AltDefaultPassword、AltDefaultUserName、AutoAdminLogon、AutoLogonPasswordDefaultPassword、DefaultUserName など、それっぽいのをしこたま削除。
- インストールに使ったUSBをフォーマット、Dドライブとして認識しておく
- 画面解像度の変更など、カスタマイズ
- ログオフ、再起動し、一度自分のユーザでログインしてみる。
- MyDocumentを `d:\` 側に移しておく。
- デスクトップに、マイドキュメント、マイコンピュータ、マイネットワークをよみがえらせてひと段落。これでXPっぽく。
- 実行可能な容量を作る努力
  - レジストリエディタで `Z:\～` になっているものを、 `D:\〜` に変更（USBメモリは用意しておくこと。）
  - コントロールパネルから、「HP RAMディスクマネージャ」により、RAMDIskを最小(２)にする。
  - ※消せるかもしれないが調査不足、メモリを50食って処理しているのと同じだから、返還してあげる。

などすると…「わりかし自由のきくWindows」がこの大きさで！

![スクリーンショット](/images/2010-08-15-screenshot.jpg)

## 既知の不具合(随時更新中)

- AdobiReader入れられず。インストーラでエラーメッセージボックス出してこける。

---

# 小並感

まだ「調べ物をWebで検索する程度」しか使っていませんが、割とサクサク。ニコ動もスイスイ♪

調べるとEmbededdは「その箱用にシェイプして作るWinOS」らしいですね。

で、このThinClient用OS、初っ端じゃ何もインストールできない。

本当にWebとMPlayerとVMWareビューアにだけにしかなりえない「ThinClient」でした。

結構ピュアにDOS-V機っぽいので、USBにCDイメージいれてブート試したら純正XP、2000とかもいけるぽいです。
(他サイトで出来たって人を見た)

ただ、如何なる場合も「ドライバ探し地獄」が時間食いそう…その点HP提供のEmededdは完璧なので、そっち削ったほうが楽だと判断しました。

それに機械さえ手に入ればライセンス言われずにタダでXPを複製し放題…なわけではないでしょうけれどｗ

---

てなことで、今回は「純正からどれだけ時間と手を掛けず使い物にするか」基準でやってます。
(このやり方だと「何個か買って大量生産」という目もある。ほんとは他OSも改造もいろいろあるらしいんですけどね…)

情報によれば、中古市場で大量出回り期は4000円くらいだったらしいので、今のタイミングで7000円は割高なよう。
ただ、「一万円程度でWen- メールそこそこできる省スペース無線端末(Fanレス)が手に入る」と考えれば、ニーズありそうってかそれで十分なヒトに提供できそうです。

たとえば、リビングなどの多人数が居る場所に、テレビをモニターとしてつないどく、って使い方。
Lan引くとか処置をしなくても追加出来るのは価値があるかなと。

コイツは現在、PC欲しがっている従兄弟んとこに就職予定で、入れれるアプリでニーズが合うか模索中です。

…で結局、サーバ用もう一台買ってしまいましたｗ(割高だとあれほど…)

![マシンの感じ](/images/2010-08-15-machine-view.jpg)
