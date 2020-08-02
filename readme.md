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

0.002357,0.01105,0.039398,0.039477,0.072271,0.083146
0.002373,0.011168,0.035893,0.035983,0.065458,0.07657
0.002398,0.011077,0.039665,0.039746,0.118985,0.128668

time_dns 
  avg: 0.002376 
  min: 0.002357 
  max: 0.002398 
  75%: 0.002385 
  95%: 0.002395 
  99%: 0.002398
time_connect 
  avg: 0.011098 
  min: 0.011050 
  max: 0.011168 
  75%: 0.011122 
  95%: 0.011159 
  99%: 0.011166
time_appconnect 
  avg: 0.038319 
  min: 0.035893 
  max: 0.039665 
  75%: 0.039531 
  95%: 0.039638 
  99%: 0.039660
time_pretransfer 
  avg: 0.038402 
  min: 0.035983 
  max: 0.039746 
  75%: 0.039611 
  95%: 0.039719 
  99%: 0.039741
time_ttfb 
  avg: 0.085571 
  min: 0.065458 
  max: 0.118985 
  75%: 0.095628 
  95%: 0.114314 
  99%: 0.118051
time_total 
  avg: 0.096128 
  min: 0.076570 
  max: 0.128668 
  75%: 0.105907 
  95%: 0.124116 
  99%: 0.127758

