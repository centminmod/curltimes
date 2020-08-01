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
0.002443,0.011085,0.03813,0.038216,0.091028,0.099822
0.029309,0.037939,0.062301,0.062391,0.098335,0.107398
0.002437,0.011091,0.036944,0.037036,0.073659,0.082268

time_dns 
  avg: 0.011396 
  min: 0.002437 
  max: 0.029309 
  75%: 0.015876 
  95%: 0.026622 
  99%: 0.028772
time_connect 
  avg: 0.020038 
  min: 0.011085 
  max: 0.037939 
  75%: 0.024515 
  95%: 0.035254 
  99%: 0.037402
time_appconnect 
  avg: 0.045792 
  min: 0.036944 
  max: 0.062301 
  75%: 0.050216 
  95%: 0.059884 
  99%: 0.061818
time_pretransfer 
  avg: 0.045881 
  min: 0.037036 
  max: 0.062391 
  75%: 0.050303 
  95%: 0.059973 
  99%: 0.061908
time_ttfb 
  avg: 0.087674 
  min: 0.073659 
  max: 0.098335 
  75%: 0.094682 
  95%: 0.097604 
  99%: 0.098189
time_total 
  avg: 0.096496 
  min: 0.082268 
  max: 0.107398 
  75%: 0.103610 
  95%: 0.106640 
  99%: 0.107246
```

csv-max-sum output with TLS 1.3 max

```
./curltimes.sh csv-max-sum https://servermanager.guide
0.002473,0.011639,0.029031,0.029115,0.071661,0.080172
0.00245,0.011071,0.035939,0.036024,0.061988,0.070745
0.002439,0.011084,0.030739,0.030818,0.072012,0.080537

time_dns 
  avg: 0.002454 
  min: 0.002439 
  max: 0.002473 
  75%: 0.002462 
  95%: 0.002471 
  99%: 0.002473
time_connect 
  avg: 0.011265 
  min: 0.011071 
  max: 0.011639 
  75%: 0.011362 
  95%: 0.011583 
  99%: 0.011628
time_appconnect 
  avg: 0.031903 
  min: 0.029031 
  max: 0.035939 
  75%: 0.033339 
  95%: 0.035419 
  99%: 0.035835
time_pretransfer 
  avg: 0.031986 
  min: 0.029115 
  max: 0.036024 
  75%: 0.033421 
  95%: 0.035503 
  99%: 0.035920
time_ttfb 
  avg: 0.068554 
  min: 0.061988 
  max: 0.072012 
  75%: 0.071836 
  95%: 0.071977 
  99%: 0.072005
time_total 
  avg: 0.077151 
  min: 0.070745 
  max: 0.080537 
  75%: 0.080355 
  95%: 0.080501 
  99%: 0.080530
```

TLS 1.2 vs TLS 1.3 for 11 run diff compare

```
diff -u <(./curltimes.sh csv-sum https://servermanager.guide) <(./curltimes.sh csv-max-sum https://servermanager.guide)
--- /dev/fd/63  2020-08-01 01:37:23.139647846 +0000
+++ /dev/fd/62  2020-08-01 01:37:23.139647846 +0000
@@ -1,54 +1,54 @@
-0.002793,0.011498,0.040593,0.040668,0.075049,0.083886
-0.002357,0.010951,0.035597,0.035664,0.060721,0.0708
-0.002343,0.010978,0.035879,0.035952,0.075469,0.084651
-0.002105,0.010717,0.034777,0.034859,0.058343,0.067108
-0.002417,0.01102,0.037045,0.037128,0.069506,0.078666
-0.002519,0.011145,0.039353,0.039437,0.072045,0.080812
-0.002147,0.010832,0.038355,0.038439,0.061275,0.070189
-0.002528,0.011124,0.036001,0.036082,0.056993,0.065679
-0.002115,0.010781,0.039306,0.03939,0.062978,0.074005
-0.00243,0.011122,0.035568,0.035648,0.063292,0.072415
-0.002486,0.01121,0.039248,0.039333,0.09184,0.103427
+0.002507,0.011134,0.029838,0.02992,0.067617,0.078373
+0.002176,0.010872,0.027524,0.027613,0.050671,0.059275
+0.002105,0.010874,0.026589,0.026672,0.050521,0.059335
+0.002375,0.011005,0.028734,0.028813,0.052322,0.060942
+0.002483,0.011135,0.029167,0.029248,0.065675,0.076821
+0.002433,0.011146,0.027127,0.027216,0.051383,0.06018
+0.002314,0.010981,0.031332,0.031417,0.052209,0.06123
+0.002461,0.011158,0.027324,0.027404,0.06099,0.069817
+0.002484,0.011206,0.027001,0.027078,0.04792,0.056714
+0.002514,0.011203,0.02702,0.0271,0.051096,0.06092
+0.002387,0.011072,0.026462,0.026542,0.048125,0.056722
 
 time_dns 
   avg: 0.002385 
   min: 0.002105 
-  max: 0.002793 
-  75%: 0.002502 
-  95%: 0.002660 
-  99%: 0.002767
+  max: 0.002514 
+  75%: 0.002483 
+  95%: 0.002511 
+  99%: 0.002513
 time_connect 
-  avg: 0.011034 
-  min: 0.010717 
-  max: 0.011498 
-  75%: 0.011135 
-  95%: 0.011354 
-  99%: 0.011469
+  avg: 0.011071 
+  min: 0.010872 
+  max: 0.011206 
+  75%: 0.011152 
+  95%: 0.011204 
+  99%: 0.011206
 time_appconnect 
-  avg: 0.037429 
-  min: 0.034777 
-  max: 0.040593 
-  75%: 0.039277 
-  95%: 0.039973 
-  99%: 0.040469
+  avg: 0.028011 
+  min: 0.026462 
+  max: 0.031332 
+  75%: 0.028951 
+  95%: 0.030585 
+  99%: 0.031183
 time_pretransfer 
-  avg: 0.037509 
-  min: 0.034859 
-  max: 0.040668 
-  75%: 0.039362 
-  95%: 0.040053 
-  99%: 0.040545
+  avg: 0.028093 
+  min: 0.026542 
+  max: 0.031417 
+  75%: 0.029030 
+  95%: 0.030669 
+  99%: 0.031267
 time_ttfb 
-  avg: 0.067956 
-  min: 0.056993 
-  max: 0.091840 
-  75%: 0.073547 
-  95%: 0.083654 
-  99%: 0.090203
+  avg: 0.054412 
+  min: 0.047920 
+  max: 0.067617 
+  75%: 0.056656 
+  95%: 0.066646 
+  99%: 0.067423
 time_total 
-  avg: 0.077422 
-  min: 0.065679 
-  max: 0.103427 
-  75%: 0.082349 
-  95%: 0.094039 
-  99%: 0.101549
+  avg: 0.063666 
+  min: 0.056714 
+  max: 0.078373 
+  75%: 0.065523 
+  95%: 0.077597 
+  99%: 0.078218
```