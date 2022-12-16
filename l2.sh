#!/bin/bash

echo -e "<link rel='canonical' href='${1}' />\n<meta http-equiv='refresh' content='0;${1}'>" | xsel --clipboard --input
