# curltimes.sh

curl measurement tool for HTTPS connection times using shell script modified from https://nooshu.github.io/blog/2020/07/30/measuring-tls-13-ipv4-ipv6-performance/

* [Usage](https://github.com/centminmod/curltimes#usage)
* [Examples](https://github.com/centminmod/curltimes#examples)
* [Process Metrics](https://github.com/centminmod/curltimes#process-metrics)
* [TLS 1.2 vs TLS 1.3 diff compare](https://github.com/centminmod/curltimes#tls-12-vs-tls-13-for-11-run-diff-compare)
* [curl HTTP/3 support](https://github.com/centminmod/curltimes#curl-http3-support)
* [Compare curl HTTP/3 over QUIC vs HTTP/2 over TLSv1.3](https://github.com/centminmod/curltimes#compare-curl-http3-over-quic-vs-http2-over-tlsv13)
* [Compare Mode](https://github.com/centminmod/curltimes#compare-mode)
* [curl resolve mode](https://github.com/centminmod/curltimes#curl-resolve-mode)

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

TLSv1.2 vs TLSv1.3 Compare
./curltimes.sh compare https://domain.com
```

# Examples

json output with TLS 1.2 max

```
./curltimes.sh json https://servermanager.guide
curl 7.72.0-DEV
TLSv1.2 ECDHE-ECDSA-AES128-GCM-SHA256
HTTP/2
Connected to servermanager.guide (2606:4700:10::6816:42fa) port 443 (#0)
Sample Size: 3

DNS,Connect,SSL,Wait,TTFB,Total Time
{
        "time_dns":             0.002439,
        "time_connect":         0.011056,
        "time_appconnect":      0.035863,
        "time_pretransfer":     0.035944,
        "time_ttfb":            0.062574,
        "time_total":           0.073078
}{
        "time_dns":             0.014376,
        "time_connect":         0.023067,
        "time_appconnect":      0.048261,
        "time_pretransfer":     0.048351,
        "time_ttfb":            0.072806,
        "time_total":           0.081537
}{
        "time_dns":             0.002416,
        "time_connect":         0.011125,
        "time_appconnect":      0.038530,
        "time_pretransfer":     0.038625,
        "time_ttfb":            0.068724,
        "time_total":           0.077622
}
```

json output with TLS 1.3 max

```
./curltimes.sh json-max https://servermanager.guide
curl 7.72.0-DEV
TLSv1.3 TLS_AES_128_GCM_SHA256
HTTP/2
Connected to servermanager.guide (2606:4700:10::6816:42fa) port 443 (#0)
Sample Size: 3

DNS,Connect,SSL,Wait,TTFB,Total Time
{
        "time_dns":             0.002503,
        "time_connect":         0.011196,
        "time_appconnect":      0.028570,
        "time_pretransfer":     0.028659,
        "time_ttfb":            0.059981,
        "time_total":           0.068726
}{
        "time_dns":             0.002414,
        "time_connect":         0.011099,
        "time_appconnect":      0.029590,
        "time_pretransfer":     0.029678,
        "time_ttfb":            0.055797,
        "time_total":           0.066787
}{
        "time_dns":             0.002438,
        "time_connect":         0.011156,
        "time_appconnect":      0.026949,
        "time_pretransfer":     0.027040,
        "time_ttfb":            0.055696,
        "time_total":           0.064554
}
```

csv output with TLS 1.2 max

```
./curltimes.sh csv https://servermanager.guide
curl 7.72.0-DEV
TLSv1.2 ECDHE-ECDSA-AES128-GCM-SHA256
HTTP/2
Connected to servermanager.guide (2606:4700:10::ac43:26be) port 443 (#0)
Sample Size: 3

DNS,Connect,SSL,Wait,TTFB,Total Time
0.002464,0.013496,0.045009,0.045091,0.078059,0.089155
0.002349,0.010987,0.038559,0.038653,0.080786,0.089689
0.002411,0.013445,0.044758,0.04484,0.07613,0.087181
```

csv output with TLS 1.3 max

```
./curltimes.sh csv-max https://servermanager.guide
curl 7.72.0-DEV
TLSv1.3 TLS_AES_128_GCM_SHA256
HTTP/2
Connected to servermanager.guide (2606:4700:10::ac43:26be) port 443 (#0)
Sample Size: 3

DNS,Connect,SSL,Wait,TTFB,Total Time
0.002368,0.011004,0.032605,0.032687,0.069083,0.078063
0.002417,0.011137,0.029379,0.029465,0.071944,0.081752
0.002351,0.013413,0.034949,0.03503,0.073061,0.084205
```

# process metrics

Using datamash to provide summary metrics for all recorded data points

csv-sum output with TLS 1.2 max

```
./curltimes.sh csv-sum https://servermanager.guide
curl 7.72.0-DEV
TLSv1.2 ECDHE-ECDSA-AES128-GCM-SHA256
HTTP/2
Connected to servermanager.guide (2606:4700:10::6816:42fa) port 443 (#0)
Sample Size: 3

0.015257,0.023983,0.049285,0.049374,0.071656,0.080435
0.002349,0.01104,0.036542,0.036626,0.062205,0.07452
0.002402,0.011086,0.037044,0.037124,0.0672,0.078116

time_dns 
  avg:    0.006669 
  median: 0.002402 
  min:    0.002349 
  max:    0.015257 
  75%:    0.008830 
  95%:    0.013972 
  99%:    0.015000
time_connect 
  avg:    0.015370 
  median: 0.011086 
  min:    0.011040 
  max:    0.023983 
  75%:    0.017535 
  95%:    0.022693 
  99%:    0.023725
time_appconnect 
  avg:    0.040957 
  median: 0.037044 
  min:    0.036542 
  max:    0.049285 
  75%:    0.043165 
  95%:    0.048061 
  99%:    0.049040
time_pretransfer 
  avg:    0.041041 
  median: 0.037124 
  min:    0.036626 
  max:    0.049374 
  75%:    0.043249 
  95%:    0.048149 
  99%:    0.049129
time_ttfb 
  avg:    0.067020 
  median: 0.067200 
  min:    0.062205 
  max:    0.071656 
  75%:    0.069428 
  95%:    0.071210 
  99%:    0.071567
time_total 
  avg:    0.077690 
  median: 0.078116 
  min:    0.074520 
  max:    0.080435 
  75%:    0.079275 
  95%:    0.080203 
  99%:    0.080389

time_dns
avg:,median:,min:,max:,75%:,95%:,99%:
0.006669,0.002402,0.002349,0.015257,0.008830,0.013972,0.015000
time_connect
avg:,median:,min:,max:,75%:,95%:,99%:
0.015370,0.011086,0.011040,0.023983,0.017535,0.022693,0.023725
time_appconnect
avg:,median:,min:,max:,75%:,95%:,99%:
0.040957,0.037044,0.036542,0.049285,0.043165,0.048061,0.049040
time_pretransfer
avg:,median:,min:,max:,75%:,95%:,99%:
0.041041,0.037124,0.036626,0.049374,0.043249,0.048149,0.049129
time_ttfb
avg:,median:,min:,max:,75%:,95%:,99%:
0.067020,0.067200,0.062205,0.071656,0.069428,0.071210,0.071567
time_total
avg:,median:,min:,max:,75%:,95%:,99%:
0.077690,0.078116,0.074520,0.080435,0.079275,0.080203,0.080389
```

csv-max-sum output with TLS 1.3 max

```
./curltimes.sh csv-max-sum https://servermanager.guide
curl 7.72.0-DEV
TLSv1.3 TLS_AES_128_GCM_SHA256
HTTP/2
Connected to servermanager.guide (2606:4700:10::6816:43fa) port 443 (#0)
Sample Size: 3

0.002545,0.011174,0.029505,0.029594,0.055961,0.06396
0.002442,0.01114,0.036338,0.036424,0.068599,0.077132
0.002426,0.011046,0.027465,0.027547,0.060354,0.067771

time_dns 
  avg:    0.002471 
  median: 0.002442 
  min:    0.002426 
  max:    0.002545 
  75%:    0.002493 
  95%:    0.002535 
  99%:    0.002543
time_connect 
  avg:    0.011120 
  median: 0.011140 
  min:    0.011046 
  max:    0.011174 
  75%:    0.011157 
  95%:    0.011171 
  99%:    0.011173
time_appconnect 
  avg:    0.031103 
  median: 0.029505 
  min:    0.027465 
  max:    0.036338 
  75%:    0.032921 
  95%:    0.035655 
  99%:    0.036201
time_pretransfer 
  avg:    0.031188 
  median: 0.029594 
  min:    0.027547 
  max:    0.036424 
  75%:    0.033009 
  95%:    0.035741 
  99%:    0.036287
time_ttfb 
  avg:    0.061638 
  median: 0.060354 
  min:    0.055961 
  max:    0.068599 
  75%:    0.064476 
  95%:    0.067775 
  99%:    0.068434
time_total 
  avg:    0.069621 
  median: 0.067771 
  min:    0.063960 
  max:    0.077132 
  75%:    0.072451 
  95%:    0.076196 
  99%:    0.076945

time_dns
avg:,median:,min:,max:,75%:,95%:,99%:
0.002471,0.002442,0.002426,0.002545,0.002493,0.002535,0.002543
time_connect
avg:,median:,min:,max:,75%:,95%:,99%:
0.011120,0.011140,0.011046,0.011174,0.011157,0.011171,0.011173
time_appconnect
avg:,median:,min:,max:,75%:,95%:,99%:
0.031103,0.029505,0.027465,0.036338,0.032921,0.035655,0.036201
time_pretransfer
avg:,median:,min:,max:,75%:,95%:,99%:
0.031188,0.029594,0.027547,0.036424,0.033009,0.035741,0.036287
time_ttfb
avg:,median:,min:,max:,75%:,95%:,99%:
0.061638,0.060354,0.055961,0.068599,0.064476,0.067775,0.068434
time_total
avg:,median:,min:,max:,75%:,95%:,99%:
0.069621,0.067771,0.063960,0.077132,0.072451,0.076196,0.076945
```

## TLS 1.2 vs TLS 1.3 diff compare

```
domain=servermanager.guide
time diff -u <(./curltimes.sh csv-sum https://$domain) <(./curltimes.sh csv-max-sum https://$domain)
```

```
domain=servermanager.guide
time diff -u <(./curltimes.sh csv-sum https://$domain) <(./curltimes.sh csv-max-sum https://$domain)
--- /dev/fd/63  2020-08-03 11:40:44.747487856 +0000
+++ /dev/fd/62  2020-08-03 11:40:44.747487856 +0000
@@ -1,77 +1,77 @@
 curl 7.72.0-DEV
-TLSv1.2 ECDHE-ECDSA-AES128-GCM-SHA256
+TLSv1.3 TLS_AES_128_GCM_SHA256
 HTTP/2
 Connected to servermanager.guide (2606:4700:10::6816:43fa) port 443 (#0)
 Sample Size: 3
 
-0.002346,0.01103,0.035427,0.035503,0.060286,0.069271
-0.002479,0.011148,0.037028,0.0371,0.079237,0.088524
-0.002359,0.010994,0.03724,0.037317,0.068266,0.085086
+0.002381,0.011015,0.031037,0.031123,0.054617,0.063293
+0.002451,0.011154,0.030285,0.030374,0.058021,0.066109
+0.002392,0.011041,0.027912,0.027996,0.05965,0.067558
 
 time_dns 
-  avg:    0.002395 
-  median: 0.002359 
-  min:    0.002346 
-  max:    0.002479 
-  75%:    0.002419 
-  95%:    0.002467 
-  99%:    0.002477
+  avg:    0.002408 
+  median: 0.002392 
+  min:    0.002381 
+  max:    0.002451 
+  75%:    0.002422 
+  95%:    0.002445 
+  99%:    0.002450
 time_connect 
-  avg:    0.011057 
-  median: 0.011030 
-  min:    0.010994 
-  max:    0.011148 
-  75%:    0.011089 
-  95%:    0.011136 
-  99%:    0.011146
+  avg:    0.011070 
+  median: 0.011041 
+  min:    0.011015 
+  max:    0.011154 
+  75%:    0.011098 
+  95%:    0.011143 
+  99%:    0.011152
 time_appconnect 
-  avg:    0.036565 
-  median: 0.037028 
-  min:    0.035427 
-  max:    0.037240 
-  75%:    0.037134 
-  95%:    0.037219 
-  99%:    0.037236
+  avg:    0.029745 
+  median: 0.030285 
+  min:    0.027912 
+  max:    0.031037 
+  75%:    0.030661 
+  95%:    0.030962 
+  99%:    0.031022
 time_pretransfer 
-  avg:    0.036640 
-  median: 0.037100 
-  min:    0.035503 
-  max:    0.037317 
-  75%:    0.037209 
-  95%:    0.037295 
-  99%:    0.037313
+  avg:    0.029831 
+  median: 0.030374 
+  min:    0.027996 
+  max:    0.031123 
+  75%:    0.030749 
+  95%:    0.031048 
+  99%:    0.031108
 time_ttfb 
-  avg:    0.069263 
-  median: 0.068266 
-  min:    0.060286 
-  max:    0.079237 
-  75%:    0.073751 
-  95%:    0.078140 
-  99%:    0.079018
+  avg:    0.057429 
+  median: 0.058021 
+  min:    0.054617 
+  max:    0.059650 
+  75%:    0.058836 
+  95%:    0.059487 
+  99%:    0.059617
 time_total 
-  avg:    0.080960 
-  median: 0.085086 
-  min:    0.069271 
-  max:    0.088524 
-  75%:    0.086805 
-  95%:    0.088180 
-  99%:    0.088455
+  avg:    0.065653 
+  median: 0.066109 
+  min:    0.063293 
+  max:    0.067558 
+  75%:    0.066833 
+  95%:    0.067413 
+  99%:    0.067529
 
 time_dns
 avg:,median:,min:,max:,75%:,95%:,99%:
-0.002395,0.002359,0.002346,0.002479,0.002419,0.002467,0.002477
+0.002408,0.002392,0.002381,0.002451,0.002422,0.002445,0.002450
 time_connect
 avg:,median:,min:,max:,75%:,95%:,99%:
-0.011057,0.011030,0.010994,0.011148,0.011089,0.011136,0.011146
+0.011070,0.011041,0.011015,0.011154,0.011098,0.011143,0.011152
 time_appconnect
 avg:,median:,min:,max:,75%:,95%:,99%:
-0.036565,0.037028,0.035427,0.037240,0.037134,0.037219,0.037236
+0.029745,0.030285,0.027912,0.031037,0.030661,0.030962,0.031022
 time_pretransfer
 avg:,median:,min:,max:,75%:,95%:,99%:
-0.036640,0.037100,0.035503,0.037317,0.037209,0.037295,0.037313
+0.029831,0.030374,0.027996,0.031123,0.030749,0.031048,0.031108
 time_ttfb
 avg:,median:,min:,max:,75%:,95%:,99%:
-0.069263,0.068266,0.060286,0.079237,0.073751,0.078140,0.079018
+0.057429,0.058021,0.054617,0.059650,0.058836,0.059487,0.059617
 time_total
 avg:,median:,min:,max:,75%:,95%:,99%:
-0.080960,0.085086,0.069271,0.088524,0.086805,0.088180,0.088455
+0.065653,0.066109,0.063293,0.067558,0.066833,0.067413,0.067529

real    0m1.410s
user    0m0.298s
sys     0m0.249s
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
Connected to servermanager.guide (2606:4700:10::ac43:26be) port 443 (#0)
Sample Size: 3

0.002418,0.015616,0,0.015679,0.043934,0.055905
0.002461,0.015724,0,0.015787,0.040819,0.052362
0.00238,0.015587,0,0.01565,0.088367,0.099117

time_dns 
  avg:    0.002420 
  median: 0.002418 
  min:    0.002380 
  max:    0.002461 
  75%:    0.002440 
  95%:    0.002457 
  99%:    0.002460
time_connect 
  avg:    0.015642 
  median: 0.015616 
  min:    0.015587 
  max:    0.015724 
  75%:    0.015670 
  95%:    0.015713 
  99%:    0.015722
time_appconnect 
  avg:    0.000000 
  median: 0.000000 
  min:    0.000000 
  max:    0.000000 
  75%:    0.000000 
  95%:    0.000000 
  99%:    0.000000
time_pretransfer 
  avg:    0.015705 
  median: 0.015679 
  min:    0.015650 
  max:    0.015787 
  75%:    0.015733 
  95%:    0.015776 
  99%:    0.015785
time_ttfb 
  avg:    0.057707 
  median: 0.043934 
  min:    0.040819 
  max:    0.088367 
  75%:    0.066150 
  95%:    0.083924 
  99%:    0.087478
time_total 
  avg:    0.069128 
  median: 0.055905 
  min:    0.052362 
  max:    0.099117 
  75%:    0.077511 
  95%:    0.094796 
  99%:    0.098253

time_dns
avg:,median:,min:,max:,75%:,95%:,99%:
0.002420,0.002418,0.002380,0.002461,0.002440,0.002457,0.002460
time_connect
avg:,median:,min:,max:,75%:,95%:,99%:
0.015642,0.015616,0.015587,0.015724,0.015670,0.015713,0.015722
time_appconnect
avg:,median:,min:,max:,75%:,95%:,99%:
0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000
time_pretransfer
avg:,median:,min:,max:,75%:,95%:,99%:
0.015705,0.015679,0.015650,0.015787,0.015733,0.015776,0.015785
time_ttfb
avg:,median:,min:,max:,75%:,95%:,99%:
0.057707,0.043934,0.040819,0.088367,0.066150,0.083924,0.087478
time_total
avg:,median:,min:,max:,75%:,95%:,99%:
0.069128,0.055905,0.052362,0.099117,0.077511,0.094796,0.098253
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
--- curl-http2-tls13.txt        2020-08-03 11:43:11.165537343 +0000
+++ curl-http3-quic.txt 2020-08-03 11:42:56.063429165 +0000
@@ -1,77 +1,76 @@
 curl 7.72.0-DEV
-TLSv1.3 TLS_AES_128_GCM_SHA256
-HTTP/2
-Connected to servermanager.guide (2606:4700:10::6816:42fa) port 443 (#0)
+HTTP/3
+Connected to servermanager.guide (2606:4700:10::6816:43fa) port 443 (#0)
 Sample Size: 3
 
-0.002326,0.010946,0.027514,0.027596,0.064009,0.072842
-0.002312,0.010975,0.027706,0.027794,0.054353,0.063016
-0.002343,0.010972,0.027919,0.028001,0.056304,0.064145
+0.002068,0.015977,0,0.01604,0.045322,0.058387
+0.002492,0.015228,0,0.015289,0.045792,0.057082
+0.002454,0.014833,0,0.014896,0.040921,0.05188
 
 time_dns 
-  avg:    0.002327 
-  median: 0.002326 
-  min:    0.002312 
-  max:    0.002343 
-  75%:    0.002334 
-  95%:    0.002341 
-  99%:    0.002343
+  avg:    0.002338 
+  median: 0.002454 
+  min:    0.002068 
+  max:    0.002492 
+  75%:    0.002473 
+  95%:    0.002488 
+  99%:    0.002491
 time_connect 
-  avg:    0.010964 
-  median: 0.010972 
-  min:    0.010946 
-  max:    0.010975 
-  75%:    0.010973 
-  95%:    0.010975 
-  99%:    0.010975
+  avg:    0.015346 
+  median: 0.015228 
+  min:    0.014833 
+  max:    0.015977 
+  75%:    0.015603 
+  95%:    0.015902 
+  99%:    0.015962
 time_appconnect 
-  avg:    0.027713 
-  median: 0.027706 
-  min:    0.027514 
-  max:    0.027919 
-  75%:    0.027812 
-  95%:    0.027898 
-  99%:    0.027915
+  avg:    0.000000 
+  median: 0.000000 
+  min:    0.000000 
+  max:    0.000000 
+  75%:    0.000000 
+  95%:    0.000000 
+  99%:    0.000000
 time_pretransfer 
-  avg:    0.027797 
-  median: 0.027794 
-  min:    0.027596 
-  max:    0.028001 
-  75%:    0.027898 
-  95%:    0.027980 
-  99%:    0.027997
+  avg:    0.015408 
+  median: 0.015289 
+  min:    0.014896 
+  max:    0.016040 
+  75%:    0.015664 
+  95%:    0.015965 
+  99%:    0.016025
 time_ttfb 
-  avg:    0.058222 
-  median: 0.056304 
-  min:    0.054353 
-  max:    0.064009 
-  75%:    0.060157 
-  95%:    0.063239 
-  99%:    0.063855
+  avg:    0.044012 
+  median: 0.045322 
+  min:    0.040921 
+  max:    0.045792 
+  75%:    0.045557 
+  95%:    0.045745 
+  99%:    0.045783
 time_total 
-  avg:    0.066668 
-  median: 0.064145 
-  min:    0.063016 
-  max:    0.072842 
-  75%:    0.068494 
-  95%:    0.071972 
-  99%:    0.072668
+  avg:    0.055783 
+  median: 0.057082 
+  min:    0.051880 
+  max:    0.058387 
+  75%:    0.057734 
+  95%:    0.058256 
+  99%:    0.058361
 
 time_dns
 avg:,median:,min:,max:,75%:,95%:,99%:
-0.002327,0.002326,0.002312,0.002343,0.002334,0.002341,0.002343
+0.002338,0.002454,0.002068,0.002492,0.002473,0.002488,0.002491
 time_connect
 avg:,median:,min:,max:,75%:,95%:,99%:
-0.010964,0.010972,0.010946,0.010975,0.010973,0.010975,0.010975
+0.015346,0.015228,0.014833,0.015977,0.015603,0.015902,0.015962
 time_appconnect
 avg:,median:,min:,max:,75%:,95%:,99%:
-0.027713,0.027706,0.027514,0.027919,0.027812,0.027898,0.027915
+0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000
 time_pretransfer
 avg:,median:,min:,max:,75%:,95%:,99%:
-0.027797,0.027794,0.027596,0.028001,0.027898,0.027980,0.027997
+0.015408,0.015289,0.014896,0.016040,0.015664,0.015965,0.016025
 time_ttfb
 avg:,median:,min:,max:,75%:,95%:,99%:
-0.058222,0.056304,0.054353,0.064009,0.060157,0.063239,0.063855
+0.044012,0.045322,0.040921,0.045792,0.045557,0.045745,0.045783
 time_total
 avg:,median:,min:,max:,75%:,95%:,99%:
-0.066668,0.064145,0.063016,0.072842,0.068494,0.071972,0.072668
+0.055783,0.057082,0.051880,0.058387,0.057734,0.058256,0.058361
```

# Compare Mode

Extended `curltimes.sh` to automate the above diff compare for TLSv1.2 versus TLSv1.3 in summary format without individual metrics

```
domain=servermanager.guide
./curltimes.sh compare https://$domain
```
```
domain=servermanager.guide
./curltimes.sh compare https://$domain

 curl 7.72.0-DEV
-TLSv1.2 ECDHE-ECDSA-AES128-GCM-SHA256
+TLSv1.3 TLS_AES_128_GCM_SHA256
 HTTP/2
-Connected to servermanager.guide (2606:4700:10::ac43:26be) port 443 (#0)
+Connected to servermanager.guide (2606:4700:10::6816:42fa) port 443 (#0)
 Sample Size: 3

       time_dns
       avg:,median:,min:,max:,75%:,95%:,99%:
tls12: 0.006312,0.002349,0.002342,0.014245,0.008297,0.013055,0.014007
tls13: 0.007001,0.002409,0.002332,0.016262,0.009335,0.014877,0.015985
       time_connect
       avg:,median:,min:,max:,75%:,95%:,99%:
tls12: 0.015793,0.013359,0.011095,0.022924,0.018142,0.021968,0.022733
tls13: 0.016479,0.011109,0.011041,0.027288,0.019198,0.025670,0.026964
       time_appconnect
       avg:,median:,min:,max:,75%:,95%:,99%:
tls12: 0.044413,0.045667,0.039694,0.047878,0.046772,0.047657,0.047834
tls13: 0.034607,0.029052,0.028229,0.046539,0.037796,0.044790,0.046189
       time_pretransfer
       avg:,median:,min:,max:,75%:,95%:,99%:
tls12: 0.044489,0.045755,0.039760,0.047951,0.046853,0.047731,0.047907
tls13: 0.034687,0.029118,0.028320,0.046623,0.037871,0.044872,0.046273
       time_ttfb
       avg:,median:,min:,max:,75%:,95%:,99%:
tls12: 0.083920,0.079920,0.075112,0.096729,0.088325,0.095048,0.096393
tls13: 0.066135,0.062355,0.059512,0.076539,0.069447,0.075121,0.076255
       time_total
       avg:,median:,min:,max:,75%:,95%:,99%:
tls12: 0.095370,0.094142,0.084327,0.107640,0.100891,0.106290,0.107370
tls13: 0.077608,0.073708,0.072246,0.086870,0.080289,0.085554,0.086607
```

# curl resolve mode

`curltimes.sh` supports curl's `--resolve domain:443:[ip_address]` so you can tell curl to connect and resolve to a specific IP address overriding DNS for that domain. Useful for when testing domains that use Cloudflare proxy which have more than 1 IP address associated with the domain's DNS A and AAAA records. This ensures you're testing TLSv1.2 vs TLSv1.3 on the same server/IP.

By default `curltimes.sh` tests against IPv6 address first and fallbacks to IPv4 if IPv6 isn't supported. But if you want to force IPv4 tests, change in script `force_ipv4='n'` to `force_ipv4='y'`.

Run `csv-max-sum` and tell curl to connect to `domain=servermanager.guide` using IPv6 address `2606:4700:10::ac43:26be`

```
dig +short AAAA servermanager.guide                          
2606:4700:10::ac43:26be
2606:4700:10::6816:42fa
2606:4700:10::6816:43fa
```

```
domain=servermanager.guide
./curltimes.sh csv-max-sum https://$domain 2606:4700:10::ac43:26be                           
curl 7.72.0-DEV
TLSv1.3 TLS_AES_128_GCM_SHA256
HTTP/2
Connected to servermanager.guide (2606:4700:10::ac43:26be) port 443 (#0)
Sample Size: 3

0.002388,0.011001,0.027721,0.027805,0.055312,0.063218
0.002387,0.011143,0.028621,0.028703,0.057248,0.067432
0.002407,0.011234,0.027669,0.027752,0.057698,0.066897

time_dns 
  avg:    0.002394 
  median: 0.002388 
  min:    0.002387 
  max:    0.002407 
  75%:    0.002398 
  95%:    0.002405 
  99%:    0.002407
time_connect 
  avg:    0.011126 
  median: 0.011143 
  min:    0.011001 
  max:    0.011234 
  75%:    0.011188 
  95%:    0.011225 
  99%:    0.011232
time_appconnect 
  avg:    0.028004 
  median: 0.027721 
  min:    0.027669 
  max:    0.028621 
  75%:    0.028171 
  95%:    0.028531 
  99%:    0.028603
time_pretransfer 
  avg:    0.028087 
  median: 0.027805 
  min:    0.027752 
  max:    0.028703 
  75%:    0.028254 
  95%:    0.028613 
  99%:    0.028685
time_ttfb 
  avg:    0.056753 
  median: 0.057248 
  min:    0.055312 
  max:    0.057698 
  75%:    0.057473 
  95%:    0.057653 
  99%:    0.057689
time_total 
  avg:    0.065849 
  median: 0.066897 
  min:    0.063218 
  max:    0.067432 
  75%:    0.067164 
  95%:    0.067378 
  99%:    0.067421

time_dns
avg:,median:,min:,max:,75%:,95%:,99%:
0.002394,0.002388,0.002387,0.002407,0.002398,0.002405,0.002407
time_connect
avg:,median:,min:,max:,75%:,95%:,99%:
0.011126,0.011143,0.011001,0.011234,0.011188,0.011225,0.011232
time_appconnect
avg:,median:,min:,max:,75%:,95%:,99%:
0.028004,0.027721,0.027669,0.028621,0.028171,0.028531,0.028603
time_pretransfer
avg:,median:,min:,max:,75%:,95%:,99%:
0.028087,0.027805,0.027752,0.028703,0.028254,0.028613,0.028685
time_ttfb
avg:,median:,min:,max:,75%:,95%:,99%:
0.056753,0.057248,0.055312,0.057698,0.057473,0.057653,0.057689
time_total
avg:,median:,min:,max:,75%:,95%:,99%:
0.065849,0.066897,0.063218,0.067432,0.067164,0.067378,0.067421
```

Run `compare` and tell curl to connect to `domain=servermanager.guide` using IPv6 address `2606:4700:10::ac43:26be`

```
domain=servermanager.guide
./curltimes.sh compare https://$domain 2606:4700:10::ac43:26be
 curl 7.72.0-DEV
-TLSv1.2 ECDHE-ECDSA-AES128-GCM-SHA256
+TLSv1.3 TLS_AES_128_GCM_SHA256
 HTTP/2
 Connected to servermanager.guide (2606:4700:10::ac43:26be) port 443 (#0)
 Sample Size: 3
 

       time_dns
       avg:,median:,min:,max:,75%:,95%:,99%:
tls12: 0.002273,0.002341,0.002040,0.002438,0.002389,0.002428,0.002436
tls13: 0.002303,0.002342,0.002106,0.002461,0.002402,0.002449,0.002459
       time_connect
       avg:,median:,min:,max:,75%:,95%:,99%:
tls12: 0.010944,0.010974,0.010692,0.011165,0.011069,0.011146,0.011161
tls13: 0.010984,0.011001,0.010871,0.011080,0.011040,0.011072,0.011078
       time_appconnect
       avg:,median:,min:,max:,75%:,95%:,99%:
tls12: 0.037632,0.037541,0.037520,0.037834,0.037687,0.037805,0.037828
tls13: 0.027178,0.026750,0.026311,0.028474,0.027612,0.028302,0.028440
       time_pretransfer
       avg:,median:,min:,max:,75%:,95%:,99%:
tls12: 0.037710,0.037609,0.037608,0.037914,0.037762,0.037883,0.037908
tls13: 0.027265,0.026839,0.026394,0.028561,0.027700,0.028389,0.028527
       time_ttfb
       avg:,median:,min:,max:,75%:,95%:,99%:
tls12: 0.074693,0.078118,0.064590,0.081372,0.079745,0.081047,0.081307
tls13: 0.061370,0.056089,0.054502,0.073519,0.064804,0.071776,0.073170
       time_total
       avg:,median:,min:,max:,75%:,95%:,99%:
tls12: 0.083769,0.087006,0.074226,0.090074,0.088540,0.089767,0.090013
tls13: 0.070788,0.064854,0.064317,0.083194,0.074024,0.081360,0.082827
```