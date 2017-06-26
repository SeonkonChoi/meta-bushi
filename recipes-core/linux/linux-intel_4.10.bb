# !! UNDER CONSTRUCTION !!
#  not working as expected

#
# meta-intel::linux-intel_4.9.bb
#
require recipes-kernel/linux/linux-intel_4.9.bb
#require recipes-kernel/linux/linux-yocto_4.10.bb
#require recipes-kernel/linux/linux-yocto_4.10.bbappend

FILESEXTRAPATHS_append := ":${THISDIR}/linux-xen"

KBRANCH = "gvt-stable-4.10"
MBRANCH = "yocto-4.10"

SRC_URI = "git://github.com/01org/gvt-linux.git;name=machine;branch=${KBRANCH}; \
           git://git.yoctoproject.org/yocto-kernel-cache;type=kmeta;name=meta;branch=${MBRANCH};destsuffix=${KMETA}; \
	   file://xen_dom0_kernel.cfg"

SRCREV_machine = "69549da74fd0fc9b7f75b3385014d739e344bbac"
SRCREV_meta = "4b89f331d4220f6f62d20ef60aa59edcd9b44106"

LINUX_VERSION = "4.10.0"
LINUX_VERSION_EXTENSION = "-igvt"
