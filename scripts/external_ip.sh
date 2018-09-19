#!/bin/bash
if [ -f ip.json ] ; then
    mv ip.json ip_prev.json
fi

curl api.ipify.org/?format=json > ip.json
cat ip.json
