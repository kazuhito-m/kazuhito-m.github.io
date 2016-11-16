#!/bin/bash

# デーモンモード、常時監視、外からアクセスOK、でJekyllを立ち上げる。
jekyll serve --incremental --host 0.0.0.0
# デーモンモードと常時監視は併用できないので、サンプルだけ置いておく。
# jekyll serve --detach --host 0.0.0.0
