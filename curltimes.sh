#!/bin/bash
############################################################
# https://nooshu.github.io/blog/2020/07/30/measuring-tls-13-ipv4-ipv6-performance/
############################################################
total=3
bin='/usr/bin/curl'
#bin='/usr/local/src/curl/src/curl'
dt=$(date +"%d%m%y-%H%M%S")

# IPv4 / IPv6
force_ipv4='n'

# HTTP/3 curl
http3='n'
bin_http3='/usr/local/src/curl/src/curl'
library_path_http3='/usr/lib/x86_64-linux-gnu'
############################################################
if [ "$curlruns" ]; then
  total=$curlruns
else
  total=$total
fi
if [ "$ipv4" == 1 ]; then
  force_ipv4='y'
else
  force_ipv4=$force_ipv4
fi
if [ "$h3" == 1 ]; then
  http3='y'
else
  http3=$http3
fi
if [ "$bin_h3" ]; then
  bin="$bin_h3"
  bin_http3="$bin_h3"
else
  bin="$bin"
  bin_http3="$bin_http3"
fi
if [ "$lib_h3" ]; then
  library_path_http3="$lib_h3"
else
  library_path_http3="$library_path_http3"
fi

if [[ -f /usr/bin/yum && ! -f /usr/bin/datamash ]]; then
  yum -y -q install datamash >/dev/null 2>&1
fi
if [[ -f /usr/bin/apt-get && ! -f /usr/bin/datamash ]]; then
  apt-get -y -q install datamash >/dev/null 2>&1
  fi
if [ -f /usr/local/http2-15/bin/curl ] && [[ "$bin" != '/usr/local/src/curl/src/curl' ]]; then
  bin='/usr/local/http2-15/bin/curl'
fi
if [[ "$bin" = '/usr/local/http2-15/bin/curl' || -d /usr/local/http2-15/lib ]] && [[ "$bin" != '/usr/local/src/curl/src/curl' ]]; then
  export LD_LIBRARY_PATH=/usr/local/http2-15/lib
fi
if [[ "$bin" = "$bin_http3" || -d "${library_path_http3}" ]]; then
  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${library_path_http3}
fi
if [[ "$force_ipv4" = [yY] ]]; then
  curlip_opt='-4 '
else
  curlip_opt=
fi

curl_format='{
        "time_dns":             %{time_namelookup},
        "time_connect":         %{time_connect},
        "time_appconnect":      %{time_appconnect},
        "time_pretransfer":     %{time_pretransfer},
        "time_ttfb":            %{time_starttransfer},
        "time_total":           %{time_total}
}'

header() {
  echo 'DNS,Connect,SSL,Wait,TTFB,Total Time'
}

header_summary() {
  echo "avg:,median:,min:,max:,75%:,95%:,99%:"
}

