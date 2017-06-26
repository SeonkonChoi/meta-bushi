#
# for existing meta-virtualization::xen_4.8.0
#

FILESEXTRAPATHS_append := ":${THISDIR}/${PN}"
SRC_URI += "file://xen-4.8.0_glibc-2.25.patch"

do_configure_prepend() {
	[ -f "${STAGING_INCDIR}/bits/long-double-64.h" -a ! -f "${STAGING_INCDIR}/bits/long-double-32.h" ] && \
	cp ${STAGING_INCDIR}/bits/long-double-64.h ${STAGING_INCDIR}/bits/long-double-32.h
}

FILES_${PN}-xencommons_remove = " \
	${systemd_unitdir}/system/xenstored.socket \
	${systemd_unitdir}/system/xenstored_ro.socket \
"

SYSTEMD_SERVICE_${PN}-xencommons_remove = " \
	xenstored.socket \
	xenstored_ro.socket \
"

FILES_${PN}-devd_append = " \
	${systemd_unitdir}/system/xendriverdomain.service \
"
	
SYSTEMD_SERVICE_${PN}-devd_append = " \
	xendriverdomain.service \
"
