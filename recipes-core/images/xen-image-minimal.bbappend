# fix xen-image-minimal.bb
efi_hddimg_populate_append() {
  install -m 0644 ${DEPLOY_DIR_IMAGE}/xen-${MACHINE}.gz ${DEST}/xen.gz
  install -m 0644 ${DEPLOY_DIR_IMAGE}/xen-${MACHINE}.efi ${DEST}/xen.efi
  [ -n "${XEN_DEPLOY_CFG}" ] && \
    install -m 0644 ${XEN_DEPLOY_CFG} ${DEST}/xen.cfg
}

# fix xen-image-minimal.bb::build_syslinux_cfg_append()
build_syslinux_cfg_prepend() {
  export SYSLINUXCFG="${SYSLINUX_CFG}"
}

# for grub-efi.bbclass
python build_efi_cfg_append() {
    import sys
    import re

    workdir = d.getVar('WORKDIR')
    if not workdir:
        bb.error("WORKDIR not defined, unable to package")
        return

    syslinux_xen_args = d.getVar('SYSLINUX_XEN_ARGS');
    syslinux_kernel_args = d.getVar('SYSLINUX_KERNEL_ARGS');

    xen_kernel_args = syslinux_kernel_args.replace('LABEL=boot', 'LABEL=xen')
    xen_kernel_args = re.sub('ramdisk_size=[0-9]+[a-zA-Z]*[ ]*', '', xen_kernel_args)

    cfile = d.getVar('GRUB_CFG')
    if not cfile:
        bb.fatal('Unable to read GRUB_CFG')

    root = d.getVar('GRUB_ROOT')
    if not root:
        bb.fatal('GRUB_ROOT not defined')

    try:
        cfgfile = open(cfile, 'a')
    except OSError:
        bb.fatal('Unable to open %s' % cfile)

    cfgfile.write('\n')
    cfgfile.write('menuentry \'xen.efi\'{\n')
    cfgfile.write('  insmod part_gpt\n')
    cfgfile.write('  insmod search_fs_uuid\n')
    cfgfile.write('  insmod chain\n')
    cfgfile.write('  chainloader /xen.efi\n')
    cfgfile.write('}\n')

    cfgfile.write('\n')
    cfgfile.write('menuentry \'xen.gz\'{\n')
    cfgfile.write('  insmod part_gpt\n')
    cfgfile.write('  insmod search_fs_uuid\n')
    cfgfile.write('  insmod gzio\n')
    cfgfile.write('  insmod multiboot\n')
    cfgfile.write('  multiboot /xen.gz placeholder %s\n' % syslinux_xen_args)
    cfgfile.write('  module /vmlinuz placeholder %s\n' % xen_kernel_args)
    cfgfile.write('}\n')

    cfgfile.close()

    cfile = re.sub('/grub(.*)\.cfg$', '/xen.cfg', cfile)
    try:
        cfgfile = open(cfile, 'w')
    except OSError:
        bb.fatal('Unable to open %s' % cfile)

    cfgfile.write('[global]\n')
    cfgfile.write('default=boot\n')
    cfgfile.write('[boot]\n')
    cfgfile.write('options=%s\n' % syslinux_xen_args)
    cfgfile.write('kernel=vmlinuz %s\n' % xen_kernel_args)

    cfgfile.close()

    d.setVar('XEN_DEPLOY_CFG', cfile)
}
