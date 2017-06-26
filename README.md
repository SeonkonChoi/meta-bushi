Download,
```
mkdir xen-test
cd xen-test
repo init -u https://github.com/SeonkonChoi/manifest-virt.git -b pyro
repo sync
repo start work --all
```

Build,
```
mkdir downloads
mkdir build
bash
cd poky
source ../meta-bushi/bb-env ../build
ln -s ../downloads ./
bitbake xen-image-minimal
```

Make a bootable USB stick,
```
sudo sh ../meta-bushi/scripts/mkefidisk.sh \
    /dev/sdX \
    tmp/deploy/images/intel-corei7-64/xen-image-minimal-intel-corei7-64.hddimg 
    /dev/sda
```
* /dev/sdX : the USB stick device to be written on your host desktop.
* /dev/sda : the USB stick device for booting on your target machine.
