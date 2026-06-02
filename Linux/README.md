# Linux

## GPU確認
```
$ lspci | grep -i nvidia
(例) 00:03.0 3D controller: NVIDIA Corporation AD104GL [L4] (rev a1)
```

### 推奨Nvidia-driver確認
```
$ ubuntu-drivers devices
udevadm hwdb is deprecated. Use systemd-hwdb instead.
udevadm hwdb is deprecated. Use systemd-hwdb instead.
udevadm hwdb is deprecated. Use systemd-hwdb instead.
udevadm hwdb is deprecated. Use systemd-hwdb instead.
udevadm hwdb is deprecated. Use systemd-hwdb instead.
udevadm hwdb is deprecated. Use systemd-hwdb instead.
udevadm hwdb is deprecated. Use systemd-hwdb instead.
udevadm hwdb is deprecated. Use systemd-hwdb instead.
udevadm hwdb is deprecated. Use systemd-hwdb instead.
udevadm hwdb is deprecated. Use systemd-hwdb instead.
udevadm hwdb is deprecated. Use systemd-hwdb instead.
udevadm hwdb is deprecated. Use systemd-hwdb instead.
ERROR:root:aplay command not found
== /sys/devices/pci0000:00/0000:00:03.0 ==
modalias : pci:v000010DEd000027B8sv000010DEsd000016EEbc03sc02i00
vendor   : NVIDIA Corporation
model    : AD104GL [L4]
driver   : nvidia-driver-580 - distro non-free
driver   : nvidia-driver-580-server-open - distro non-free
driver   : nvidia-driver-595-server - distro non-free
driver   : nvidia-driver-535-server-open - distro non-free
driver   : nvidia-driver-535 - distro non-free
driver   : nvidia-driver-535-open - distro non-free
driver   : nvidia-driver-595-open - distro non-free recommended
driver   : nvidia-driver-580-open - distro non-free
driver   : nvidia-driver-595-server-open - distro non-free
driver   : nvidia-driver-535-server - distro non-free
driver   : nvidia-driver-595 - distro non-free
driver   : nvidia-driver-580-server - distro non-free
driver   : xserver-xorg-video-nouveau - distro free builtin
```
