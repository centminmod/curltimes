# curltimes.sh

curl measurement tool for HTTPS connection times using shell script modified from https://nooshu.github.io/blog/2020/07/30/measuring-tls-13-ipv4-ipv6-performance/

# Usage

```
./curltimes.sh 
Usage:

TLS 1.2 max tests
./curltimes.sh json https://domain.com
./curltimes.sh csv https://domain.com

TLS 1.3 max tests
./curltimes.sh json-max https://domain.com
./curltimes.sh csv-max https://domain.com

CSV Summary
./curltimes.sh csv-sum https://domain.com
./curltimes.sh csv-max-sum https://domain.com
```

# Examples

json output with TLS 1.2 max

```
./curltimes.sh json https://servermanager.guide           
curl 7.72.0-DEV
TLSv1.2 ECDHE-ECDSA-AES128-GCM-SHA256
HTTP/2

DNS,Connect,SSL,Wait,TTFB,Total Time
{
        "time_dns":             0.002422,
        "time_connect":         0.011075,
        "time_appconnect":      0.037738,
        "time_pretransfer":     0.037818,
        "time_ttfb":            0.066576,
        "time_total":           0.075463
}{
        "time_dns":             0.002405,
        "time_connect":         0.011040,
        "time_appconnect":      0.036889,
        "time_pretransfer":     0.036979,
        "time_ttfb":            0.062917,
        "time_total":           0.071707
}{
        "time_dns":             0.002419,
        "time_connect":         0.011103,
        "time_appconnect":      0.037449,
        "time_pretransfer":     0.037537,
        "time_ttfb":            0.077559,
        "time_total":           0.086323
}
```

json output with TLS 1.3 max

```
./curltimes.sh json-max https://servermanager.guide
curl 7.72.0-DEV
TLSv1.3 TLS_AES_128_GCM_SHA256
HTTP/2

DNS,Connect,SSL,Wait,TTFB,Total Time
{
        "time_dns":             0.002371,
        "time_connect":         0.011003,
        "time_appconnect":      0.029769,
        "time_pretransfer":     0.029851,
        "time_ttfb":            0.058034,
        "time_total":           0.066434
}{
        "time_dns":             0.002547,
        "time_connect":         0.011222,
        "time_appconnect":      0.027047,
        "time_pretransfer":     0.027129,
        "time_ttfb":            0.048005,
        "time_total":           0.056814
}{
        "time_dns":             0.002328,
        "time_connect":         0.010971,
        "time_appconnect":      0.027406,
        "time_pretransfer":     0.027505,
        "time_ttfb":            0.055860,
        "time_total":           0.064627
}
```

csv output with TLS 1.2 max

```
./curltimes.sh csv https://servermanager.guide
curl 7.72.0-DEV
TLSv1.2 ECDHE-ECDSA-AES128-GCM-SHA256
HTTP/2

DNS,Connect,SSL,Wait,TTFB,Total Time
0.002524,0.011214,0.040481,0.040569,0.102032,0.127001
0.002651,0.011348,0.040178,0.040259,0.065384,0.074475
0.002459,0.011078,0.040125,0.040211,0.073195,0.082045
```

csv output with TLS 1.3 max

```
./curltimes.sh csv-max https://servermanager.guide
curl 7.72.0-DEV
TLSv1.3 TLS_AES_128_GCM_SHA256
HTTP/2

DNS,Connect,SSL,Wait,TTFB,Total Time
0.002098,0.01077,0.029399,0.029482,0.060401,0.073367
0.002485,0.011123,0.028515,0.028597,0.058941,0.067204
0.002447,0.011171,0.031736,0.03182,0.057653,0.065577
```

# process metrics

Using datamash to provide summary metrics for all recorded data points

csv-sum output with TLS 1.2 max

