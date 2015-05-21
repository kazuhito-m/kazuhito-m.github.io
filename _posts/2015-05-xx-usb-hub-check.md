---
published: false
layout: post
title: 自分の持ってるUSBハブが「電源操作可能」か否かを確認する
category: tech
tags: [usb,ci,hardware]
---

## 

## 手順

+ USBハブの「電源制御タイプ」を調べる
+ lsusb -v で調べる
+ hub-ctrl をビルド
+ hub-ctrl だけ打ってハブの接続状況を調べる
+ 実際になにかを接続してON/OFFしてみる


## 関係コマンドスクラップ


```
 2033  lsusb -v
 2034  lsusb -v | more
 2035  lsusb -v | grep switching
 2036  sudo lsusb -v | grep switching
 2037  man lsusb
 2038  sudo lsusb -v | grep Bus
 2039  sudo lsusb -v 001:006
 2040  sudo lsusb -v -s 001:006
 2041  sudo lsusb -v -s 001:006 | grep switching
 2043  vi usb-baspower-control.sh 
 2047  sudo lsusb -v -s 001:006 | grep switching
 2053  lsusb
 2054  sudo lsusb -v -s 001:006 | grep switching
 2055  sudo lsusb -v | grep switching
 2145  lsusb -v
 2146  lsusb -vl
 2147  lsusb -E
 2148  lsusb -R
 2149  lsusb -D
 2150  lsusb -t
 2151  lsusb -s
 2152  lsusb -v
 2153  lsusb -t
 2154  lsusb -R
 2155  lsusb -d
 2156  lsusb -v
 2157  lsusb -v | grep Bus
 2158  lsusb -v | grep '^Bus'
 2159  sudo lsusb -v | grep '^Bus'
 2160  sudo lsusb -v | grep '^Bus' | grep 'Hub'
 2161  sudo lsusb -v | grep '^Bus' | grep  -i 'Hub'
 2028  hub-ctrl 
 2044  hub-ctrl -h 1 -P 6 -p 0
 2045  sudo hub-ctrl -h 1 -P 6 -p 0
 2046  sudo hub-ctrl -h 6 -P 1 -p 0
 2048  sudo hub-ctrl -h 1 -P 6 -p 0
 2049  sudo hub-ctrl -h 0 -P 0 -p 0
 2050  sudo hub-ctrl -h 1 -P 1 -p 0
 2051  sudo hub-ctrl -h 2 -P 1 -p 0
 2052  sudo hub-ctrl -h 3 -P 1 -p 0
 2056  sudo hub-ctrl -d 3 -P 1 -p 0
 2057  sudo hub-ctrl -d 3 -p 0
 2058  sudo hub-ctrl -d 1 -p 0
 2059  sudo hub-ctrl -h 1 -d 1 -p 0
 2060  sudo hub-ctrl -h 1 1 -p 0
 2061  sudo hub-ctrl -h 1  -p 0
 2062  sudo hub-ctrl -h 0  -p 0
 2063  sudo hub-ctrl -h 0  -l 0
 2064  sudo hub-ctrl -h 0 -P 3  -l 0
 2065  sudo hub-ctrl -h 0   -l 0
 2066  sudo hub-ctrl -h 1   -l 0
 2067  sudo hub-ctrl -b 1 -d   -l 0
 2068  sudo hub-ctrl -b 1 -d 1  -l 0
 2069  sudo hub-ctrl -b 0 -d 1  -l 0
 2070  sudo hub-ctrl -b 2 -d 1  -l 0
 2071  sudo hub-ctrl -b 2 2  -l 0
 2072  sudo hub-ctrl -b 2  -l 0
 2073  sudo hub-ctrl -b 2 -d 1  -l 0
 2074  sudo hub-ctrl -b 3 -d 1  -l 0
 2075  sudo hub-ctrl -b 4] -d 1  -l 0
 2076  sudo hub-ctrl -b 45 -d 1  -l 0
 2077  sudo hub-ctrl -b 5 -d 1  -l 0
 2078  sudo hub-ctrl -b 6 -d 1  -l 0
 2079  sudo hub-ctrl
 2080  sudo hub-ctrl -b 6 -d 21  -l 0
 2081  sudo hub-ctrl -b 1 -d 21  -l 0
 2082  sudo hub-ctrl -b 1 -d 20  -l 0
 2083  sudo hub-ctrl -b 1 -d 21  -l 0
 2084  sudo hub-ctrl -b 1 -d 21  -p 0
 2085  sudo hub-ctrl -b 1 -d 21 -P 3  -p 0
 2086  sudo hub-ctrl -b 1 -d 21 -P 3  -p 1
 2087  sudo hub-ctrl
 2088  sudo hub-ctrl -b 1 -d 21 -P 3  -p 1
 2089  sudo hub-ctrl
 2090  sudo hub-ctrl -b 1 -d 21 -P 3  -p 1
 2091  sudo hub-ctrl -b 1 -d 24 -P 3  -p 1
 2092  sudo hub-ctrl
 2093  sudo hub-ctrl -b 1 -d 26 -P 3  -p 1
 2094  sudo hub-ctrl -b 1 -d 26 -P 3  -p 0
 2095  sudo hub-ctrl -b 1 -d 26   -p 0
 2096  sudo hub-ctrl -b 1 -d 26   -p 2
 2097  sudo hub-ctrl -b 1 -d 26   -p 3
 2098  sudo hub-ctrl -b 1 -d 26   -p -1
 2099  sudo hub-ctrl -b 1 -d 26   
 2100  sudo hub-ctrl -b 1 -d 26   -p 99999
 2101  sudo hub-ctrl -b 1 -d 26 
 2102  sudo hub-ctrl 
 2103  sudo hub-ctrl 0
 2104  sudo hub-ctrl -h 0
 2105  sudo hub-ctrl -h 0 -p 1
 2106  sudo hub-ctrl -h 0 -p 0
 2107  sudo hub-ctrl -h 0 -P 0 -p 0
 2108  sudo hub-ctrl -h 0 -P 1 -p 0
 2109  sudo hub-ctrl -h 0 -P 2 -p 0
 2110  sudo hub-ctrl -h 0 -P 3 -p 0
 2111  sudo hub-ctrl -h 0 -P 4 -p 0
 2112  sudo hub-ctrl -h 0 -P 45 -p 0
 2113  sudo hub-ctrl -h 0 -P 5 -p 0
 2114  sudo hub-ctrl -h 0 -P 4 -p 0
 2115  sudo hub-ctrl -b 1 -d 26 
 2116  sudo hub-ctrl -b 1 
 2117  sudo hub-ctrl -b 1 -d 26 
 2118  sudo hub-ctrl -b 1 -d 26 -l 0;2~[21;5~;5~;5~;6~;6~;6~;6~
 2119  sudo hub-ctrl -b 1 -d 26 -l 0
 2120  sudo hub-ctrl -b 1 -d 26 -p 0
 2121  sudo hub-ctrl -b 1 -d 26 -p 000000o]
 2122  sudo hub-ctrl -b 1 -d 26 -p 000000o
 2123  sudo hub-ctrl -b 1 -d 26 -p 9999999999999999999999999999999
 2124  sudo hub-ctrl -b 1 -d 26 -p 0000
 2125  sudo hub-ctrl -b 1 -d 26 -l 0000
 2126  sudo hub-ctrl 
 2127  sudo hub-ctrl -N -l 0000
 2128  sudo hub-ctrl -h 0 -l 0000
 2129  sudo hub-ctrl -h 0 -p 0000
 2130  sudo hub-ctrl -h 0 -P 3 -p 0000
 2131  sudo hub-ctrl -h 0 -P 3 -p false
 2132  sudo hub-ctrl -h 0 -P 3 -p a
 2133  sudo hub-ctrl -h 0 -P 3 -p x
 2134* sudo hub-ctrl -h 0  -p x
 2135  sudo hub-ctrl -h 0 -p a
 2136  sudo hub-ctrl -P 1 -p a
 2137  sudo hub-ctrl  -p -
 2138  sudo hub-ctrl  -p 0
 2139  sudo hub-ctrl -P 1 
 2140  sudo hub-ctrl -P 4
 2141  sudo hub-ctrl 
 2142  hub-ctrl 
 2143  sudo hub-ctl
 2144  sudo hub-ctrl
 2162  sudo hub-ctrl
 2163  sudo hub-ctrl -P 4
 2164  sudo hub-ctrl -h
 2165  sudo hub-ctrl -h 0 -p 0
 2166  sudo hub-ctrl -b 4 -d 7 -P 4 -p 0
 2167  sudo hub-ctrl -b 4 -d 7 -P 4 -l 0
 2168  sudo hub-ctrl -b 1 -d 33 -P 4 -l 0
 2169  sudo hub-ctrl -b 1 -d 33 -P 4 -p 0
 2170  sudo hub-ctrl -b 1 -d 33 -P 4 -p 1
 2171  sudo hub-ctrl -b 1 -d 33 -P 4 -p 0
 2172  sudo hub-ctrl -b 1 -d 33 -P 4 -p 2
 2173  sudo hub-ctrl -b 1 -d 33 -P 4 -p 1
 2174  sudo hub-ctrl -b 1 -d 33 -P 4 -p 0
 2175  sudo hub-ctrl -b 1 -d 33 -p 0

```