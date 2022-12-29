#!/bin/bash

# 「このスクリプトがある場所」まで移動
SCRIPT_DIR=$(cd $(dirname $(readlink -f $0 || echo $0));pwd -P)
cd ${SCRIPT_DIR}

# 既発性のディレクトリ消す。
rm -rf ./_site
rm -rf ./vender
rm -f ./Gemfile.lock

# Gemのインストールだけ終わらせる
bundle update

# デーモンモード、常時監視、外からアクセスOK、でJekyllを立ち上げる。
jekyll serve --incremental --host 0.0.0.0

# デーモンモードと常時監視は併用できないので、サンプルだけ置いておく。
# jekyll serve --detach --host 0.0.0.0

# 既発性のディレクトリ消す。
rm -rf ./_site
