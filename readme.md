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
* [Environment Variables](https://github.com/centminmod/curltimes#environment-variables)

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
Connected to servermanager.guide (2606:4700:10::ac43:26be) port 443 (#0)
Cloudflare proxied https://servermanager.guide
Sample Size: 3

DNS,Connect,SSL,Wait,TTFB,Total Time
{
        "time_dns":             0.015699,
        "time_connect":         0.024545,
        "time_appconnect":      0.062394,
        "time_pretransfer":     0.062475,
        "time_ttfb":            0.094291,
        "time_total":           0.103574
}{
        "time_dns":             0.002299,
        "time_connect":         0.013313,
        "time_appconnect":      0.045032,
        "time_pretransfer":     0.045112,
        "time_ttfb":            0.069348,
        "time_total":           0.080474
}{
        "time_dns":             0.017739,
        "time_connect":         0.026433,
        "time_appconnect":      0.053973,
        "time_pretransfer":     0.054058,
        "time_ttfb":            0.083686,
        "time_total":           0.093763
}
```

json output with TLS 1.3 max

```
./curltimes.sh json-max https://servermanager.guide
curl 7.72.0-DEV
TLSv1.3 TLS_AES_128_GCM_SHA256
HTTP/2
Connected to servermanager.guide (2606:4700:10::6816:42fa) port 443 (#0)
Cloudflare proxied https://servermanager.guide
Sample Size: 3

DNS,Connect,SSL,Wait,TTFB,Total Time
{
        "time_dns":             0.002447,
        "time_connect":         0.011198,
        "time_appconnect":      0.027511,
        "time_pretransfer":     0.027593,
        "time_ttfb":            0.064391,
        "time_total":           0.073440
}{
        "time_dns":             0.002405,
        "time_connect":         0.013513,
        "time_appconnect":      0.033980,
        "time_pretransfer":     0.034065,
        "time_ttfb":            0.073271,
        "time_total":           0.084364
}{
        "time_dns":             0.002346,
        "time_connect":         0.011054,
        "time_appconnect":      0.030559,
        "time_pretransfer":     0.030656,
        "time_ttfb":            0.084737,
        "time_total":           0.093304
}
```

csv output with TLS 1.2 max

```
./curltimes.sh csv https://servermanager.guide
curl 7.72.0-DEV
TLSv1.2 ECDHE-ECDSA-AES128-GCM-SHA256
HTTP/2
Connected to servermanager.guide (2606:4700:10::ac43:26be) port 443 (#0)
Cloudflare proxied https://servermanager.guide
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
Cloudflare proxied https://servermanager.guide
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
Cloudflare proxied https://servermanager.guide
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
Cloudflare proxied https://servermanager.guide
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
 Cloudflare proxied https://servermanager.guide
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
Cloudflare proxied https://servermanager.guide
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
 Cloudflare proxied https://servermanager.guide
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
 Cloudflare proxied https://servermanager.guide
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
Cloudflare proxied https://servermanager.guide
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
 Cloudflare proxied https://servermanager.guide
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

Run `compare` and tell curl to connect to `domain=servermanager.guide` using all available IP addresses attached to the domain

```
dig +short AAAA servermanager.guide                          
2606:4700:10::ac43:26be
2606:4700:10::6816:42fa
2606:4700:10::6816:43fa
```
```
dig +short AAAA servermanager.guide | while read ip; do echo; domain=servermanager.guide; ./curltimes.sh compare https://$domain $ip; done

 curl 7.72.0-DEV
-TLSv1.2 ECDHE-ECDSA-AES128-GCM-SHA256
+TLSv1.3 TLS_AES_128_GCM_SHA256
 HTTP/2
 Connected to servermanager.guide (2606:4700:10::6816:42fa) port 443 (#0)
 Cloudflare proxied https://servermanager.guide
 Sample Size: 33
 

       time_dns
       avg:,median:,min:,max:,75%:,95%:,99%:
tls12: 0.000025,0.000025,0.000020,0.000026,0.000025,0.000026,0.000026
tls13: 0.000025,0.000025,0.000024,0.000026,0.000026,0.000026,0.000026
       time_connect
       avg:,median:,min:,max:,75%:,95%:,99%:
tls12: 0.010083,0.011044,0.008652,0.011193,0.011088,0.011148,0.011182
tls13: 0.010099,0.011044,0.008677,0.011190,0.011110,0.011149,0.011177
       time_appconnect
       avg:,median:,min:,max:,75%:,95%:,99%:
tls12: 0.039038,0.040243,0.033176,0.047499,0.041386,0.044336,0.046505
tls13: 0.029268,0.029406,0.024333,0.040761,0.030714,0.035750,0.039538
       time_pretransfer
       avg:,median:,min:,max:,75%:,95%:,99%:
tls12: 0.039119,0.040309,0.033263,0.047585,0.041480,0.044415,0.046588
tls13: 0.029349,0.029485,0.024418,0.040846,0.030803,0.035830,0.039621
       time_ttfb
       avg:,median:,min:,max:,75%:,95%:,99%:
tls12: 0.087151,0.069190,0.056990,0.663826,0.072905,0.081628,0.478225
tls13: 0.058539,0.057606,0.047161,0.077984,0.063481,0.071283,0.075865
       time_total
       avg:,median:,min:,max:,75%:,95%:,99%:
tls12: 0.097619,0.079912,0.065917,0.672491,0.083919,0.093142,0.487833
tls13: 0.069042,0.067686,0.055383,0.096125,0.074209,0.085111,0.093838

 curl 7.72.0-DEV
-TLSv1.2 ECDHE-ECDSA-AES128-GCM-SHA256
+TLSv1.3 TLS_AES_128_GCM_SHA256
 HTTP/2
 Connected to servermanager.guide (2606:4700:10::6816:43fa) port 443 (#0)
 Cloudflare proxied https://servermanager.guide
 Sample Size: 33
 

       time_dns
       avg:,median:,min:,max:,75%:,95%:,99%:
tls12: 0.000025,0.000025,0.000023,0.000026,0.000026,0.000026,0.000026
tls13: 0.000025,0.000025,0.000024,0.000029,0.000026,0.000026,0.000028
       time_connect
       avg:,median:,min:,max:,75%:,95%:,99%:
tls12: 0.008726,0.008719,0.008653,0.008915,0.008745,0.008799,0.008880
tls13: 0.008718,0.008712,0.008656,0.008857,0.008743,0.008792,0.008837
       time_appconnect
       avg:,median:,min:,max:,75%:,95%:,99%:
tls12: 0.034422,0.033977,0.032593,0.040353,0.034435,0.039491,0.040205
tls13: 0.025299,0.024797,0.023931,0.036109,0.025368,0.027200,0.033315
       time_pretransfer
       avg:,median:,min:,max:,75%:,95%:,99%:
tls12: 0.034506,0.034068,0.032667,0.040433,0.034525,0.039572,0.040285
tls13: 0.025381,0.024882,0.024011,0.036191,0.025455,0.027284,0.033400
       time_ttfb
       avg:,median:,min:,max:,75%:,95%:,99%:
tls12: 0.067356,0.060527,0.052128,0.151831,0.069639,0.093947,0.141133
tls13: 0.053913,0.052717,0.044503,0.074495,0.055531,0.067609,0.073210
       time_total
       avg:,median:,min:,max:,75%:,95%:,99%:
tls12: 0.076999,0.070714,0.061163,0.162636,0.081503,0.104291,0.152367
tls13: 0.063297,0.061701,0.054232,0.084139,0.066266,0.078864,0.083847

 curl 7.72.0-DEV
-TLSv1.2 ECDHE-ECDSA-AES128-GCM-SHA256
+TLSv1.3 TLS_AES_128_GCM_SHA256
 HTTP/2
 Connected to servermanager.guide (2606:4700:10::ac43:26be) port 443 (#0)
 Cloudflare proxied https://servermanager.guide
 Sample Size: 33
 

       time_dns
       avg:,median:,min:,max:,75%:,95%:,99%:
tls12: 0.000025,0.000025,0.000021,0.000037,0.000026,0.000026,0.000034
tls13: 0.000025,0.000025,0.000022,0.000028,0.000026,0.000027,0.000028
       time_connect
       avg:,median:,min:,max:,75%:,95%:,99%:
tls12: 0.008706,0.008701,0.008633,0.008807,0.008734,0.008772,0.008800
tls13: 0.008702,0.008693,0.008632,0.008824,0.008726,0.008769,0.008814
       time_appconnect
       avg:,median:,min:,max:,75%:,95%:,99%:
tls12: 0.034213,0.033580,0.032419,0.041174,0.034753,0.038515,0.041058
tls13: 0.025060,0.024716,0.024137,0.029303,0.025110,0.027225,0.028939
       time_pretransfer
       avg:,median:,min:,max:,75%:,95%:,99%:
tls12: 0.034297,0.033668,0.032494,0.041251,0.034843,0.038605,0.041136
tls13: 0.025142,0.024795,0.024216,0.029374,0.025191,0.027307,0.029012
       time_ttfb
       avg:,median:,min:,max:,75%:,95%:,99%:
tls12: 0.062295,0.061499,0.053344,0.077344,0.065682,0.073393,0.076253
tls13: 0.052009,0.051708,0.044970,0.061672,0.053383,0.059193,0.061464
       time_total
       avg:,median:,min:,max:,75%:,95%:,99%:
tls12: 0.073144,0.072723,0.061965,0.111716,0.075453,0.088226,0.105054
tls13: 0.061540,0.061019,0.052092,0.074847,0.062104,0.069454,0.073440
```

# Environment Variables

`curltimes.sh` supports environment variables to override the defaults. Currently, supported variables include:

* `curlruns` - value set overrides `total` variable within script which determines how many curl runs and samples are collected.
* `ipv4=1` - enables and forces IPv4 curl connection.
* `h3=1` - enables HTTP/3 for `json`, `json-max`, `csv`, `csv-sum`, `csv-max`, `csv-max-sum` options but not supported in `compare` mode as TLSv1.2/TLSv1.3 are not used as HTTP/3 is over a QUIC connection. HTTP/3 mode only works once you have edited curl binary log and library paths as outlined [here](https://github.com/centminmod/curltimes#curl-http3-support).
* `bin_h3` - set path to your curl HTTP/3 binary
* `lib_h3` - set path to your curl HTTP/3 library directory

## To unset/clear environment variables

```
unset bin_h3
unset lib_h3
unset h3
unset ipv4
unset curlruns
```

## To set environment variables:

compare IPv4 vs IPv6 `curltimes.sh` runs 

```
diff -u <(export ipv4=1; ./curltimes.sh compare https://servermanager.guide/) <(export ipv4=0; ./curltimes.sh compare https://servermanager.guide/)
--- /dev/fd/63  2020-08-05 17:32:32.773262582 +0000
+++ /dev/fd/62  2020-08-05 17:32:32.773262582 +0000
@@ -2,31 +2,31 @@
 -TLSv1.2 ECDHE-ECDSA-AES128-GCM-SHA256
 +TLSv1.3 TLS_AES_128_GCM_SHA256
  HTTP/2
- Connected to servermanager.guide (104.22.66.250) port 443 (#0)
+ Connected to servermanager.guide (2606:4700:10::ac43:26be) port 443 (#0)
  Cloudflare proxied https://servermanager.guide/
  Sample Size: 11
 
        time_dns
        avg:,median:,min:,max:,75%:,95%:,99%:
-tls12: 0.002077,0.002059,0.002006,0.002299,0.002097,0.002205,0.002280
-tls13: 0.002092,0.002056,0.001963,0.002428,0.002130,0.002295,0.002401
+tls12: 0.002144,0.002097,0.002030,0.002421,0.002147,0.002372,0.002411
+tls13: 0.002161,0.002109,0.002058,0.002488,0.002163,0.002407,0.002472
        time_connect
        avg:,median:,min:,max:,75%:,95%:,99%:
-tls12: 0.013772,0.011036,0.010907,0.021395,0.015862,0.021358,0.021388
-tls13: 0.013775,0.011050,0.010858,0.021438,0.016016,0.021423,0.021435
+tls12: 0.010776,0.010724,0.010674,0.011026,0.010810,0.011016,0.011024
+tls13: 0.010855,0.010786,0.010701,0.011132,0.010897,0.011083,0.011122
        time_appconnect
        avg:,median:,min:,max:,75%:,95%:,99%:
-tls12: 0.047508,0.037708,0.036823,0.077156,0.053092,0.076873,0.077099
-tls13: 0.033566,0.027502,0.026627,0.050332,0.039158,0.050028,0.050271
+tls12: 0.036577,0.035408,0.034458,0.045465,0.036535,0.041822,0.044736
+tls13: 0.027222,0.027004,0.026216,0.029019,0.027584,0.028997,0.029015
        time_pretransfer
        avg:,median:,min:,max:,75%:,95%:,99%:
-tls12: 0.047597,0.037784,0.036901,0.077249,0.053159,0.076952,0.077190
-tls13: 0.033648,0.027582,0.026706,0.050414,0.039242,0.050108,0.050353
+tls12: 0.036664,0.035513,0.034550,0.045535,0.036618,0.041896,0.044807
+tls13: 0.027305,0.027097,0.026301,0.029102,0.027668,0.029083,0.029098
        time_ttfb
        avg:,median:,min:,max:,75%:,95%:,99%:
-tls12: 0.084272,0.072064,0.061022,0.126004,0.097472,0.125499,0.125903
-tls13: 0.068917,0.059372,0.051965,0.100478,0.084044,0.100301,0.100443
+tls12: 0.063700,0.064039,0.055325,0.075642,0.067243,0.073135,0.075141
+tls13: 0.053768,0.052910,0.047872,0.060991,0.054959,0.060255,0.060844
        time_total
        avg:,median:,min:,max:,75%:,95%:,99%:
-tls12: 0.096266,0.081401,0.070310,0.145221,0.111710,0.144299,0.145037
-tls13: 0.078791,0.068584,0.060828,0.120495,0.092188,0.114550,0.119306
+tls12: 0.073090,0.073095,0.064207,0.084682,0.076296,0.082443,0.084234
+tls13: 0.062669,0.061688,0.056864,0.069835,0.064686,0.069074,0.069683
```

example setting `h3=1`, `ipv4=1` and `curlruns=9` and `bin_h3='/usr/local/src/curl/src/curl'` and `lib_h3='/usr/lib/x86_64-linux-gnu'`

```
export bin_h3='/usr/local/src/curl/src/curl'
export lib_h3='/usr/lib/x86_64-linux-gnu'
export h3=1
export ipv4=1
export curlruns=9
./curltimes.sh csv-max-sum https://servermanager.guide                                
curl 7.72.0-DEV
HTTP/3
Connected to servermanager.guide (104.22.67.250) port 443 (#0)
Sample Size: 9

0.002295,0.016681,0,0.016746,0.051228,0.063913
0.002299,0.018685,0,0.018749,0.054747,0.068125
0.001971,0.015321,0,0.015386,0.055653,0.067125
0.002293,0.019275,0,0.019341,0.059958,0.074864
0.002361,0.017828,0,0.017891,0.056725,0.07114
0.00238,0.017844,0,0.017908,0.050139,0.063757
0.002352,0.01534,0,0.015406,0.053851,0.065687
0.002448,0.016069,0,0.016134,0.044222,0.056
0.002016,0.014094,0,0.014158,0.050546,0.06078

time_dns 
  avg:    0.002268 
  median: 0.002299 
  min:    0.001971 
  max:    0.002448 
  75%:    0.002361 
  95%:    0.002421 
  99%:    0.002443
time_connect 
  avg:    0.016793 
  median: 0.016681 
  min:    0.014094 
  max:    0.019275 
  75%:    0.017844 
  95%:    0.019039 
  99%:    0.019228
time_appconnect 
  avg:    0.000000 
  median: 0.000000 
  min:    0.000000 
  max:    0.000000 
  75%:    0.000000 
  95%:    0.000000 
  99%:    0.000000
time_pretransfer 
  avg:    0.016858 
  median: 0.016746 
  min:    0.014158 
  max:    0.019341 
  75%:    0.017908 
  95%:    0.019104 
  99%:    0.019294
time_ttfb 
  avg:    0.053008 
  median: 0.053851 
  min:    0.044222 
  max:    0.059958 
  75%:    0.055653 
  95%:    0.058665 
  99%:    0.059699
time_total 
  avg:    0.065710 
  median: 0.065687 
  min:    0.056000 
  max:    0.074864 
  75%:    0.068125 
  95%:    0.073374 
  99%:    0.074566

time_dns
avg:,median:,min:,max:,75%:,95%:,99%:
0.002268,0.002299,0.001971,0.002448,0.002361,0.002421,0.002443
time_connect
avg:,median:,min:,max:,75%:,95%:,99%:
0.016793,0.016681,0.014094,0.019275,0.017844,0.019039,0.019228
time_appconnect
avg:,median:,min:,max:,75%:,95%:,99%:
0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000
time_pretransfer
avg:,median:,min:,max:,75%:,95%:,99%:
0.016858,0.016746,0.014158,0.019341,0.017908,0.019104,0.019294
time_ttfb
avg:,median:,min:,max:,75%:,95%:,99%:
0.053008,0.053851,0.044222,0.059958,0.055653,0.058665,0.059699
time_total
avg:,median:,min:,max:,75%:,95%:,99%:
0.065710,0.065687,0.056000,0.074864,0.068125,0.073374,0.074566
```

example setting `h3=1`, `ipv4=1` and `curlruns=9`

```
export h3=1; export curlruns=9; ./curltimes.sh csv-max-sum https://servermanager.guide
curl 7.72.0-DEV
HTTP/3
Connected to servermanager.guide (104.22.66.250) port 443 (#0)
Sample Size: 9

0.002321,0.015649,0,0.015713,0.059255,0.074366
0.002275,0.01915,0,0.019216,0.060405,0.073003
0.002069,0.014761,0,0.014825,0.040994,0.051945
0.002372,0.015474,0,0.015538,0.047742,0.058395
0.002302,0.016191,0,0.016256,0.083929,0.096794
0.002396,0.020889,0,0.020954,0.050261,0.061726
0.002317,0.016253,0,0.016317,0.075135,0.089547
0.002062,0.016816,0,0.016882,0.045394,0.058711
0.002357,0.014203,0,0.014267,0.041617,0.053641

time_dns 
  avg:    0.002275 
  median: 0.002317 
  min:    0.002062 
  max:    0.002396 
  75%:    0.002357 
  95%:    0.002386 
  99%:    0.002394
time_connect 
  avg:    0.016598 
  median: 0.016191 
  min:    0.014203 
  max:    0.020889 
  75%:    0.016816 
  95%:    0.020193 
  99%:    0.020750
time_appconnect 
  avg:    0.000000 
  median: 0.000000 
  min:    0.000000 
  max:    0.000000 
  75%:    0.000000 
  95%:    0.000000 
  99%:    0.000000
time_pretransfer 
  avg:    0.016663 
  median: 0.016256 
  min:    0.014267 
  max:    0.020954 
  75%:    0.016882 
  95%:    0.020259 
  99%:    0.020815
time_ttfb 
  avg:    0.056081 
  median: 0.050261 
  min:    0.040994 
  max:    0.083929 
  75%:    0.060405 
  95%:    0.080411 
  99%:    0.083225
time_total 
  avg:    0.068681 
  median: 0.061726 
  min:    0.051945 
  max:    0.096794 
  75%:    0.074366 
  95%:    0.093895 
  99%:    0.096214

time_dns
avg:,median:,min:,max:,75%:,95%:,99%:
0.002275,0.002317,0.002062,0.002396,0.002357,0.002386,0.002394
time_connect
avg:,median:,min:,max:,75%:,95%:,99%:
0.016598,0.016191,0.014203,0.020889,0.016816,0.020193,0.020750
time_appconnect
avg:,median:,min:,max:,75%:,95%:,99%:
0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000
time_pretransfer
avg:,median:,min:,max:,75%:,95%:,99%:
0.016663,0.016256,0.014267,0.020954,0.016882,0.020259,0.020815
time_ttfb
avg:,median:,min:,max:,75%:,95%:,99%:
0.056081,0.050261,0.040994,0.083929,0.060405,0.080411,0.083225
time_total
avg:,median:,min:,max:,75%:,95%:,99%:
0.068681,0.061726,0.051945,0.096794,0.074366,0.093895,0.096214
```

example setting `ipv4=1` and `curlruns=9`

```
export ipv4=1; export curlruns=9; ./curltimes.sh compare https://servermanager.guide
 curl 7.72.0-DEV
-TLSv1.2 ECDHE-ECDSA-AES128-GCM-SHA256
+TLSv1.3 TLS_AES_128_GCM_SHA256
 HTTP/2
 Connected to servermanager.guide (104.22.67.250) port 443 (#0)
 Sample Size: 9
 

       time_dns
       avg:,median:,min:,max:,75%:,95%:,99%:
tls12: 0.002266,0.002306,0.001963,0.002981,0.002375,0.002752,0.002935
tls13: 0.002164,0.002065,0.002008,0.002353,0.002305,0.002343,0.002351
       time_connect
       avg:,median:,min:,max:,75%:,95%:,99%:
tls12: 0.011470,0.011221,0.010863,0.012769,0.011674,0.012554,0.012726
tls13: 0.011150,0.011199,0.010907,0.011664,0.011224,0.011501,0.011631
       time_appconnect
       avg:,median:,min:,max:,75%:,95%:,99%:
tls12: 0.038583,0.037770,0.035704,0.044849,0.040180,0.043083,0.044496
tls13: 0.028934,0.028282,0.026903,0.033745,0.030355,0.032446,0.033485
       time_pretransfer
       avg:,median:,min:,max:,75%:,95%:,99%:
tls12: 0.038659,0.037840,0.035786,0.044915,0.040259,0.043149,0.044562
tls13: 0.029023,0.028363,0.026984,0.033866,0.030450,0.032554,0.033604
       time_ttfb
       avg:,median:,min:,max:,75%:,95%:,99%:
tls12: 0.073622,0.068073,0.060629,0.118547,0.074154,0.101701,0.115178
tls13: 0.062501,0.055822,0.051451,0.108622,0.063113,0.090978,0.105093
       time_total
       avg:,median:,min:,max:,75%:,95%:,99%:
tls12: 0.085110,0.077332,0.069529,0.147206,0.083043,0.122934,0.142352
tls13: 0.071165,0.064227,0.060406,0.117624,0.070848,0.100372,0.114174
```

example of setting `curlruns=9`

```
export curlruns=9; ./curltimes.sh compare https://servermanager.guide 
 curl 7.72.0-DEV
-TLSv1.2 ECDHE-ECDSA-AES128-GCM-SHA256
+TLSv1.3 TLS_AES_128_GCM_SHA256
 HTTP/2
 Connected to servermanager.guide (2606:4700:10::6816:42fa) port 443 (#0)
 Sample Size: 9
 

       time_dns
       avg:,median:,min:,max:,75%:,95%:,99%:
tls12: 0.002187,0.002133,0.002044,0.002341,0.002262,0.002328,0.002338
tls13: 0.002298,0.002338,0.002043,0.002561,0.002448,0.002521,0.002553
       time_connect
       avg:,median:,min:,max:,75%:,95%:,99%:
tls12: 0.011639,0.010946,0.010742,0.013267,0.013115,0.013238,0.013261
tls13: 0.011529,0.011110,0.010665,0.013538,0.011268,0.013376,0.013506
       time_appconnect
       avg:,median:,min:,max:,75%:,95%:,99%:
tls12: 0.037602,0.035707,0.034805,0.042342,0.042305,0.042340,0.042342
tls13: 0.028889,0.027606,0.026484,0.032393,0.031420,0.032186,0.032352
       time_pretransfer
       avg:,median:,min:,max:,75%:,95%:,99%:
tls12: 0.037685,0.035797,0.034889,0.042421,0.042386,0.042421,0.042421
tls13: 0.028973,0.027697,0.026567,0.032475,0.031508,0.032268,0.032434
       time_ttfb
       avg:,median:,min:,max:,75%:,95%:,99%:
tls12: 0.068222,0.068780,0.057609,0.080518,0.071698,0.077504,0.079915
tls13: 0.063180,0.059101,0.053305,0.086026,0.062583,0.081901,0.085201
       time_total
       avg:,median:,min:,max:,75%:,95%:,99%:
tls12: 0.078020,0.077660,0.067355,0.091523,0.080867,0.088713,0.090961
tls13: 0.072594,0.069236,0.062089,0.094605,0.071386,0.091319,0.093948
```
```
export curlruns=9; ./curltimes.sh csv-max-sum https://servermanager.guide      
curl 7.72.0-DEV
TLSv1.3 TLS_AES_128_GCM_SHA256
HTTP/2
Connected to servermanager.guide (2606:4700:10::ac43:26be) port 443 (#0)
Sample Size: 9

0.002307,0.010995,0.038922,0.039008,0.07083,0.080726
0.015496,0.024134,0.043342,0.043424,0.068281,0.078138
0.002345,0.011095,0.02733,0.027414,0.048162,0.057521
0.014392,0.025453,0.044971,0.045054,0.098739,0.107577
0.002321,0.011045,0.028931,0.029016,0.097482,0.106865
0.002073,0.010717,0.030454,0.030537,0.092841,0.103577
0.00207,0.010795,0.030796,0.030884,0.066117,0.075068
0.002316,0.01333,0.031471,0.031555,0.061374,0.069335
0.002076,0.013093,0.03159,0.031673,0.078254,0.089818

time_dns 
  avg:    0.005044 
  median: 0.002316 
  min:    0.002070 
  max:    0.015496 
  75%:    0.002345 
  95%:    0.015054 
  99%:    0.015408
time_connect 
  avg:    0.014517 
  median: 0.011095 
  min:    0.010717 
  max:    0.025453 
  75%:    0.013330 
  95%:    0.024925 
  99%:    0.025347
time_appconnect 
  avg:    0.034201 
  median: 0.031471 
  min:    0.027330 
  max:    0.044971 
  75%:    0.038922 
  95%:    0.044319 
  99%:    0.044841
time_pretransfer 
  avg:    0.034285 
  median: 0.031555 
  min:    0.027414 
  max:    0.045054 
  75%:    0.039008 
  95%:    0.044402 
  99%:    0.044924
time_ttfb 
  avg:    0.075787 
  median: 0.070830 
  min:    0.048162 
  max:    0.098739 
  75%:    0.092841 
  95%:    0.098236 
  99%:    0.098638
time_total 
  avg:    0.085403 
  median: 0.080726 
  min:    0.057521 
  max:    0.107577 
  75%:    0.103577 
  95%:    0.107292 
  99%:    0.107520

time_dns
avg:,median:,min:,max:,75%:,95%:,99%:
0.005044,0.002316,0.002070,0.015496,0.002345,0.015054,0.015408
time_connect
avg:,median:,min:,max:,75%:,95%:,99%:
0.014517,0.011095,0.010717,0.025453,0.013330,0.024925,0.025347
time_appconnect
avg:,median:,min:,max:,75%:,95%:,99%:
0.034201,0.031471,0.027330,0.044971,0.038922,0.044319,0.044841
time_pretransfer
avg:,median:,min:,max:,75%:,95%:,99%:
0.034285,0.031555,0.027414,0.045054,0.039008,0.044402,0.044924
time_ttfb
avg:,median:,min:,max:,75%:,95%:,99%:
0.075787,0.070830,0.048162,0.098739,0.092841,0.098236,0.098638
time_total
avg:,median:,min:,max:,75%:,95%:,99%:
0.085403,0.080726,0.057521,0.107577,0.103577,0.107292,0.107520
```