---
title: CS:GO issues on Linux
---

## Issue on launch

CSGO has curently an issue crashing on startup with systems on a newer glibc version

A simple fix for this is to rename the `video` folder in the panorama folder of CS:GO

```
mv ~/.steam/steam/steamapps/common/Counter-Strike Global Offensive/csgo/panorama/videos ~/.steam/steam/steamapps/common/Counter-Strike Global Offensive/csgo/panorama/videos.bak
```

After moving the folder CS:GO should launch again, but the background will be black.
