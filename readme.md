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

