## Steps

1. using systemd-boot instead of grub (simpler, no need to rebuild)
2. use `gparted` to understand your partition structure
3. first partition is EFI, windows update may clobber systemd-boot
4. to reinstall systemd-boot:
5. boot with live-usb
6. mount the linux partition (`msblk`, then `mount` from /dev to /mnt)
7. remember to use `arch-chroot` if on arch-based systems 
8. once inside, switch user (`su`) to your main user, then
9. `mount` the efi partition to /efi
10. then run `bootctl install` as per <https://wiki.archlinux.org/title/systemd-boot>
11. check that systemd menu is showing up on boot
12. to add your linux to the systemd-boot menu run `reinstall-kernels` from inside of your
  arch-chroot
13. verify new entries in `/efi/loader/enties`

## Resources

- <https://discovery.endeavouros.com/installation/systemd-boot/2022/12/>
- <https://forum.endeavouros.com/t/tutorial-convert-to-systemd-boot/13290/577?page=28>


