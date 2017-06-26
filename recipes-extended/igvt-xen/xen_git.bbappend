#
# for Intel GVT-g
#

SRCREV = "6d3828d156cfba6aedd069f8ac7337a79e396215"

XEN_REL = "4.9"
XEN_BRANCH = "xengt-stable-4.9"

PV = "${XEN_REL}+git${SRCPV}"

FILESEXTRAPATHS_append := ":${THISDIR}/files"
SRC_URI = " \
    git://github.com/01org/igvtg-xen;branch=${XEN_BRANCH} \
    file://fix_werror.patch \
    "

# FIXME
do_configure_prepend() {
	[ -f "${STAGING_INCDIR}/bits/long-double-64.h" -a ! -f "${STAGING_INCDIR}/bits/long-double-32.h" ] && \
	cp ${STAGING_INCDIR}/bits/long-double-64.h ${STAGING_INCDIR}/bits/long-double-32.h
}

# append 2 packages
PACKAGES_append = " \
	${PN}-xendevicemodel \
	${PN}-xendevicemodel-dev \
"

FILES_${PN}-xendevicemodel_append = " \
	${libdir}/libxendevicemodel.so.* \
"
RDEPENDS_${PN}-base_append = " \
	${PN}-xendevicemodel \
"

# append *.pc to devel pacakage
FILES_${PN}-dev_append = " \
	${datadir}/pkgconfig/*.pc \
"

# append *.so to devel package
FILES_${PN}-xendevicemodel-dev_append = " \
	${libdir}/libxendevicemodel.so \
"

# remove
FILES_${PN}-xencommons_remove = " \
	${systemd_unitdir}/system/xenstored.socket \
	${systemd_unitdir}/system/xenstored_ro.socket \
"

# remove
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
