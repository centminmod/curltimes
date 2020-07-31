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
["DNS","Connect","SSL","Wait","TTFB","Total Time"]
{
        "time_dns":             0.002564,
        "time_connect":         0.011402,
        "time_appconnect":      0.038828,
        "time_pretransfer":     0.038916,
        "time_ttfb":            0.095125,
        "time_total":           0.103974
}{
        "time_dns":             0.002488,
        "time_connect":         0.011142,
        "time_appconnect":      0.034979,
        "time_pretransfer":     0.035068,
        "time_ttfb":            0.071230,
        "time_total":           0.080085
}{
        "time_dns":             0.002347,
        "time_connect":         0.011030,
        "time_appconnect":      0.038583,
        "time_pretransfer":     0.038665,
        "time_ttfb":            0.081110,
        "time_total":           0.090616
}
```

json output with TLS 1.3 max

```
./curltimes.sh json-max https://servermanager.guide
["DNS","Connect","SSL","Wait","TTFB","Total Time"]
{
        "time_dns":             0.002475,
        "time_connect":         0.011114,
        "time_appconnect":      0.032894,
        "time_pretransfer":     0.032987,
        "time_ttfb":            0.070362,
        "time_total":           0.078909
}{
        "time_dns":             0.016671,
        "time_connect":         0.025292,
        "time_appconnect":      0.041496,
        "time_pretransfer":     0.041585,
        "time_ttfb":            0.078091,
        "time_total":           0.084820
}{
        "time_dns":             0.002357,
        "time_connect":         0.011059,
        "time_appconnect":      0.027810,
        "time_pretransfer":     0.027896,
        "time_ttfb":            0.070568,
        "time_total":           0.079413
}
```

csv output with TLS 1.2 max

```
./curltimes.sh csv https://servermanager.guide        
["DNS","Connect","SSL","Wait","TTFB","Total Time"]
0.002499,0.011232,0.038939,0.039032,0.070107,0.078926
0.002468,0.011151,0.045335,0.04542,0.093941,0.102807
0.002477,0.011191,0.037536,0.037619,0.065233,0.075599
```

csv output with TLS 1.3 max

```
./curltimes.sh csv-max https://servermanager.guide
["DNS","Connect","SSL","Wait","TTFB","Total Time"]
0.014534,0.023231,0.03993,0.040021,0.069676,0.078247
0.00241,0.011095,0.027924,0.028012,0.061294,0.069808
0.002393,0.011048,0.02692,0.027,0.055102,0.064368
```

# process metrics

Using datamash to provide summary metrics for all recorded data points

csv-sum output with TLS 1.2 max

```
./curltimes.sh csv-sum https://servermanager.guide
0.002425,0.013451,0.045165,0.04526,0.079429,0.090453
0.014442,0.023072,0.05839,0.058489,0.139876,0.1484
0.002447,0.013489,0.046266,0.046346,0.077947,0.089026

time_dns 
  avg: 0.006438 
  75%: 0.008445 
  95%: 0.013243 
  99%: 0.014202
time_connect 
  avg: 0.016671 
  75%: 0.018280 
  95%: 0.022114 
  99%: 0.022880
time_appconnect 
  avg: 0.049940 
  75%: 0.052328 
  95%: 0.057178 
  99%: 0.058148
time_pretransfer 
  avg: 0.050032 
  75%: 0.052417 
  95%: 0.057275 
  99%: 0.058246
time_ttfb 
  avg: 0.099084 
  75%: 0.109653 
  95%: 0.133831 
  99%: 0.138667
time_total 
  avg: 0.109293 
  75%: 0.119427 
  95%: 0.142605 
  99%: 0.147241
```

csv-max-sum output with TLS 1.3 max

```
./curltimes.sh csv-max-sum https://servermanager.guide
0.016019,0.024661,0.04067,0.040751,0.064754,0.073274
0.015788,0.024409,0.040488,0.04057,0.07291,0.081702
0.002531,0.013651,0.03364,0.033721,0.080423,0.091439

time_dns 
  avg: 0.011446 
  75%: 0.015903 
  95%: 0.015996 
  99%: 0.016014
time_connect 
  avg: 0.020907 
  75%: 0.024535 
  95%: 0.024636 
  99%: 0.024656
