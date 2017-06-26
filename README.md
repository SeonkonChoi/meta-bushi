Test the XEN over x86_64, Intel GVT-g, meta-intel, meta-ivi and meta-virtualization.

1. Download,
```
mkdir xen-test
cd xen-test
repo init -u https://github.com/SeonkonChoi/manifest-virt.git -b pyro
repo sync
repo start work --all
```

2. Build,
```
mkdir downloads
mkdir build
bash
cd poky
source ../meta-bushi/bb-env ../build
ln -s ../downloads ./
bitbake xen-image-minimal
```

3. Make a bootable USB stick,
```
sudo sh ../meta-bushi/scripts/mkefidisk.sh \
    /dev/sdX \
    tmp/deploy/images/intel-corei7-64/xen-image-minimal-intel-corei7-64.hddimg 
    /dev/sda
```
..* /dev/sdX : The USB stick device to be written on your host desktop.
..* /dev/sda : Whatever a **major device node for rootfs** something like /dev/mmcblk0 on your target machine.

4. Note
..* It only assume that EFI environment.
..* It only assume that x86_64.
..* 'xen.efi' is the first EFI app by default.