processlog() {
  display=$1
  time_dns=$(cat $datalog | awk -F ',' '{print $1}' | datamash -t, --no-strict --filler 0 mean 1)
  time_dns=$(printf "%.6f\n" $time_dns)
  time_connect=$(cat $datalog | awk -F ',' '{print $2}' | datamash -t, --no-strict --filler 0 mean 1)
  time_connect=$(printf "%.6f\n" $time_connect)
  time_appconnect=$(cat $datalog | awk -F ',' '{print $3}' | datamash -t, --no-strict --filler 0 mean 1)
  time_appconnect=$(printf "%.6f\n" $time_appconnect)
  time_pretransfer=$(cat $datalog | awk -F ',' '{print $4}' | datamash -t, --no-strict --filler 0 mean 1)
  time_pretransfer=$(printf "%.6f\n" $time_pretransfer)
  time_ttfb=$(cat $datalog | awk -F ',' '{print $5}' | datamash -t, --no-strict --filler 0 mean 1)
  time_ttfb=$(printf "%.6f\n" $time_ttfb)
  time_total=$(cat $datalog | awk -F ',' '{print $6}' | datamash -t, --no-strict --filler 0 mean 1)
  time_total=$(printf "%.6f\n" $time_total)

  time_dns_median=$(cat $datalog | awk -F ',' '{print $1}' | datamash -t, --no-strict --filler 0 median 1)
  time_dns_median=$(printf "%.6f\n" $time_dns_median)
  time_connect_median=$(cat $datalog | awk -F ',' '{print $2}' | datamash -t, --no-strict --filler 0 median 1)
  time_connect_median=$(printf "%.6f\n" $time_connect_median)
  time_appconnect_median=$(cat $datalog | awk -F ',' '{print $3}' | datamash -t, --no-strict --filler 0 median 1)
  time_appconnect_median=$(printf "%.6f\n" $time_appconnect_median)
  time_pretransfer_median=$(cat $datalog | awk -F ',' '{print $4}' | datamash -t, --no-strict --filler 0 median 1)
  time_pretransfer_median=$(printf "%.6f\n" $time_pretransfer_median)
  time_ttfb_median=$(cat $datalog | awk -F ',' '{print $5}' | datamash -t, --no-strict --filler 0 median 1)
  time_ttfb_median=$(printf "%.6f\n" $time_ttfb_median)
  time_total_median=$(cat $datalog | awk -F ',' '{print $6}' | datamash -t, --no-strict --filler 0 median 1)
  time_total_median=$(printf "%.6f\n" $time_total_median)

  time_dns_min=$(cat $datalog | awk -F ',' '{print $1}' | datamash -t, --no-strict --filler 0 min 1)
  time_dns_min=$(printf "%.6f\n" $time_dns_min)
  time_connect_min=$(cat $datalog | awk -F ',' '{print $2}' | datamash -t, --no-strict --filler 0 min 1)
  time_connect_min=$(printf "%.6f\n" $time_connect_min)
  time_appconnect_min=$(cat $datalog | awk -F ',' '{print $3}' | datamash -t, --no-strict --filler 0 min 1)
  time_appconnect_min=$(printf "%.6f\n" $time_appconnect_min)
  time_pretransfer_min=$(cat $datalog | awk -F ',' '{print $4}' | datamash -t, --no-strict --filler 0 min 1)
  time_pretransfer_min=$(printf "%.6f\n" $time_pretransfer_min)
  time_ttfb_min=$(cat $datalog | awk -F ',' '{print $5}' | datamash -t, --no-strict --filler 0 min 1)
  time_ttfb_min=$(printf "%.6f\n" $time_ttfb_min)
  time_total_min=$(cat $datalog | awk -F ',' '{print $6}' | datamash -t, --no-strict --filler 0 min 1)
  time_total_min=$(printf "%.6f\n" $time_total_min)

  time_dns_max=$(cat $datalog | awk -F ',' '{print $1}' | datamash -t, --no-strict --filler 0 max 1)
  time_dns_max=$(printf "%.6f\n" $time_dns_max)
  time_connect_max=$(cat $datalog | awk -F ',' '{print $2}' | datamash -t, --no-strict --filler 0 max 1)
  time_connect_max=$(printf "%.6f\n" $time_connect_max)
  time_appconnect_max=$(cat $datalog | awk -F ',' '{print $3}' | datamash -t, --no-strict --filler 0 max 1)
  time_appconnect_max=$(printf "%.6f\n" $time_appconnect_max)
  time_pretransfer_max=$(cat $datalog | awk -F ',' '{print $4}' | datamash -t, --no-strict --filler 0 max 1)
  time_pretransfer_max=$(printf "%.6f\n" $time_pretransfer_max)
  time_ttfb_max=$(cat $datalog | awk -F ',' '{print $5}' | datamash -t, --no-strict --filler 0 max 1)
  time_ttfb_max=$(printf "%.6f\n" $time_ttfb_max)
  time_total_max=$(cat $datalog | awk -F ',' '{print $6}' | datamash -t, --no-strict --filler 0 max 1)
  time_total_max=$(printf "%.6f\n" $time_total_max)

  time_dns_75=$(cat $datalog | awk -F ',' '{print $1}' | datamash -t, --no-strict --filler 0 perc:75 1)
  time_dns_75=$(printf "%.6f\n" $time_dns_75)
  time_connect_75=$(cat $datalog | awk -F ',' '{print $2}' | datamash -t, --no-strict --filler 0 perc:75 1)
  time_connect_75=$(printf "%.6f\n" $time_connect_75)
  time_appconnect_75=$(cat $datalog | awk -F ',' '{print $3}' | datamash -t, --no-strict --filler 0 perc:75 1)
  time_appconnect_75=$(printf "%.6f\n" $time_appconnect_75)
  time_pretransfer_75=$(cat $datalog | awk -F ',' '{print $4}' | datamash -t, --no-strict --filler 0 perc:75 1)
  time_pretransfer_75=$(printf "%.6f\n" $time_pretransfer_75)
  time_ttfb_75=$(cat $datalog | awk -F ',' '{print $5}' | datamash -t, --no-strict --filler 0 perc:75 1)
  time_ttfb_75=$(printf "%.6f\n" $time_ttfb_75)
  time_total_75=$(cat $datalog | awk -F ',' '{print $6}' | datamash -t, --no-strict --filler 0 perc:75 1)
  time_total_75=$(printf "%.6f\n" $time_total_75)

  time_dns_95=$(cat $datalog | awk -F ',' '{print $1}' | datamash -t, --no-strict --filler 0 perc:95 1)
  time_dns_95=$(printf "%.6f\n" $time_dns_95)
  time_connect_95=$(cat $datalog | awk -F ',' '{print $2}' | datamash -t, --no-strict --filler 0 perc:95 1)
  time_connect_95=$(printf "%.6f\n" $time_connect_95)
  time_appconnect_95=$(cat $datalog | awk -F ',' '{print $3}' | datamash -t, --no-strict --filler 0 perc:95 1)
  time_appconnect_95=$(printf "%.6f\n" $time_appconnect_95)
  time_pretransfer_95=$(cat $datalog | awk -F ',' '{print $4}' | datamash -t, --no-strict --filler 0 perc:95 1)
  time_pretransfer_95=$(printf "%.6f\n" $time_pretransfer_95)
  time_ttfb_95=$(cat $datalog | awk -F ',' '{print $5}' | datamash -t, --no-strict --filler 0 perc:95 1)
  time_ttfb_95=$(printf "%.6f\n" $time_ttfb_95)
  time_total_95=$(cat $datalog | awk -F ',' '{print $6}' | datamash -t, --no-strict --filler 0 perc:95 1)
  time_total_95=$(printf "%.6f\n" $time_total_95)

  time_dns_99=$(cat $datalog | awk -F ',' '{print $1}' | datamash -t, --no-strict --filler 0 perc:99 1)
  time_dns_99=$(printf "%.6f\n" $time_dns_99)
  time_connect_99=$(cat $datalog | awk -F ',' '{print $2}' | datamash -t, --no-strict --filler 0 perc:99 1)
  time_connect_99=$(printf "%.6f\n" $time_connect_99)
  time_appconnect_99=$(cat $datalog | awk -F ',' '{print $3}' | datamash -t, --no-strict --filler 0 perc:99 1)
  time_appconnect_99=$(printf "%.6f\n" $time_appconnect_99)
  time_pretransfer_99=$(cat $datalog | awk -F ',' '{print $4}' | datamash -t, --no-strict --filler 0 perc:99 1)
  time_pretransfer_99=$(printf "%.6f\n" $time_pretransfer_99)
  time_ttfb_99=$(cat $datalog | awk -F ',' '{print $5}' | datamash -t, --no-strict --filler 0 perc:99 1)
  time_ttfb_99=$(printf "%.6f\n" $time_ttfb_99)
  time_total_99=$(cat $datalog | awk -F ',' '{print $6}' | datamash -t, --no-strict --filler 0 perc:99 1)
  time_total_99=$(printf "%.6f\n" $time_total_99)

  if [[ "$display" = [yY] ]]; then
    echo
    echo -e "time_dns \n  avg:    $time_dns \n  median: $time_dns_median \n  min:    $time_dns_min \n  max:    $time_dns_max \n  75%:    $time_dns_75 \n  95%:    $time_dns_95 \n  99%:    $time_dns_99"
    echo -e "time_connect \n  avg:    $time_connect \n  median: $time_connect_median \n  min:    $time_connect_min \n  max:    $time_connect_max \n  75%:    $time_connect_75 \n  95%:    $time_connect_95 \n  99%:    $time_connect_99"
    echo -e "time_appconnect \n  avg:    $time_appconnect \n  median: $time_appconnect_median \n  min:    $time_appconnect_min \n  max:    $time_appconnect_max \n  75%:    $time_appconnect_75 \n  95%:    $time_appconnect_95 \n  99%:    $time_appconnect_99"
    echo -e "time_pretransfer \n  avg:    $time_pretransfer \n  median: $time_pretransfer_median \n  min:    $time_pretransfer_min \n  max:    $time_pretransfer_max \n  75%:    $time_pretransfer_75 \n  95%:    $time_pretransfer_95 \n  99%:    $time_pretransfer_99"
    echo -e "time_ttfb \n  avg:    $time_ttfb \n  median: $time_ttfb_median \n  min:    $time_ttfb_min \n  max:    $time_ttfb_max \n  75%:    $time_ttfb_75 \n  95%:    $time_ttfb_95 \n  99%:    $time_ttfb_99"
    echo -e "time_total \n  avg:    $time_total \n  median: $time_total_median \n  min:    $time_total_min \n  max:    $time_total_max \n  75%:    $time_total_75 \n  95%:    $time_total_95 \n  99%:    $time_total_99"

    echo
    echo -e "time_dns"
    header_summary
    echo "$time_dns,$time_dns_median,$time_dns_min,$time_dns_max,$time_dns_75,$time_dns_95,$time_dns_99"

    echo -e "time_connect"
    header_summary
    echo "$time_connect,$time_connect_median,$time_connect_min,$time_connect_max,$time_connect_75,$time_connect_95,$time_connect_99"

    echo -e "time_appconnect"
    header_summary
    echo "$time_appconnect,$time_appconnect_median,$time_appconnect_min,$time_appconnect_max,$time_appconnect_75,$time_appconnect_95,$time_appconnect_99"

    echo -e "time_pretransfer"
    header_summary
    echo "$time_pretransfer,$time_pretransfer_median,$time_pretransfer_min,$time_pretransfer_max,$time_pretransfer_75,$time_pretransfer_95,$time_pretransfer_99"

    echo -e "time_ttfb"
    header_summary
    echo "$time_ttfb,$time_ttfb_median,$time_ttfb_min,$time_ttfb_max,$time_ttfb_75,$time_ttfb_95,$time_ttfb_99"

    echo -e "time_total"
    header_summary
    echo "$time_total,$time_total_median,$time_total_min,$time_total_max,$time_total_75,$time_total_95,$time_total_99"
  fi
  rm -f "$datalog"
}

