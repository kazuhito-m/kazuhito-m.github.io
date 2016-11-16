#!/bin/bash

# デーモンモード、常時監視、外からアクセスOK、でJekyllを立ち上げる。
jekyll serve --watch --detach --host 0.0.0.0
