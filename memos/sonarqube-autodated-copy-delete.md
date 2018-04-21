# SonarQubeで「古いルールセット」をBuilt−Inに変更、Outedetedを削除する方法。

SonarQubeをUpdateすると

- 品質プロファイル
- Quority Gate

に

`(outdated copy)` とついたものが出現する。

これは「新しいもの」に変更し、削除したい。

## やること

https://stackoverflow.com/questions/49140976/sonarqube-how-remove-the-outdated-copy-message-from-a-quality-profile

の通りにする。

「デフォルト」をはずせば、歯車マークから「削除」が選択できるように成るので、それで変更する。
