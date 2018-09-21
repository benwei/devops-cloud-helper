#!/bin/bash
if [ -n "$CONFIG" ]; then
    config="$CONFIG"
else
    config="./.config"
fi

if [ ! -f "$config" ] ; then
    echo "missing $config"
    exit 1
fi
. $config
## config end

datestr=`date +"%Y%m%d_%H%M"`
outjson="$group_id-$datestr.json"
aws ec2 describe-security-groups --group-ids $group_id > $outjson
echo "please check $outjson"
cat "$outjson" | jq '.[] | .[] | {"IpPermissions"} | .[]'
