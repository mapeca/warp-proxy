#!/bin/bash

# Prepare dbus
mkdir -p /run/dbus
dbus-daemon --system --fork

# Set loopback redirection
iptables -t nat -A PREROUTING -p tcp -m addrtype --dst-type LOCAL --dport 40000 -j DNAT --to 127.0.0.1:40000

# Start warp service
warp-svc &

# Wait a few seconds to let warp warm up
sleep 5

# Setup warp and connect
warp-cli registration new
warp-cli mode proxy
warp-cli connect

# Keep container running
tail -f /dev/null