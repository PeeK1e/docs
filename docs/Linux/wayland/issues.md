---
title: Wayland Issues
---
# Wayland Issues

Some applications need to be told that they are running on Wayland

### Java Applications 
are [alergic to wayland](https://wiki.archlinux.org/title/Wayland#Java) and need to have reparenting windows disabled

You can set this value in your `/etc/environment`

```
_JAVA_AWT_WM_NONREPARENTING=1
```

### Firefox in Wayland Mode

!!! Warning
    Toolbars like bookmarks are [broken on the native Wayland version of Firefox](https://www.reddit.com/r/swaywm/comments/rov776/comment/hqeftnw/?utm_source=share&utm_medium=web2x&context=3)

```
MOZ_ENABLE_WAYLAND=1
```

### QT apps
To enable the QT-wayland plugin add this to your environment

```
QT_QPA_PLATFORM=wayland
```
