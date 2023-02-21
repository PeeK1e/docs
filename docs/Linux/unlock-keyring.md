---
title: Unlocking SSH keys on login
---
# Keyring unlocking

In order to unlock your keyring on login, to use SSH keys and other keys without entering passwords everytime, you'll need to install a keyring manager like `gnome-keyring`.

If you use `gnome-keyring` and for the modules to automatically load, add these lines to your `/etc/pam.d/login`

```conf
auth       optional     pam_gnome_keyring.so
session    optional     pam_gnome_keyring.so auto_start
```
The file should look something like this afterwards
```conf
#%PAM-1.0

auth       required     pam_securetty.so
auth       requisite    pam_nologin.so
auth       include      system-local-login
auth       optional     pam_gnome_keyring.so
account    include      system-local-login
session    include      system-local-login
password   include      system-local-login
session    optional     pam_gnome_keyring.so auto_start
```

You'll also have to start and export the `SSH_AUTH_SOCK` when your Session manager starts.

If you are using a login manager like `sddm`, you're on your own now, good luck.

If not add following lines to your `.zprofile` if using zsh, `.profile` if using bash and so on.

```
if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
	eval $(gnome-keyring-daemon --start)
	export SSH_AUTH_SOCK
	exec sway # you may have to replace sway with your windowmanager
fi
```

!!! Hint 
	you may want to kill the `gnome-keyring-daemon` on logout, so there won't be any issues on the next login.
