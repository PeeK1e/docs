---
title: Why can't I run Xwayland apps as root
---

When launching **GUI**-Apps made for X11 on wayland as root you may see an error like this:

```sh
Invalid MIT-MAGIC-COOKIE-1 key
java.awt.AWTError: Can't connect to X11 window server using ':0' as the value of the DISPLAY variable.
```

This is due to Wayland's security policy and design.
According to Wayland, apps requiring root privileges should use [Polkit](https://wiki.archlinux.org/title/Polkit) to acquire those.


Since we know that Software always is perfectly written, there is a workaround for situations where apps simply need to be run as root:

```sh
#sets the permission to launch apps as root
xhost si:localuser:root
#launch the app with your user's environment 
sudo -E <app>
```

Removing the permissions after you're done is done by `$ xhost -si:localuser:root`.
