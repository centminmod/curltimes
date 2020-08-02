#!/bin/bash
############################################################
# https://nooshu.github.io/blog/2020/07/30/measuring-tls-13-ipv4-ipv6-performance/
############################################################
total=3
bin='/usr/bin/curl'
#bin='/usr/local/src/curl/src/curl'
dt=$(date +"%d%m%y-%H%M%S")
http3='n'
############################################################

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
if [[ "$bin" = '/usr/local/src/curl/src/curl' || -d /usr/lib/x86_64-linux-gnu ]]; then
  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/x86_64-linux-gnu
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
  echo "avg:,min:,max:,75%:,95%:,99%:"
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
    echo -e "time_dns \n  avg: $time_dns \n  min: $time_dns_min \n  max: $time_dns_max \n  75%: $time_dns_75 \n  95%: $time_dns_95 \n  99%: $time_dns_99"
    echo -e "time_connect \n  avg: $time_connect \n  min: $time_connect_min \n  max: $time_connect_max \n  75%: $time_connect_75 \n  95%: $time_connect_95 \n  99%: $time_connect_99"
    echo -e "time_appconnect \n  avg: $time_appconnect \n  min: $time_appconnect_min \n  max: $time_appconnect_max \n  75%: $time_appconnect_75 \n  95%: $time_appconnect_95 \n  99%: $time_appconnect_99"
    echo -e "time_pretransfer \n  avg: $time_pretransfer \n  min: $time_pretransfer_min \n  max: $time_pretransfer_max \n  75%: $time_pretransfer_75 \n  95%: $time_pretransfer_95 \n  99%: $time_pretransfer_99"
    echo -e "time_ttfb \n  avg: $time_ttfb \n  min: $time_ttfb_min \n  max: $time_ttfb_max \n  75%: $time_ttfb_75 \n  95%: $time_ttfb_95 \n  99%: $time_ttfb_99"
    echo -e "time_total \n  avg: $time_total \n  min: $time_total_min \n  max: $time_total_max \n  75%: $time_total_75 \n  95%: $time_total_95 \n  99%: $time_total_99"

    echo
    echo -e "time_dns"
    header_summary
    echo "$time_dns,$time_dns_min,$time_dns_max,$time_dns_75,$time_dns_95,$time_dns_99"

    echo -e "time_connect"
    header_summary
    echo "$time_connect,$time_connect_min,$time_connect_max,$time_connect_75,$time_connect_95,$time_connect_99"

    echo -e "time_appconnect"
    header_summary
    echo "$time_appconnect,$time_appconnect_min,$time_appconnect_max,$time_appconnect_75,$time_appconnect_95,$time_appconnect_99"

    echo -e "time_pretransfer"
    header_summary
    echo "$time_pretransfer,$time_pretransfer_min,$time_pretransfer_max,$time_pretransfer_75,$time_pretransfer_95,$time_pretransfer_99"

    echo -e "time_ttfb"
    header_summary
    echo "$time_ttfb,$time_ttfb_min,$time_ttfb_max,$time_ttfb_75,$time_ttfb_95,$time_ttfb_99"

    echo -e "time_total"
    header_summary
    echo "$time_total,$time_total_min,$time_total_max,$time_total_75,$time_total_95,$time_total_99"
  fi
  rm -f "$datalog"
}

curlrun() {
  mode=$1
  url=$2
  tls=$3
  tlsmax="--tls-max $tls"
  datalog="/tmp/curltimes-${mode}-${dt}.txt"
  checkhttp3=$($bin --http3 -I $url $tlsmax >/dev/null 2>&1; echo $?)
  if [[ "$http3" = [yY] && "$checkhttp3" -eq '0' ]]; then
    # curl binary, libcurl supports HTTP/3
    curlopts='--http3'
  else
    # curl binary, libcurl does not support HTTP/3
    curlopts=""
  fi
  curlinfo=$($bin -Ivk $url $tlsmax $curlopts 2>&1 | egrep 'SSL connection using|> user-agent:|HEAD / ' | sed -e 's|* SSL connection using ||' -e 's|> user-agent: ||' -e 's|> HEAD / ||' -e 's| \/ | |' -e 's|curl/|curl |' | sort -r)
  echo -e "$curlinfo\n"
  if [[ "$mode" = 'csv-sum' ]]; then
    for ((n=0;n<total;n++))
    do
      $bin -w "$curl_format" -k --compressed -s -o /dev/null "$url" $tlsmax $curlopts
      sleep 0.3 #space the timings out slightly
    done | jq -r '[.[]] | @csv' | tee "$datalog"
    processlog y
  elif [[ "$mode" = 'csv-max-sum' ]]; then
    for ((n=0;n<total;n++))
    do
      $bin -w "$curl_format" -k --compressed -s -o /dev/null "$url" $tlsmax $curlopts
      sleep 0.3 #space the timings out slightly
    done | jq -r '[.[]] | @csv' | tee "$datalog"
    processlog y
  elif [[ "$mode" = 'csv' ]]; then
    header
    for ((n=0;n<total;n++))
    do
      $bin -w "$curl_format" -k --compressed -s -o /dev/null "$url" $tlsmax $curlopts
      sleep 0.3 #space the timings out slightly
    done | jq -r '[.[]] | @csv' | tee "$datalog"
    processlog
  else
    header
    for ((n=0;n<total;n++))
    do
      $bin -w "$curl_format" -k --compressed -s -o /dev/null "$url" $tlsmax $curlopts
      sleep 0.3 #space the timings out slightly
    done | tee "$datalog"
  fi
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
}

case "$1" in
  json )
    curlrun json "$2" 1.2
    ;;
  csv )
    curlrun csv "$2" 1.2
    ;;
  json-max )
    curlrun json "$2" 1.3
    ;;
  csv-max )
    curlrun csv "$2" 1.3
    ;;
  csv-sum )
    curlrun csv-sum "$2" 1.2
    ;;
  csv-max-sum )
    curlrun csv-max-sum "$2" 1.3
    ;;
  *)
    help
    ;;
esac