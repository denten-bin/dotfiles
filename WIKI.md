https://discovery.endeavouros.com/installation/systemd-boot/2022/12/
- using systemd-boot instead of grub (simpler, no need to rebuild)
- first partition is EFI, windows update may clobber systemd-boot
- to reinstall systemd-boot:
- boot with live-usb
- mount the linux partition (`msblk`, then `mount` from /dev to /mnt)
- remember to use `arch-chroot` if on arch-based systems 
- once inside, `mount` the efi partition to /efi
- then run `bootctl install` as per <https://wiki.archlinux.org/title/systemd-boot>
- check that systemd menu is showing up on boot
- to add your linux to the systemd-boot menu run `reinstall-kernels` from inside of your
  arch-chroot
- verify new entries in `/efi/loader/enties`

