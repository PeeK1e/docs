---
title: Basic Network Troubleshooting
---
# Basic Network Troubleshooting
In case you have connection problems between some Machines or Applications you can do some basic/general network troubleshooting to make sure the machines can see each other and communicate without restrictions or check if a firewall may intercept traffic.

### ICMP traffic

To check if machines can reach each other and no routing rules are broken you can use `ping` and `traceroute`/`tracepath` to discover routing issues.

A successfull ping may look like this

```bash
$ ping 192.168.178.17
PING 192.168.178.17 (192.168.178.17) 56(84) bytes of data.
64 bytes from 192.168.178.17: icmp_seq=1 ttl=64 time=5.84 ms
64 bytes from 192.168.178.17: icmp_seq=2 ttl=64 time=5.64 ms
64 bytes from 192.168.178.17: icmp_seq=3 ttl=64 time=4.67 ms
```

And a Traceroute may look like the following

!!! Note
    In some netowrks `UDP` traceroutes may be blocked by a low level firewall or switch.
    You can use `traceroute -T <ip>` for an TCP traceroute scan.
    Available modes are
    `  -I  --icmp                  Use ICMP ECHO for tracerouting`
    `-T  --tcp                   Use TCP SYN for tracerouting (default port is 80)`
    and the default `UDP`
    `-U  --udp                   Use UDP to particular port for tracerouting`

```shell
$ traceroute 192.168.178.17
traceroute to 192.168.178.17 (192.168.178.17), 30 hops max, 60 byte packets
 1  pi.hole (192.168.178.17)  6.957 ms  6.865 ms  6.817 ms
```

### HTTP (and TCP) Traffic

To check if `HTTP` and implicitly `TCP` traffic is filtered you can startup a simple `http.server` with `python3`

!!! Warning
    If you run the `http.server` from your home directory you may risk leaking your ssh keys and other secrets to people on the network while the server is running

Start the server with the following command to start the web-server on port 8080

```shell
$ python3 -m http.server 8080
```

From another machine you can use `curl` to check if the server is reachable

```shell
$ curl -L <ip>:<port>
```

### UDP / TCP traffic

To check if `TCP` or `UDP` packets are arriving at a host machine you can use `netcat` to listen and send TCP/UDP Packets.

Start listening for any host on port 4444

```shell
#TCP traffic
$ netcat -l 0.0.0.0 4444

#UDP traffic
$ netcat -ul 0.0.0.0 4444
```

Send a packet. `-c` closes the connection after a packet is send.

!!! Hint
    If a host has received an `UDP` packet, you need to Terminate `netcat` and restart the program.

```shell
#TCP traffic
$ echo "test" | netcat -c <ip> <port>

#UDP traffic
$ echo "test" | netcat -cu <ip> <port>
```

After you have sent the packet, you should see the `test` message on the listening host.

### Firewall or Intelligent-Switches

If all the previous checks fail, check your host-machine's firewall rules and firewall helper like `ufw`

You may also check `iptables` rules for any blocked ports connections or whitelist only connections.

If you can't see any firewall rules interfering with your applications you may need to check you network or ask you hosting service if they might block any traffic.
