Test the XEN over x86_64, Intel GVT-g, meta-intel, meta-ivi and meta-virtualization.

* Download,
```
mkdir xen-test
cd xen-test
repo init -u https://github.com/SeonkonChoi/manifest-virt.git -b pyro
repo sync
repo start work --all
```

* Build,
```
mkdir downloads
mkdir build
bash
cd poky
source ../meta-bushi/conf/bb-env ../build
ln -s ../downloads ./
bitbake xen-image-minimal
```

* Make a bootable USB stick,
```
sudo sh ../meta-bushi/scripts/mkefidisk.sh \
  /dev/sdX \
  tmp/deploy/images/intel-corei7-64/xen-image-minimal-intel-corei7-64.hddimg \
  /dev/sda
```
**/dev/sdX** : The USB stick device to be written on your host desktop.
**/dev/sda** : Whatever a **major device node for rootfs** something like /dev/sda or /dev/mmcblk0 on your target machine.

* Note
It only assume EFI environment and x86_64, and the 'xen.efi' would be the first EFI app by default.