```
./curltimes.sh csv-sum https://servermanager.guide
curl 7.72.0-DEV
TLSv1.2 ECDHE-ECDSA-AES128-GCM-SHA256
HTTP/2

0.002315,0.010956,0.037552,0.037639,0.06778,0.076984
0.002311,0.011048,0.042034,0.042121,0.069648,0.078221
0.015701,0.0244,0.066002,0.066087,0.096001,0.106978

time_dns 
  avg: 0.006776 
  min: 0.002311 
  max: 0.015701 
  75%: 0.009008 
  95%: 0.014362 
  99%: 0.015433
time_connect 
  avg: 0.015468 
  min: 0.010956 
  max: 0.024400 
  75%: 0.017724 
  95%: 0.023065 
  99%: 0.024133
time_appconnect 
  avg: 0.048529 
  min: 0.037552 
  max: 0.066002 
  75%: 0.054018 
  95%: 0.063605 
  99%: 0.065523
time_pretransfer 
  avg: 0.048616 
  min: 0.037639 
  max: 0.066087 
  75%: 0.054104 
  95%: 0.063690 
  99%: 0.065608
time_ttfb 
  avg: 0.077810 
  min: 0.067780 
  max: 0.096001 
  75%: 0.082825 
  95%: 0.093366 
  99%: 0.095474
time_total 
  avg: 0.087394 
  min: 0.076984 
  max: 0.106978 
  75%: 0.092600 
  95%: 0.104102 
  99%: 0.106403

time_dns
avg:,min:,max:,75%:,95%:,99%:
0.006776,0.002311,0.015701,0.009008,0.014362,0.015433
time_connect
avg:,min:,max:,75%:,95%:,99%:
0.015468,0.010956,0.024400,0.017724,0.023065,0.024133
time_appconnect
avg:,min:,max:,75%:,95%:,99%:
0.048529,0.037552,0.066002,0.054018,0.063605,0.065523
time_pretransfer
avg:,min:,max:,75%:,95%:,99%:
0.048616,0.037639,0.066087,0.054104,0.063690,0.065608
time_ttfb
avg:,min:,max:,75%:,95%:,99%:
0.077810,0.067780,0.096001,0.082825,0.093366,0.095474
time_total
avg:,min:,max:,75%:,95%:,99%:
0.087394,0.076984,0.106978,0.092600,0.104102,0.106403
```

csv-max-sum output with TLS 1.3 max

```
./curltimes.sh csv-max-sum https://servermanager.guide
curl 7.72.0-DEV
TLSv1.3 TLS_AES_128_GCM_SHA256
HTTP/2

0.002405,0.011041,0.035875,0.035957,0.066131,0.075692
0.002412,0.011058,0.030105,0.030197,0.060418,0.073778
0.002306,0.01102,0.026925,0.02702,0.052142,0.064863

time_dns 
  avg: 0.002374 
  min: 0.002306 
  max: 0.002412 
  75%: 0.002408 
  95%: 0.002411 
  99%: 0.002412
time_connect 
  avg: 0.011040 
  min: 0.011020 
  max: 0.011058 
  75%: 0.011049 
  95%: 0.011056 
  99%: 0.011058
time_appconnect 
  avg: 0.030968 
  min: 0.026925 
  max: 0.035875 
  75%: 0.032990 
  95%: 0.035298 
  99%: 0.035760
time_pretransfer 
  avg: 0.031058 
  min: 0.027020 
  max: 0.035957 
  75%: 0.033077 
  95%: 0.035381 
  99%: 0.035842
time_ttfb 
  avg: 0.059564 
  min: 0.052142 
  max: 0.066131 
  75%: 0.063275 
  95%: 0.065560 
  99%: 0.066017
time_total 
  avg: 0.071444 
  min: 0.064863 
  max: 0.075692 
  75%: 0.074735 
  95%: 0.075501 
  99%: 0.075654

time_dns
avg:,min:,max:,75%:,95%:,99%:
0.002374,0.002306,0.002412,0.002408,0.002411,0.002412
time_connect
avg:,min:,max:,75%:,95%:,99%:
0.011040,0.011020,0.011058,0.011049,0.011056,0.011058
time_appconnect
avg:,min:,max:,75%:,95%:,99%:
0.030968,0.026925,0.035875,0.032990,0.035298,0.035760
time_pretransfer
avg:,min:,max:,75%:,95%:,99%:
0.031058,0.027020,0.035957,0.033077,0.035381,0.035842
time_ttfb
avg:,min:,max:,75%:,95%:,99%:
0.059564,0.052142,0.066131,0.063275,0.065560,0.066017
time_total
avg:,min:,max:,75%:,95%:,99%:
0.071444,0.064863,0.075692,0.074735,0.075501,0.075654
```

