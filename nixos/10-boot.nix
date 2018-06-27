{ config, pkgs, ... }:

{
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelModules = [ "tp_smapi" ];
  boot.extraModulePackages =
    [
    config.boot.kernelPackages.tp_smapi
    config.boot.kernelPackages.acpi_call
    ];

  # Mount encryted partition before looking for LVM
  boot.initrd.luks.devices = [
    {
      name = "root";
      device = "/dev/nvme0n1p3";
      preLVM = true;
    }
  ];
}
