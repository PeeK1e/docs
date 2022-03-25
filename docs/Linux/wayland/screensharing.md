---
title: Screensharing on Wayland
---

Screensharing on wayland can be a bit tricky. If you were using pulseaudio before now the time has come to say goodbye to that and embrace pipewire.

Pipewire is a new protocol to interact with audio  interfaces and the desktop itself.

If you are using a window manager like `sway` there are a couple of packages you should get your hands on, depending on your distro they may be called different.

For Arch based systems these packages are usefull.

* `xdg-desktop-portal`
* `xdg-desktop-portal-wlr` and `wlroots` (Wayland Compositors like Sway)
* `xdg-desktop-portal-kde` (KDE)
* `xdg-desktop-portal-gnome` (Gnome)
* `slurp`
* `pipewire`
* `xorg-xwayland` (to run xorg-based applications)

To enable wayland mode for electron apps create a `~/.config/electron12-flags.conf` with the following content:

```
--enable-features=UseOzonePlatform
--ozone-platform=wayland
```

and link to enable it for older electron apps aswell

```
ln -s ~/.config/electron12-flags.conf ~/.config/electron-flags.conf
```