## TLS 1.2 vs TLS 1.3 for 11 run diff compare

```
domain=servermanager.guide
time diff -u <(./curltimes.sh csv-sum https://$domain) <(./curltimes.sh csv-max-sum https://$domain)
```

```
domain=servermanager.guide
diff -u <(./curltimes.sh csv-sum https://$domain) <(./curltimes.sh csv-max-sum https://$domain)
--- /dev/fd/63  2020-08-01 21:19:51.010395958 +0000
+++ /dev/fd/62  2020-08-01 21:19:51.011395968 +0000
@@ -1,77 +1,77 @@
 curl 7.72.0-DEV
-TLSv1.2 ECDHE-ECDSA-AES128-GCM-SHA256
+TLSv1.3 TLS_AES_128_GCM_SHA256
 HTTP/2
 
-0.00237,0.011125,0.037012,0.037103,0.061725,0.070765
-0.002503,0.011136,0.038038,0.038128,0.060462,0.070243
-0.002543,0.011243,0.036945,0.037019,0.06703,0.076257
-0.002462,0.011155,0.037213,0.037285,0.069505,0.078143
-0.015448,0.026449,0.059612,0.059696,0.105141,0.116067
-0.002538,0.011137,0.035759,0.035843,0.059058,0.069601
-0.002056,0.010733,0.038901,0.038979,0.064176,0.073542
-0.002497,0.01111,0.036486,0.036572,0.068528,0.077868
-0.002396,0.011067,0.037696,0.037778,0.065563,0.074434
-0.002418,0.011045,0.038121,0.038203,0.070897,0.079936
-0.002438,0.011049,0.036886,0.03697,0.06365,0.072377
+0.002452,0.011106,0.027264,0.02734,0.066168,0.077371
+0.002414,0.011294,0.027352,0.027417,0.049273,0.058015
+0.002359,0.010955,0.027347,0.027429,0.070568,0.07968
+0.002412,0.011019,0.026862,0.026945,0.049622,0.057958
+0.002373,0.010996,0.027983,0.028067,0.053743,0.062063
+0.002119,0.010734,0.035691,0.035771,0.068799,0.077473
+0.002551,0.011204,0.031297,0.031381,0.062949,0.075992
+0.002444,0.01107,0.027745,0.027835,0.054238,0.064203
+0.002347,0.010975,0.026498,0.026579,0.05207,0.061666
+0.002485,0.011162,0.028682,0.028766,0.055345,0.06351
+0.002411,0.013478,0.031998,0.032093,0.059033,0.068191
 
 time_dns 
-  avg: 0.003606 
-  min: 0.002056 
-  max: 0.015448 
-  75%: 0.002520 
-  95%: 0.008996 
-  99%: 0.014157
+  avg: 0.002397 
+  min: 0.002119 
+  max: 0.002551 
+  75%: 0.002448 
+  95%: 0.002518 
+  99%: 0.002544
 time_connect 
-  avg: 0.012477 
-  min: 0.010733 
-  max: 0.026449 
-  75%: 0.011146 
-  95%: 0.018846 
-  99%: 0.024928
+  avg: 0.011272 
+  min: 0.010734 
+  max: 0.013478 
+  75%: 0.011183 
+  95%: 0.012386 
+  99%: 0.013260
 time_appconnect 
-  avg: 0.039334 
-  min: 0.035759 
-  max: 0.059612 
-  75%: 0.038079 
-  95%: 0.049257 
-  99%: 0.057541
+  avg: 0.028974 
+  min: 0.026498 
+  max: 0.035691 
+  75%: 0.029989 
+  95%: 0.033845 
+  99%: 0.035322
 time_pretransfer 
-  avg: 0.039416 
-  min: 0.035843 
-  max: 0.059696 
-  75%: 0.038165 
-  95%: 0.049338 
-  99%: 0.057624
+  avg: 0.029057 
+  min: 0.026579 
+  max: 0.035771 
+  75%: 0.030074 
+  95%: 0.033932 
+  99%: 0.035403
 time_ttfb 
-  avg: 0.068703 
-  min: 0.059058 
-  max: 0.105141 
-  75%: 0.069017 
-  95%: 0.088019 
-  99%: 0.101717
+  avg: 0.058346 
+  min: 0.049273 
+  max: 0.070568 
+  75%: 0.064558 
+  95%: 0.069683 
+  99%: 0.070391
 time_total 
-  avg: 0.078112 
-  min: 0.069601 
-  max: 0.116067 
-  75%: 0.078006 
-  95%: 0.098002 
-  99%: 0.112454
+  avg: 0.067829 
+  min: 0.057958 
+  max: 0.079680 
+  75%: 0.076682 
+  95%: 0.078576 
+  99%: 0.079459
 
 time_dns
 avg:,min:,max:,75%:,95%:,99%:
-0.003606,0.002056,0.015448,0.002520,0.008996,0.014157
+0.002397,0.002119,0.002551,0.002448,0.002518,0.002544
 time_connect
 avg:,min:,max:,75%:,95%:,99%:
-0.012477,0.010733,0.026449,0.011146,0.018846,0.024928
+0.011272,0.010734,0.013478,0.011183,0.012386,0.013260
 time_appconnect
 avg:,min:,max:,75%:,95%:,99%:
-0.039334,0.035759,0.059612,0.038079,0.049257,0.057541
+0.028974,0.026498,0.035691,0.029989,0.033845,0.035322
 time_pretransfer
 avg:,min:,max:,75%:,95%:,99%:
-0.039416,0.035843,0.059696,0.038165,0.049338,0.057624
+0.029057,0.026579,0.035771,0.030074,0.033932,0.035403
 time_ttfb
 avg:,min:,max:,75%:,95%:,99%:
-0.068703,0.059058,0.105141,0.069017,0.088019,0.101717
+0.058346,0.049273,0.070568,0.064558,0.069683,0.070391
 time_total
 avg:,min:,max:,75%:,95%:,99%:
-0.078112,0.069601,0.116067,0.078006,0.098002,0.112454
+0.067829,0.057958,0.079680,0.076682,0.078576,0.079459
```

