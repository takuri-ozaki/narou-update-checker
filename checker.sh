#!/bin/bash

NCODE_LIST=(
  "n2267be"
)
SAVE_DATA_PATH="./save.csv"
TMP_PATH="./tmp.html"
SLACK_ENDPOINT="https://hooks.slack.com/services/..."

notice() {
  curl -s -XPOST --data-urlencode \
    "payload={\"text\":\"${1}が${2}に更新されています\n${3}\"}" ${SLACK_ENDPOINT} \
    > /dev/null
}

if [[ $(uname) = "Darwin" ]]; then
  shopt -s expand_aliases
  alias sed='/usr/local/bin/gsed'
fi

if [[ ! -e $SAVE_DATA_PATH ]]; then
  touch $SAVE_DATA_PATH
fi

for ncode in ${NCODE_LIST[@]}; do
  url=https://ncode.syosetu.com/novelview/infotop/ncode/${ncode}
  curl $url -so $TMP_PATH
  last_updated=$(cat $TMP_PATH | grep "最新部分掲載日" -A 1 \
    | tail -n 1 \
    | sed -e 's#</*td>##g')
  last_saved=$(cat $SAVE_DATA_PATH | grep $ncode \
    | awk -F "," '{print $2}')

  if [[ $last_updated = $last_saved ]]; then
    sleep 1s
    continue
  fi

  title=$(cat $TMP_PATH | grep "h1" \
    | sed -e 's#<h1><[a-zA-z0-9/=". :]*>##' \
    | sed -e 's#</a></h1>$##')

  if [[ ${#last_saved} -eq 0 ]]; then
    echo $ncode,"$last_updated" >> $SAVE_DATA_PATH
  else
    sed -i s/$ncode,"$last_saved"/$ncode,"$last_updated"/ $SAVE_DATA_PATH
  fi

  notice $title "$last_updated" $url

  sleep 1s
done

rm -rf $TMP_PATH