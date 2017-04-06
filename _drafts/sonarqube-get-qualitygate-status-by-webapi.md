# SonarqubeからWebAPIにてQualityGateの情報を取得する

※超メモ書き

## ことの発端

https://twitter.com/kazuhito_m/status/847309592233000960

## URLの例

 curl -u jenkins:sniknej0 http://automation.shcloudio.com/api/qualitygates/project_status?projectKey=jp.co.sharp.nwp4b:nwp4b-webui:master > test.txt

## ネタ元

https://docs.sonarqube.org/display/DEV/Web+API

このヘルプから「Sonarqube自体についてるHelpを見てね」って感じの参照になってる。

## 取得サンプル

TODO 「どこがどこにあたるか」の解説を書くこと。

{
    "projectStatus": {
        "conditions": [
            {
                "actualValue": "0",
                "comparator": "GT",
                "errorThreshold": "0",
                "metricKey": "new_vulnerabilities",
                "periodIndex": 1,
                "status": "OK"
            },
            {
                "actualValue": "2",
                "comparator": "GT",
                "errorThreshold": "0",
                "metricKey": "new_bugs",
                "periodIndex": 1,
                "status": "ERROR"
            },
            {
                "actualValue": "2.0770519262981577",
                "comparator": "GT",
                "errorThreshold": "5",
                "metricKey": "new_sqale_debt_ratio",
                "periodIndex": 1,
                "status": "OK"
            },
            {
                "actualValue": "66.31016042780749",
                "comparator": "LT",
                "errorThreshold": "80",
                "metricKey": "new_coverage",
                "periodIndex": 1,
                "status": "ERROR"
            }
        ],
        "periods": [
            {
                "date": "2016-09-08T15:52:00+0900",
                "index": 1,
                "mode": "previous_version"
            }
        ],
        "status": "ERROR"
    }
}

## Groovyのサンプル

def authString = "jenkins:sniknej0".getBytes().encodeBase64().toString()

def url = "http://automation.shcloudio.com/api/qualitygates/project_status?projectKey=jp.co.sharp.nwp4b:nwp4b-webui:master".toURL()
def content = url.getText(useCaches: true, allowUserInteraction: false,
                        requestProperties: ["Authorization": "Basic ${authString}"])

def slurper = new JsonSlurper()
def card = slurper.parseText(content)

for (i in card.projectStatus.conditions) {
    if (i.status == 'ERROR') {
        println("${i.metricKey} : ${i.actualValue} (threshold : ${i.errorThreshold})")
    }
}