# curl HTTP/3 support

`curltimes.sh` script can optionally support curl HTTP/3 tests if you change script's `bin=` and `bin_http3` variables to match the path for your custom curl version binary built with HTTP/3 support as outlined at https://github.com/curl/curl/blob/master/docs/HTTP3.md. However, as curl HTTP/3 requests are done over QUIC and not TLS, you won't be testing TLSv1.2 or TLSv1.3 but HTTP/3 over QUIC.

Then change script variables `http3='n'` to `http3='y'` and change the curl HTTP/3 binary's library path variable `library_path_http3` to where you installed it for custom curl HTTP/3 binary

```
bin='/usr/local/src/curl/src/curl'
bin_http3='/usr/local/src/curl/src/curl'
http3='y'
library_path_http3='/usr/lib/x86_64-linux-gnu'
```

Then running `csv-max-sum` option would display curl HTTP/3 binary timings but there is no TLS protocol info due to [HTTP/3 over QUIC and not TLS](https://github.com/curl/curl/issues/5763) and `time_appconnect` timings are not available right now resulting in zero values with curl HTTP/3 requests. See issue [here](https://github.com/curl/curl/issues/4516) (seems `time_connect` is now available since that issue was created).

```
./curltimes.sh csv-max-sum https://servermanager.guide                                                                 
curl 7.72.0-DEV
HTTP/3

0.002384,0.017785,0,0.017849,0.042407,0.055939
0.002384,0.017119,0,0.017182,0.044635,0.058338
0.002049,0.015824,0,0.015888,0.047756,0.057552

time_dns 
  avg: 0.002272 
  min: 0.002049 
  max: 0.002384 
  75%: 0.002384 
  95%: 0.002384 
  99%: 0.002384
time_connect 
  avg: 0.016909 
  min: 0.015824 
  max: 0.017785 
  75%: 0.017452 
  95%: 0.017718 
  99%: 0.017772
time_appconnect 
  avg: 0.000000 
  min: 0.000000 
  max: 0.000000 
  75%: 0.000000 
  95%: 0.000000 
  99%: 0.000000
time_pretransfer 
  avg: 0.016973 
  min: 0.015888 
  max: 0.017849 
  75%: 0.017516 
  95%: 0.017782 
  99%: 0.017836
time_ttfb 
  avg: 0.044933 
  min: 0.042407 
  max: 0.047756 
  75%: 0.046196 
  95%: 0.047444 
  99%: 0.047694
time_total 
  avg: 0.057276 
  min: 0.055939 
  max: 0.058338 
  75%: 0.057945 
  95%: 0.058259 
  99%: 0.058322

time_dns
avg:,min:,max:,75%:,95%:,99%:
0.002272,0.002049,0.002384,0.002384,0.002384,0.002384
time_connect
avg:,min:,max:,75%:,95%:,99%:
0.016909,0.015824,0.017785,0.017452,0.017718,0.017772
time_appconnect
avg:,min:,max:,75%:,95%:,99%:
0.000000,0.000000,0.000000,0.000000,0.000000,0.000000
time_pretransfer
avg:,min:,max:,75%:,95%:,99%:
0.016973,0.015888,0.017849,0.017516,0.017782,0.017836
time_ttfb
avg:,min:,max:,75%:,95%:,99%:
0.044933,0.042407,0.047756,0.046196,0.047444,0.047694
time_total
avg:,min:,max:,75%:,95%:,99%:
0.057276,0.055939,0.058338,0.057945,0.058259,0.058322
```

# Compare curl HTTP/3 over QUIC vs HTTP/2 over TLSv1.3

```
bin='/usr/local/src/curl/src/curl'
bin_http3='/usr/local/src/curl/src/curl'
http3='n'
library_path_http3='/usr/lib/x86_64-linux-gnu'

./curltimes.sh csv-max-sum https://servermanager.guide > curl-http2-tls13.txt
```
```
bin='/usr/local/src/curl/src/curl'
bin_http3='/usr/local/src/curl/src/curl'
http3='y'
library_path_http3='/usr/lib/x86_64-linux-gnu'

./curltimes.sh csv-max-sum https://servermanager.guide > curl-http3-quic.txt
```
```
diff -u curl-http2-tls13.txt curl-http3-quic.txt 
--- curl-http2-tls13.txt        2020-08-02 09:34:22.658795999 +0000
+++ curl-http3-quic.txt 2020-08-02 09:35:16.755198249 +0000
@@ -1,69 +1,68 @@
 curl 7.72.0-DEV
-TLSv1.3 TLS_AES_128_GCM_SHA256
-HTTP/2
+HTTP/3
 
-0.00239,0.010993,0.027147,0.027239,0.057875,0.065862
-0.015027,0.023696,0.042946,0.04303,0.066377,0.074394
-0.00238,0.011003,0.027314,0.027405,0.053248,0.061596
+0.002434,0.01516,0,0.015222,0.040546,0.051306
+0.002323,0.014469,0,0.014533,0.038494,0.049085
+0.002309,0.014513,0,0.014578,0.045224,0.055952
 
 time_dns 
-  avg: 0.006599 
-  min: 0.002380 
-  max: 0.015027 
-  75%: 0.008709 
-  95%: 0.013763 
-  99%: 0.014774
+  avg: 0.002355 
+  min: 0.002309 
+  max: 0.002434 
+  75%: 0.002379 
+  95%: 0.002423 
+  99%: 0.002432
 time_connect 
-  avg: 0.015231 
-  min: 0.010993 
-  max: 0.023696 
-  75%: 0.017349 
-  95%: 0.022427 
-  99%: 0.023442
+  avg: 0.014714 
+  min: 0.014469 
+  max: 0.015160 
+  75%: 0.014836 
+  95%: 0.015095 
+  99%: 0.015147
 time_appconnect 
-  avg: 0.032469 
-  min: 0.027147 
-  max: 0.042946 
-  75%: 0.035130 
-  95%: 0.041383 
-  99%: 0.042633
+  avg: 0.000000 
+  min: 0.000000 
+  max: 0.000000 
+  75%: 0.000000 
+  95%: 0.000000 
+  99%: 0.000000
 time_pretransfer 
-  avg: 0.032558 
-  min: 0.027239 
-  max: 0.043030 
-  75%: 0.035218 
-  95%: 0.041467 
-  99%: 0.042718
+  avg: 0.014778 
+  min: 0.014533 
+  max: 0.015222 
+  75%: 0.014900 
+  95%: 0.015158 
+  99%: 0.015209
 time_ttfb 
-  avg: 0.059167 
-  min: 0.053248 
-  max: 0.066377 
-  75%: 0.062126 
-  95%: 0.065527 
-  99%: 0.066207
+  avg: 0.041421 
+  min: 0.038494 
+  max: 0.045224 
+  75%: 0.042885 
+  95%: 0.044756 
+  99%: 0.045130
 time_total 
-  avg: 0.067284 
-  min: 0.061596 
-  max: 0.074394 
-  75%: 0.070128 
-  95%: 0.073541 
-  99%: 0.074223
+  avg: 0.052114 
+  min: 0.049085 
+  max: 0.055952 
+  75%: 0.053629 
+  95%: 0.055487 
+  99%: 0.055859
 
 time_dns
 avg:,min:,max:,75%:,95%:,99%:
-0.006599,0.002380,0.015027,0.008709,0.013763,0.014774
+0.002355,0.002309,0.002434,0.002379,0.002423,0.002432
 time_connect
 avg:,min:,max:,75%:,95%:,99%:
-0.015231,0.010993,0.023696,0.017349,0.022427,0.023442
+0.014714,0.014469,0.015160,0.014836,0.015095,0.015147
 time_appconnect
 avg:,min:,max:,75%:,95%:,99%:
-0.032469,0.027147,0.042946,0.035130,0.041383,0.042633
+0.000000,0.000000,0.000000,0.000000,0.000000,0.000000
 time_pretransfer
 avg:,min:,max:,75%:,95%:,99%:
-0.032558,0.027239,0.043030,0.035218,0.041467,0.042718
+0.014778,0.014533,0.015222,0.014900,0.015158,0.015209
 time_ttfb
 avg:,min:,max:,75%:,95%:,99%:
-0.059167,0.053248,0.066377,0.062126,0.065527,0.066207
+0.041421,0.038494,0.045224,0.042885,0.044756,0.045130
 time_total
 avg:,min:,max:,75%:,95%:,99%:
-0.067284,0.061596,0.074394,0.070128,0.073541,0.074223
+0.052114,0.049085,0.055952,0.053629,0.055487,0.055859
```