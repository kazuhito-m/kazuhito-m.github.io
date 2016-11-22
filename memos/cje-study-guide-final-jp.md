認定Jenkinsエンジニア(CJE) - [認定試験学習ガイド
========================================

## CloudBees社はJenkinsエンジニアに2つの認定を提供します

- [認定Jenkinsエンジニア(CJE)試験は、(オープンソースの)Jenkins知識に関する60の複数選択問題で出題します
- [認定CloudBeesJenkinsエンジニア(CCJPE)試験は、90の問題: 60の(オープンソースの)Jenkins知識に関する問題と、30のCloudBeesのJenkinsプラットフォームに関する問題 を出題します

## イントロダクション

この学習ガイドは、認定Jenkinsエンジニア(CJE)試験のためのものです。
認定CloudBeesJenkinsエンジニア(CCJPE)については[こちら](https://www.cloudbees.com/jenkins/jenkins-certification)を参照ください。

このガイドであなたは、試験の出題トピック、外部参照のリンク、そして例題を得ることができます。

## 構成

試験は、4つの章に集約されます:

1. CI/CD/Jenkinsのコンセプト
0. Jenkinsの使用方法
0. 継続的デリバリー(CD)パイプラインの構築
0. CD-as-codeのベストプラクティス

すべての出題は、Jenkins coreのバージョン `1.625.2` を元にします。
特に指定しない限り、標準的なインストールを行った直後のJenkinsで、プラグインの追加が無い状態を元にします(以下、"base"Jenkins と呼称)。

__NOTE:__ 試験では、ランダムな順序で出題され、セクションはありません。

## プラグイン群

試験は主に,インストールされた"base"Jenkinsについて出題されますが、次のプラグインの知識も必要です。受験者には、これらのプラグインの機能/用途を知ることが期待されますが、詳細な使用法についてはテストされません。


- [Amazon EC2 Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Amazon+EC2+Plugin)
- [Build Pipeline Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Build+Pipeline+Plugin)
- [CloudBees Docker Build and Publish Plugin](https://wiki.jenkins-ci.org/display/JENKINS/CloudBees+Docker+Build+and+Publish+plugin)
- [CloudBees Folders Plugin](https://wiki.jenkins-ci.org/display/JENKINS/CloudBees+Folders+Plugin)
- [Copy Artifact Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Copy+Artifact+Plugin)
- [Credentials Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Credentials+Plugin)
- [Delivery Pipeline Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Delivery+Pipeline+Plugin)
- [Disk Usage Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Disk+Usage+Plugin)
- [Docker Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Docker+Plugin)
- [Email-ext Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Email-ext+Plugin)
-[Fingerprint Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Fingerprint+Plugin)
- [Git Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Git+Plugin)
- [Mailer Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Mailer)
- [IRC Plugin](https://wiki.jenkins-ci.org/display/JENKINS/IRC+Plugin)
- [JUnit Plugin](https://wiki.jenkins-ci.org/display/JENKINS/JUnit+Plugin)
- [Jabber Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Matrix+Project+Plugin)
- [Matrix Project Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Matrix+Project+Plugin)
- [NodeLabel Parameter Plugin](https://wiki.jenkins-ci.org/display/JENKINS/NodeLabel+Parameter+Plugin)
- [Parameterized Trigger Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Parameterized+Trigger+Plugin)
- [Pipeline Plugin (formerly known as Workflow)](https://wiki.jenkins-ci.org/display/JENKINS/Workflow+Plugin)
- [Promoted Builds Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Promoted+Builds+Plugin)
- [Radiator View Plugin](https://wiki.jenkins-ci.org/display/JENKINS/SMS+Notification)
- [SMS Notification Plugin](https://wiki.jenkins-ci.org/display/JENKINS/SMS+Notification)
- [Script Security Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Script+Security+Plugin)
- [Skype Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Skype+Plugin)
