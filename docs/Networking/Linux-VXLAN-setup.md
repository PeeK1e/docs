---
title: Setup a VXLAN across multiple machines
tags:
    - Guides
    - Linux
    - VXLAN
    - Network
    - ip
    - iputils
    - route
---

This script creates an VXLAN device and assigns an address to the VXLAN interface.
If everything is working correctly you should be able to ping the other hosts on the address you set with the `$VXLAN_ADDRESS` variable.

!!! Hint
    Don't forget to unblock the VXLAN Port you set with `$VXLAN_DSTPORT`, the default is `4789`
    You can set them with the `export` command e.g. `export VXLAN_ADDRESS=1.3.3.7/24`


!!! Important
    You have to set some values like `VXLAN_DEVICE`, `VXLAN_LOCAL_ADDRESS` and `VXLAN_ADDRESS`.
    You may use default values for the first host you're setting up but for the other hosts these Variables are the minimun you have to change.


```shell
#!/bin/sh

# SET your Variables with 'export VXLAN_VAR=VALUE' in your shell
VXLAN_INTERFACE_NAME=${VXLAN_INTERFACE_NAME:-"vxlan11"} # name of the VXLAN
VXLAN_ID=${VXLAN_ID:-"42"}                              # ID of the VXLAN
VXLAN_GROUP=${VXLAN_GROUP:-"239.1.1.1"}                 # Broadcast IP-Group
VXLAN_TTL=${VXLAN_TTL:-"5"}                             # TTL can be lowered if only one hop away
VXLAN_DSTPORT=${VXLAN_DSTPORT:-"4789"}                  # IANA VXLAN default port
VXLAN_DEVICE=${VXLAN_DEVICE:-"enp41s0"}                 # Interface for the VXLAN to listen on
VXLAN_LOCAL_ADDRESS=${VXLAN_LOCAL_ADDRESS:-"10.0.1.1"}  # Local address
VXLAN_ADDRESS=${VXLAN_ADDRESS:-"10.20.30.1/24"}         # An address dor the VXLAN host

echo "VXLAN_LOCAL_ADDRESS: $VXLAN_LOCAL_ADDRESS"
echo "VXLAN_DEVICE: $VXLAN_DEVICE"
echo "VXLAN_DSTPORT: $VXLAN_DSTPORT"
echo "VXLAN_TTL: $VXLAN_TTL"
echo "VXLAN_GROUP: $VXLAN_GROUP"
echo "VXLAN_ID: $VXLAN_ID"
echo "VXLAN_INTERFACE_NAME: $VXLAN_INTERFACE_NAME"

# Adding the VXLAN (MULTICAST)
ip link add "$VXLAN_INTERFACE_NAME" type vxlan \
	id "$VXLAN_ID" \
	group "$VXLAN_GROUP" \
	local "$VXLAN_LOCAL_ADDRESS" \
	ttl "$VXLAN_TTL" \
	dstport "$VXLAN_DSTPORT" \
	dev "$VXLAN_DEVICE"

# Bring the Inferfaces up
ip link set up "$VXLAN_INTERFACE_NAME"

# Add an address to ping to
ip addr add "$VXLAN_ADDRESS" dev "$VXLAN_INTERFACE_NAME"

echo "Print VXLAN Config:"
ifconfig "$VXLAN_INTERFACE_NAME"
ip link show "$VXLAN_INTERFACE_NAME"
```
