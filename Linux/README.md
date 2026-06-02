# Linux

## Nvidiaデバイスの存在有無
```
$ lspci | grep -i nvidia
(例)
00:03.0 3D controller: NVIDIA Corporation AD104GL [L4] (rev a1)
```

## 認識しているデバイス一覧
```
$ sudo lshw -c display
(例)
*-display UNCLAIMED       
       description: 3D controller
       product: AD104GL [L4]
       vendor: NVIDIA Corporation
       physical id: 3
       bus info: pci@0000:00:03.0
       version: a1
       width: 64 bits
       clock: 33MHz
       capabilities: msix pm bus_master cap_list
       configuration: latency=0
       resources: iomemory:280-27f iomemory:300-2ff memory:80000000-80ffffff memory:2800000000-2fffffffff memory:3000000000-3001ffffff
```

### 推奨Nvidia-driver確認
```
$ ubuntu-drivers devices
(例)
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


### Cuda Toolkitインストール例
```
$ wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64/cuda-keyring_1.1-1_all.deb
$ sudo dpkg -i cuda-keyring_1.1-1_all.deb
$ sudo apt update

# cuda-toolkitインストール
sudo apt install -y cuda-toolkit-13-2
```

#### .bashrcに追記
```
echo '' >> ~/.bashrc
echo "# $(date '+%Y/%m/%d') $USER" >> ~/.bashrc
echo '## CUDA Toolkit ##' >> ~/.bashrc
echo 'export PATH=/usr/local/cuda/bin:$PATH' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH' >> ~/.bashrc

source ~/.bashrc
```