time_dns
avg:,min:,max:,75%:,95%:,99%:
0.002376,0.002357,0.002398,0.002385,0.002395,0.002398
time_connect
avg:,min:,max:,75%:,95%:,99%:
0.011098,0.011050,0.011168,0.011122,0.011159,0.011166
time_appconnect
avg:,min:,max:,75%:,95%:,99%:
0.038319,0.035893,0.039665,0.039531,0.039638,0.039660
time_pretransfer
avg:,min:,max:,75%:,95%:,99%:
0.038402,0.035983,0.039746,0.039611,0.039719,0.039741
time_ttfb
avg:,min:,max:,75%:,95%:,99%:
0.085571,0.065458,0.118985,0.095628,0.114314,0.118051
time_total
avg:,min:,max:,75%:,95%:,99%:
0.096128,0.076570,0.128668,0.105907,0.124116,0.127758
```

csv-max-sum output with TLS 1.3 max

```
./curltimes.sh csv-max-sum https://servermanager.guide
curl 7.72.0-DEV
TLSv1.3 TLS_AES_128_GCM_SHA256
HTTP/2
Connected to servermanager.guide (2606:4700:10::ac43:26be) port 443 (#0)
Sample Size: 3

0.002424,0.011107,0.036438,0.036519,0.075756,0.085843
0.002414,0.011172,0.031391,0.031478,0.094687,0.106812
0.002418,0.011124,0.028043,0.028126,0.058862,0.067525

time_dns 
  avg: 0.002419 
  min: 0.002414 
  max: 0.002424 
  75%: 0.002421 
  95%: 0.002423 
  99%: 0.002424
time_connect 
  avg: 0.011134 
  min: 0.011107 
  max: 0.011172 
  75%: 0.011148 
  95%: 0.011167 
  99%: 0.011171
time_appconnect 
  avg: 0.031957 
  min: 0.028043 
  max: 0.036438 
  75%: 0.033914 
  95%: 0.035933 
  99%: 0.036337
time_pretransfer 
  avg: 0.032041 
  min: 0.028126 
  max: 0.036519 
  75%: 0.033999 
  95%: 0.036015 
  99%: 0.036418
time_ttfb 
  avg: 0.076435 
  min: 0.058862 
  max: 0.094687 
  75%: 0.085221 
  95%: 0.092794 
  99%: 0.094308
time_total 
  avg: 0.086727 
  min: 0.067525 
  max: 0.106812 
  75%: 0.096327 
  95%: 0.104715 
  99%: 0.106393

time_dns
avg:,min:,max:,75%:,95%:,99%:
0.002419,0.002414,0.002424,0.002421,0.002423,0.002424
time_connect
avg:,min:,max:,75%:,95%:,99%:
0.011134,0.011107,0.011172,0.011148,0.011167,0.011171
time_appconnect
avg:,min:,max:,75%:,95%:,99%:
0.031957,0.028043,0.036438,0.033914,0.035933,0.036337
time_pretransfer
avg:,min:,max:,75%:,95%:,99%:
0.032041,0.028126,0.036519,0.033999,0.036015,0.036418
time_ttfb
avg:,min:,max:,75%:,95%:,99%:
0.076435,0.058862,0.094687,0.085221,0.092794,0.094308
time_total
avg:,min:,max:,75%:,95%:,99%:
0.086727,0.067525,0.106812,0.096327,0.104715,0.106393
```

## TLS 1.2 vs TLS 1.3 for 11 run diff compare

```
domain=servermanager.guide
time diff -u <(./curltimes.sh csv-sum https://$domain) <(./curltimes.sh csv-max-sum https://$domain)
```

```
domain=servermanager.guide
diff -u <(./curltimes.sh csv-sum https://$domain) <(./curltimes.sh csv-max-sum https://$domain)
--- /dev/fd/63  2020-08-02 15:41:20.076432930 +0000
+++ /dev/fd/62  2020-08-02 15:41:20.076432930 +0000
@@ -1,79 +1,79 @@
 curl 7.72.0-DEV
-TLSv1.2 ECDHE-ECDSA-AES128-GCM-SHA256
+TLSv1.3 TLS_AES_128_GCM_SHA256
 HTTP/2
 Connected to servermanager.guide (2606:4700:10::ac43:26be) port 443 (#0)
 Sample Size: 11
 
-0.002086,0.010925,0.039349,0.039412,0.061752,0.070582
-0.016048,0.024703,0.049378,0.049448,0.072024,0.082618
-0.002058,0.013117,0.045515,0.04558,0.07679,0.087828
-0.002365,0.011059,0.036608,0.036681,0.064407,0.074101
-0.00203,0.013137,0.042183,0.042256,0.083748,0.094793
-0.002332,0.01097,0.040162,0.040237,0.069451,0.084052
-0.002474,0.013477,0.042745,0.042822,0.076324,0.087355
-0.002412,0.013498,0.043301,0.043387,0.078342,0.08941
-0.002097,0.010752,0.038062,0.038142,0.062925,0.071653
-0.002408,0.011047,0.037419,0.037505,0.083901,0.092594
-0.002362,0.011053,0.035654,0.035739,0.062397,0.070945
+0.002156,0.010861,0.030099,0.030189,0.055778,0.064398
+0.002351,0.01101,0.02935,0.029436,0.07048,0.079202
+0.002376,0.011048,0.026607,0.026692,0.060207,0.070634
+0.002067,0.013079,0.032868,0.032955,0.076456,0.087279
+0.002086,0.010766,0.026963,0.027075,0.054239,0.065088
+0.00211,0.010792,0.028849,0.028937,0.065903,0.077386
+0.002032,0.010668,0.026672,0.026752,0.052249,0.061391
+0.002372,0.011104,0.027138,0.027222,0.047584,0.057748
+0.002071,0.013085,0.032123,0.032204,0.067435,0.078523
+0.002352,0.011048,0.027847,0.027927,0.052574,0.063585
+0.002513,0.011245,0.027636,0.027726,0.053087,0.064615
 
 time_dns 
-  avg: 0.003516 
-  min: 0.002030 
-  max: 0.016048 
-  75%: 0.002410 
-  95%: 0.009261 
-  99%: 0.014691
+  avg: 0.002226 
+  min: 0.002032 
+  max: 0.002513 
+  75%: 0.002362 
+  95%: 0.002445 
+  99%: 0.002499
 time_connect 
-  avg: 0.013067 
-  min: 0.010752 
-  max: 0.024703 
-  75%: 0.013307 
-  95%: 0.019101 
-  99%: 0.023582
+  avg: 0.011337 
+  min: 0.010668 
+  max: 0.013085 
+  75%: 0.011174 
+  95%: 0.013082 
+  99%: 0.013084
 time_appconnect 
-  avg: 0.040943 
-  min: 0.035654 
-  max: 0.049378 
-  75%: 0.043023 
-  95%: 0.047447 
-  99%: 0.048992
+  avg: 0.028741 
+  min: 0.026607 
+  max: 0.032868 
+  75%: 0.029724 
+  95%: 0.032496 
+  99%: 0.032794
 time_pretransfer 
-  avg: 0.041019 
-  min: 0.035739 
-  max: 0.049448 
-  75%: 0.043104 
-  95%: 0.047514 
-  99%: 0.049061
+  avg: 0.028829 
+  min: 0.026692 
+  max: 0.032955 
+  75%: 0.029813 
+  95%: 0.032580 
+  99%: 0.032880
 time_ttfb 
-  avg: 0.072006 
-  min: 0.061752 
-  max: 0.083901 
-  75%: 0.077566 
-  95%: 0.083824 
-  99%: 0.083886
+  avg: 0.059636 
+  min: 0.047584 
+  max: 0.076456 
+  75%: 0.066669 
+  95%: 0.073468 
+  99%: 0.075858
 time_total 
-  avg: 0.082357 
-  min: 0.070582 
-  max: 0.094793 
-  75%: 0.088619 
-  95%: 0.093694 
-  99%: 0.094573
+  avg: 0.069986 
+  min: 0.057748 
+  max: 0.087279 
+  75%: 0.077955 
+  95%: 0.083240 
+  99%: 0.086471
 
 time_dns
 avg:,min:,max:,75%:,95%:,99%:
-0.003516,0.002030,0.016048,0.002410,0.009261,0.014691
+0.002226,0.002032,0.002513,0.002362,0.002445,0.002499
 time_connect
 avg:,min:,max:,75%:,95%:,99%:
-0.013067,0.010752,0.024703,0.013307,0.019101,0.023582
+0.011337,0.010668,0.013085,0.011174,0.013082,0.013084
 time_appconnect
 avg:,min:,max:,75%:,95%:,99%:
-0.040943,0.035654,0.049378,0.043023,0.047447,0.048992
+0.028741,0.026607,0.032868,0.029724,0.032496,0.032794
 time_pretransfer
 avg:,min:,max:,75%:,95%:,99%:
-0.041019,0.035739,0.049448,0.043104,0.047514,0.049061
+0.028829,0.026692,0.032955,0.029813,0.032580,0.032880
 time_ttfb
 avg:,min:,max:,75%:,95%:,99%:
-0.072006,0.061752,0.083901,0.077566,0.083824,0.083886
+0.059636,0.047584,0.076456,0.066669,0.073468,0.075858
 time_total
 avg:,min:,max:,75%:,95%:,99%:
-0.082357,0.070582,0.094793,0.088619,0.093694,0.094573
+0.069986,0.057748,0.087279,0.077955,0.083240,0.086471
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
Connected to servermanager.guide (2606:4700:10::6816:43fa) port 443 (#0)
Sample Size: 3

0.0025,0.015368,0,0.015431,0.040399,0.050602
0.00255,0.017602,0,0.017667,0.046013,0.057848
0.002407,0.016189,0,0.016252,0.069789,0.08331

time_dns 
  avg: 0.002486 
  min: 0.002407 
  max: 0.002550 
  75%: 0.002525 
  95%: 0.002545 
  99%: 0.002549
time_connect 
  avg: 0.016386 
  min: 0.015368 
  max: 0.017602 
  75%: 0.016896 
  95%: 0.017461 
  99%: 0.017574
time_appconnect 
  avg: 0.000000 
  min: 0.000000 
  max: 0.000000 
  75%: 0.000000 
  95%: 0.000000 
  99%: 0.000000
time_pretransfer 
  avg: 0.016450 
  min: 0.015431 
  max: 0.017667 
  75%: 0.016959 
  95%: 0.017525 
  99%: 0.017639
time_ttfb 
  avg: 0.052067 
  min: 0.040399 
  max: 0.069789 
  75%: 0.057901 
  95%: 0.067411 
  99%: 0.069313
time_total 
  avg: 0.063920 
  min: 0.050602 
  max: 0.083310 
  75%: 0.070579 
  95%: 0.080764 
  99%: 0.082801

time_dns
avg:,min:,max:,75%:,95%:,99%:
0.002486,0.002407,0.002550,0.002525,0.002545,0.002549
time_connect
avg:,min:,max:,75%:,95%:,99%:
0.016386,0.015368,0.017602,0.016896,0.017461,0.017574
time_appconnect
avg:,min:,max:,75%:,95%:,99%:
0.000000,0.000000,0.000000,0.000000,0.000000,0.000000
time_pretransfer
avg:,min:,max:,75%:,95%:,99%:
0.016450,0.015431,0.017667,0.016959,0.017525,0.017639
time_ttfb
avg:,min:,max:,75%:,95%:,99%:
0.052067,0.040399,0.069789,0.057901,0.067411,0.069313
time_total
avg:,min:,max:,75%:,95%:,99%:
0.063920,0.050602,0.083310,0.070579,0.080764,0.082801
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
--- curl-http2-tls13.txt        2020-08-02 15:44:32.147887667 +0000
+++ curl-http3-quic.txt 2020-08-02 15:44:43.654974621 +0000
@@ -1,71 +1,70 @@
 curl 7.72.0-DEV
-TLSv1.3 TLS_AES_128_GCM_SHA256
-HTTP/2
-Connected to servermanager.guide (2606:4700:10::ac43:26be) port 443 (#0)
+HTTP/3
+Connected to servermanager.guide (2606:4700:10::6816:42fa) port 443 (#0)
 Sample Size: 3
 
-0.002384,0.011039,0.02733,0.027411,0.049081,0.058623
-0.002601,0.011241,0.029238,0.029319,0.06425,0.071877
-0.002374,0.011087,0.030884,0.030965,0.06536,0.080281
+0.002144,0.013619,0,0.013682,0.036161,0.0472
+0.002376,0.01884,0,0.018905,0.046857,0.060352
+0.00233,0.016841,0,0.016903,0.046658,0.058
 
 time_dns 
-  avg: 0.002453 
-  min: 0.002374 
-  max: 0.002601 
-  75%: 0.002492 
-  95%: 0.002579 
-  99%: 0.002597
+  avg: 0.002283 
+  min: 0.002144 
+  max: 0.002376 
+  75%: 0.002353 
+  95%: 0.002371 
+  99%: 0.002375
 time_connect 
-  avg: 0.011122 
-  min: 0.011039 
-  max: 0.011241 
-  75%: 0.011164 
-  95%: 0.011226 
-  99%: 0.011238
+  avg: 0.016433 
+  min: 0.013619 
+  max: 0.018840 
+  75%: 0.017840 
+  95%: 0.018640 
+  99%: 0.018800
 time_appconnect 
-  avg: 0.029151 
-  min: 0.027330 
-  max: 0.030884 
-  75%: 0.030061 
-  95%: 0.030719 
-  99%: 0.030851
+  avg: 0.000000 
+  min: 0.000000 
+  max: 0.000000 
+  75%: 0.000000 
+  95%: 0.000000 
+  99%: 0.000000
 time_pretransfer 
-  avg: 0.029232 
-  min: 0.027411 
-  max: 0.030965 
-  75%: 0.030142 
-  95%: 0.030800 
-  99%: 0.030932
+  avg: 0.016497 
+  min: 0.013682 
+  max: 0.018905 
+  75%: 0.017904 
+  95%: 0.018705 
+  99%: 0.018865
 time_ttfb 
-  avg: 0.059564 
-  min: 0.049081 
-  max: 0.065360 
-  75%: 0.064805 
-  95%: 0.065249 
-  99%: 0.065338
+  avg: 0.043225 
+  min: 0.036161 
+  max: 0.046857 
+  75%: 0.046758 
+  95%: 0.046837 
+  99%: 0.046853
 time_total 
-  avg: 0.070260 
-  min: 0.058623 
-  max: 0.080281 
-  75%: 0.076079 
-  95%: 0.079441 
-  99%: 0.080113
+  avg: 0.055184 
+  min: 0.047200 
+  max: 0.060352 
+  75%: 0.059176 
+  95%: 0.060117 
+  99%: 0.060305
 
 time_dns
 avg:,min:,max:,75%:,95%:,99%:
-0.002453,0.002374,0.002601,0.002492,0.002579,0.002597
+0.002283,0.002144,0.002376,0.002353,0.002371,0.002375
 time_connect
 avg:,min:,max:,75%:,95%:,99%:
-0.011122,0.011039,0.011241,0.011164,0.011226,0.011238
+0.016433,0.013619,0.018840,0.017840,0.018640,0.018800
 time_appconnect
 avg:,min:,max:,75%:,95%:,99%:
-0.029151,0.027330,0.030884,0.030061,0.030719,0.030851
+0.000000,0.000000,0.000000,0.000000,0.000000,0.000000
 time_pretransfer
 avg:,min:,max:,75%:,95%:,99%:
-0.029232,0.027411,0.030965,0.030142,0.030800,0.030932
+0.016497,0.013682,0.018905,0.017904,0.018705,0.018865
 time_ttfb
 avg:,min:,max:,75%:,95%:,99%:
-0.059564,0.049081,0.065360,0.064805,0.065249,0.065338
+0.043225,0.036161,0.046857,0.046758,0.046837,0.046853
 time_total
 avg:,min:,max:,75%:,95%:,99%:
-0.070260,0.058623,0.080281,0.076079,0.079441,0.080113
+0.055184,0.047200,0.060352,0.059176,0.060117,0.060305
```