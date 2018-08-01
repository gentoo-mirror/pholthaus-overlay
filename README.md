# Patrick's personal Gentoo overlay

This repository contains my personal set of Gentoo packages. To use it
with portage, create the file ```/etc/portage/repos.conf/pholthaus.conf```
with the following content:

```ini
[pholthaus-overlay]
location = /usr/local/portage
sync-type = git
sync-uri = git://github.com/pholthau/pholthaus-overlay.git
auto-sync = Yes
```

Using ```auto-sync = Yes``` has it automatically updated by running ```emerge --sync```.
If you don't want this behaviour, consider setting auto-sync to false and use ```emaint sync -r pholthaus-overlay```
to update this overlay only.
