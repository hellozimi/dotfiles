#!/usr/bin/env bash

conns=$(pgrep -a openvpn$ | head -n 1 | sed -n 's/^.*\-\-config\s\(.*\.ovpn\).*/\1/p')

if [ ! -z "$conns" ]; then
    status=$(basename $conns | sed -e 's/\.[^.]*$//')
    echo "vpn: $status"
else
    echo "no vpn"
fi
