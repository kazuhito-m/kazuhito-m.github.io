#!/bin/bash

for i in $(seq -w 02 09) ; do
    file_name="2025-06-${i}-diary.md"
    cp ./2025-06-10-diary.md ./${file_name}
    day=$(($i-1))
    sed "s/6日目/${day}日目/g" ./${file_name} > ./${file_name}.tmp
    mv ./${file_name}.tmp ./${file_name}
done
