---
title: Homeserver behind provider NAT/Firewall
---

If you have a homeserver behind a provider NAT or a Firewall you have the option to rent a small droplet or vServer ans reverse ssh the ports you need to forward.
You can also use a VPN for that but personally I found it more simple to just use SSH reverse port forwarding.

* Place your SSH key onto the target machine
* Create a conjob that executes automatically on boot of your Homeserver/Server behind the NAT/Firewall like follows
```
@reboot autossh -M 0 -o ConnectTimeout=10 -o ServerAliveInterval=120 -o ServerAliveCountMax=2 \
-p <ssh_port> -i </your/ssh/key> \
-N -R <remote_port>:127.0.0.1:<local_port> \
<ssh_user>@<domain> -f
```

Done! Now you can reach your service through the external server on `domain:port`