time_appconnect 
  avg: 0.038266 
  75%: 0.040579 
  95%: 0.040652 
  99%: 0.040666
time_pretransfer 
  avg: 0.038347 
  75%: 0.040661 
  95%: 0.040733 
  99%: 0.040747
time_ttfb 
  avg: 0.072696 
  75%: 0.076667 
  95%: 0.079672 
  99%: 0.080273
time_total 
  avg: 0.082138 
  75%: 0.086570 
  95%: 0.090465 
  99%: 0.091244
```

TLS 1.2 vs TLS 1.3 for 11 run diff compare

```
diff -u <(./curltimes.sh csv-sum https://servermanager.guide) <(./curltimes.sh csv-max-sum https://servermanager.guide)
--- /dev/fd/63  2020-07-31 14:36:50.113495652 +0000
+++ /dev/fd/62  2020-07-31 14:36:50.113495652 +0000
@@ -1,42 +1,42 @@
-0.014179,0.022791,0.050991,0.051075,0.083474,0.095402
-0.00242,0.011147,0.036267,0.036346,0.082782,0.091653
-0.002368,0.011006,0.036785,0.036865,0.066076,0.075064
-0.002392,0.011075,0.035892,0.035976,0.06412,0.072754
-0.002353,0.013372,0.045943,0.046026,0.089654,0.103919
-0.00248,0.011166,0.035609,0.035708,0.066517,0.075388
-0.002378,0.010993,0.036221,0.036312,0.065143,0.074235
-0.002434,0.011104,0.038448,0.03853,0.06966,0.078562
-0.002442,0.011224,0.035736,0.03583,0.058559,0.067462
-0.002091,0.010718,0.034698,0.034778,0.073836,0.082425
-0.002501,0.011211,0.039685,0.039775,0.076387,0.085378
+0.00247,0.011104,0.028503,0.028594,0.073683,0.08123
+0.002438,0.011094,0.027749,0.027832,0.070632,0.079208
+0.002468,0.011123,0.029399,0.029479,0.050454,0.059034
+0.002453,0.011051,0.026581,0.026664,0.054084,0.062998
+0.002388,0.01102,0.028404,0.028482,0.052649,0.061149
+0.002637,0.013635,0.031293,0.031372,0.062619,0.073556
+0.002453,0.011132,0.026853,0.026931,0.053215,0.060608
+0.002367,0.010952,0.027005,0.027083,0.05777,0.066542
+0.002361,0.010983,0.027233,0.027315,0.055967,0.064518
+0.002106,0.010803,0.02797,0.02805,0.056,0.064843
+0.015235,0.023932,0.044812,0.044891,0.089042,0.099514
 
 time_dns 
-  avg: 0.003458 
-  75%: 0.002461 
-  95%: 0.008340 
-  99%: 0.013011
+  avg: 0.003580 
+  75%: 0.002469 
+  95%: 0.008936 
+  99%: 0.013975
 time_connect 
-  avg: 0.012346 
-  75%: 0.011217 
-  95%: 0.018081 
-  99%: 0.021849
+  avg: 0.012439 
+  75%: 0.011128 
+  95%: 0.018784 
+  99%: 0.022902
 time_appconnect 
-  avg: 0.038752 
-  75%: 0.039066 
-  95%: 0.048467 
-  99%: 0.050486
+  avg: 0.029618 
+  75%: 0.028951 
+  95%: 0.038053 
+  99%: 0.043460
 time_pretransfer 
-  avg: 0.038838 
-  75%: 0.039152 
-  95%: 0.048551 
-  99%: 0.050570
+  avg: 0.029699 
+  75%: 0.029037 
+  95%: 0.038131 
+  99%: 0.043539
 time_ttfb 
-  avg: 0.072383 
-  75%: 0.079585 
-  95%: 0.086564 
-  99%: 0.089036
+  avg: 0.061465 
+  75%: 0.066626 
+  95%: 0.081363 
+  99%: 0.087506
 time_total 
-  avg: 0.082022 
-  75%: 0.088516 
-  95%: 0.099661 
-  99%: 0.103067
+  avg: 0.070291 
+  75%: 0.076382 
+  95%: 0.090372 
+  99%: 0.097686
```