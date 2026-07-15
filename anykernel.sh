### AnyKernel3 Ramdisk Mod Script
## osm0sis @ xda-developers
### AnyKernel setup
# begin properties
properties() { '
kernel.string=Spacewar by @Biased69-KittenLover
do.devicecheck=0
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
supported.versions=11.0-17.0
supported.patchlevels=
supported.vendorpatchlevels=
'; } # end properties
# shell variables
block=boot;
is_slot_device=auto;
ramdisk_compression=auto;
patch_vbmeta_flag=auto;
## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;
## AnyKernel boot install
dump_boot;
vbmeta_disable_verification;

## Strip stale recovery module references — these drivers are now built into
## the kernel (see lahaina-qgki_defconfig m->y changes), so init's attempt to
## insmod them during recovery boot from lib/modules/modules.load.recovery
## fails immediately and bootloops recovery. The .ko files no longer exist,
## so remove the load-list entries; the drivers are already compiled in.
remove_line lib/modules/modules.load.recovery fts_tp.ko;
remove_line lib/modules/modules.load.recovery q6_pdr_dlkm.ko;
remove_line lib/modules/modules.load.recovery q6_notifier_dlkm.ko;
remove_line lib/modules/modules.load.recovery snd_event_dlkm.ko;
remove_line lib/modules/modules.load.recovery apr_dlkm.ko;
remove_line lib/modules/modules.load.recovery adsp_loader_dlkm.ko;

write_boot;
## end boot install