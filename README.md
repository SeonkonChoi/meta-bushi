MACHINE = "intel-corei7-64"
#MACHINE = "intel-core2-32"

MACHINE_FEATURES_append = " efi pci acpi "

DISTRO_FEATURES_append = " largefile systemd ipv6 xen x11 wayland weston opengl opengles1 opengles2 egl "

EFI_PROVIDER = "grub-efi"
PREFERRED_VERSION_grub-efi = "2.02"


#igvtg xen : xengt-stable-4.9
PREFERRED_VERSION_xen = "4.9+gitAUTOINC+6d3828d156"

#igvtg linux : xengt-stable-4.10
PREFERRED_VERSION_linux-intel = "4.10%"

#igvtg linux : xengt-stable-4.10
PREFERRED_VERSION_linux-yocto = "4.10%"

PREFERRED_PROVIDER_virtual/kernel = "linux-yocto"

