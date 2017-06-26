#
# poky: linux-yocto-4.10.bb
#  -> poky: linux-yocto-4.10.bbappend
#    -> meta-intel: linux-yocto-4.10.bbapped
#      -> meta-virtualization: linux-yocto-4.10.bbappend
#

FILESEXTRAPATHS_append := ":${THISDIR}/linux-xen"

KBRANCH = "gvt-stable-4.10"
MBRANCH = "yocto-4.10"

SRCREV_machine = "69549da74fd0fc9b7f75b3385014d739e344bbac"
SRCREV_meta = "4b89f331d4220f6f62d20ef60aa59edcd9b44106"

SRC_URI = "git://github.com/01org/gvt-linux.git;name=machine;branch=${KBRANCH}; \
           git://git.yoctoproject.org/yocto-kernel-cache;type=kmeta;name=meta;branch=${MBRANCH};destsuffix=${KMETA}; \
"

LINUX_VERSION = "4.10.0"
LINUX_VERSION_EXTENSION = "-igvt"
