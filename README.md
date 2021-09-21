![Logo](qsv.png)

# Intel-MSDK-Ubuntu20-04-Installer
Installs Intel MSDK (21.2.3) on a Ubuntu 20.04 system.

[MSDK Releases](https://github.com/Intel-Media-SDK/MediaSDK/releases)

```
git clone https://github.com/Unit-X/Intel-MSDK-Ubuntu20-04-Installer.git --depth=1
cd Intel-MSDK-Ubuntu20-04-Installer
./install_msdk1.sh
(If finished with no errors)
sudo reboot now
(cd to Intel-MSDK-Ubuntu20-04-Installer directory)
./install_msdk2.sh
```

# Allowing additional users to run the MSDK library
In order for a user to access the Intel GPU using the MSDK library, that user must belong to the `render` and `video` groups. The installer will
add the current user to those groups, but additional users must manually do so. Add another user by executing:
```
sudo usermod -a -G video,render <myusername>
```
and then log out and log in again to the shell. Check if the video and render groups turn up in the list of groups you are a member of when running `groups`.

## Credits

The UnitX team at Edgeware AB

Maintainer: anders.cedronius(at)edgeware.tv