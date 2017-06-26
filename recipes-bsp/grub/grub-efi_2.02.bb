FILESEXTRAPATHS_append := ":${THISDIR}/linux-xen"

require recipes-bsp/grub/grub-efi_2.00.bb

SRC_URI = "ftp://ftp.gnu.org/gnu/grub/grub-${PV}.tar.gz \
           file://cfg \
"

SRC_URI[md5sum] = "1116d1f60c840e6dbd67abbc99acb45d"
SRC_URI[sha256sum] = "660ee136fbcee08858516ed4de2ad87068bfe1b6b8b37896ce3529ff054a726d"

do_deploy_append() {
	install -d ${DEPLOYDIR}
	local MODSRC=${D}/usr/lib/grub
	local MODDST=${S}
	local x
	local y
	for y in ${MODSRC}/*; do
		[ -d "$y" ] || continue
		x=${y/${MODSRC}\//}
		tar czvf ${MODDST}/grub-modules-"$x".tgz -C "${MODSRC}" "$x/"
		install -m 0644 ${MODDST}/grub-modules-"$x".tgz ${DEPLOYDIR}/
	done
}
