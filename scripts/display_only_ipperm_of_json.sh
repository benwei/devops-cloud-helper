#!/bin/sh

target="$1"
if [ -z "$target" ]; then
    echo "syntax: <security group json file>"
    exit 1
fi

# use jq - commandline JSON processor [version 1.3] from http://stedolan.github.com/jq

cat "$target" | jq '.[]| .[] | .["IpPermissions"]'