curlrun() {
  mode=$1
  url=$2
  urlonly=$(echo ${url} | sed -e 's|https:\/\/||')
  tls=$3
  resolveip=$4
  tlsmax="--tls-max $tls"
  datalog="/tmp/curltimes-${mode}-${dt}.txt"
  if [[ "$resolveip" ]]; then
    resolve_ip=" --resolve ${urlonly}:443:${resolveip}"
  else
    resolve_ip=
  fi
  checkhttp3=$($bin --http3 ${curlip_opt}${resolve_ip} -sIk $url $tlsmax --connect-timeout 2 >/dev/null 2>&1; echo $?)
  if [[ "$http3" = [yY] && "$checkhttp3" -eq '0' ]]; then
    # curl binary, libcurl supports HTTP/3
    curlopts='--http3'
  else
    # curl binary, libcurl does not support HTTP/3
    curlopts=""
  fi
  curlinfo=$($bin ${curlip_opt}-Isvk${resolve_ip} $url $tlsmax $curlopts 2>&1 | egrep 'Connected to |SSL connection using|> user-agent:|HEAD / ' | sed -e 's|* SSL connection using ||' -e 's|> user-agent: ||' -e 's|> HEAD / ||' -e 's| \/ | |' -e 's|curl/|curl |' -e 's|^* ||' | sort -r)
  echo -e "$curlinfo\nSample Size: $total\n"
  if [[ "$mode" = 'csv-sum' ]]; then
    for ((n=0;n<total;n++))
    do
      $bin ${curlip_opt}${resolve_ip} -w "$curl_format" -k --compressed -s -o /dev/null "$url" $tlsmax $curlopts
      sleep 0.3 #space the timings out slightly
    done | jq -r '[.[]] | @csv' | tee "$datalog"
    processlog y
  elif [[ "$mode" = 'csv-max-sum' ]]; then
    for ((n=0;n<total;n++))
    do
      $bin ${curlip_opt}${resolve_ip} -w "$curl_format" -k --compressed -s -o /dev/null "$url" $tlsmax $curlopts
      sleep 0.3 #space the timings out slightly
    done | jq -r '[.[]] | @csv' | tee "$datalog"
    processlog y
  elif [[ "$mode" = 'csv' ]]; then
    header
    for ((n=0;n<total;n++))
    do
      $bin ${curlip_opt}${resolve_ip} -w "$curl_format" -k --compressed -s -o /dev/null "$url" $tlsmax $curlopts
      sleep 0.3 #space the timings out slightly
    done | jq -r '[.[]] | @csv' | tee "$datalog"
    processlog
  else
    header
    for ((n=0;n<total;n++))
    do
      $bin ${curlip_opt}${resolve_ip} -w "$curl_format" -k --compressed -s -o /dev/null "$url" $tlsmax $curlopts
      sleep 0.3 #space the timings out slightly
    done | tee "$datalog"
  fi
}

