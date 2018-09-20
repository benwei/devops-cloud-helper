#!bash
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

cidr="$1"
if [ -z "$cidr" ]; then
    echo "syntax: <cidr>"
    exit 1
fi

cidr="${cidr%%/32}/32"

datestr="`date +'%Y%m%d %H%M'`"

ipperms="[{\"IpProtocol\":\"$ip_proto\",\"FromPort\":$from_port,\"ToPort\":$to_port,\"IpRanges\":[{\"CidrIp\":\"$cidr\",\"Description\":\"$desc_prefix $datestr\"}]}]"

set_cidr() {
 aws ec2 authorize-security-group-ingress --group-id $group_id --ip-permissions="$ipperms"
 if [ $? -ne 0 ]; then
     echo "authorize-security-group-ingress fail with $cidr"
     exit 1
 fi
}

update_desc() {
 aws ec2 update-security-group-rule-descriptions-ingress --group-id $group_id --ip-permissions="$ipperms"
 if [ $? -ne 0 ]; then
    echo "update-security-group-rule-descriptions-ingress fail with $cidr"
    exit 1
 fi
}

case $2 in
u*) # update_desc
    update_desc
;;
*)
    set_cidr
;;
esac
exit 0