compared() {
  url=$1
  urlonly=$(echo ${url} | sed -e 's|https:\/\/||')
  comp_resolveip=$2
  comparelog="/tmp/curltimes-compared-${dt}.txt"
  comp_tlsmax="--tls-max 1.3"
  if [[ "$comp_resolveip" ]]; then
    comp_resolve_ip=" --resolve ${urlonly}:443:${comp_resolveip}"
  else
    comp_resolve_ip=
  fi
  check_tlsmax=$($bin --tlsv1.3 ${curlip_opt}${comp_resolve_ip} -sIk $url --connect-timeout 2 >/dev/null 2>&1; echo $?)
  if [ "$check_tlsmax" -eq '0' ]; then
    tls2='tls12'
    tls3='tls13'
  else
    tls2='tls12'
    tls3='tls12'
  fi 
  diff -u <(curlrun csv-sum "$url" 1.2 "$comp_resolveip") <(curlrun csv-max-sum "$url" 1.3 "$comp_resolveip") > "$comparelog"
  cat "$comparelog" | sed -n -e 4,10p | grep -v '^\-0'
  echo
  cat "$comparelog" | tail -24 | sed -e "s|-|$tls2: |" -e "s|+|$tls3: |" -e 's|avg:|      avg:|' -e 's|time_|      time_|g'
  rm -f "$comparelog"
}

help() {
  echo "Usage:"
  echo
  echo "TLS 1.2 max tests"
  echo "$0 json https://domain.com"
  echo "$0 csv https://domain.com"
  echo
  echo "TLS 1.3 max tests"
  echo "$0 json-max https://domain.com"
  echo "$0 csv-max https://domain.com"
  echo
  echo "CSV Summary"
  echo "$0 csv-sum https://domain.com"
  echo "$0 csv-max-sum https://domain.com"
  echo
  echo "TLSv1.2 vs TLSv1.3 Compare"
  echo "$0 compare https://domain.com"
}

case "$1" in
  json )
    curlrun json "$2" 1.2 "$3"
    ;;
  csv )
    curlrun csv "$2" 1.2 "$3"
    ;;
  json-max )
    curlrun json "$2" 1.3 "$3"
    ;;
  csv-max )
    curlrun csv "$2" 1.3 "$3"
    ;;
  csv-sum )
    curlrun csv-sum "$2" 1.2 "$3"
    ;;
  csv-max-sum )
    curlrun csv-max-sum "$2" 1.3 "$3"
    ;;
  compare )
    compared "$2" "$3"
    ;;
  *)
    help
    ;;
esac