{ config, pkgs, ... }:

{
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelModules = [ "acpi" "thinkpad-acpi" "acpi-call" ];
  boot.extraModulePackages =
    [
    config.boot.kernelPackages.acpi_call
    ];

  boot.extraModprobeConfig = "options thinkpad_acpi experimental=1 fan_control=1";

  # Mount encryted partition before looking for LVM
  boot.initrd.luks.devices = [
    {
      name = "root";
      device = "/dev/nvme0n1p3";
      preLVM = true;
    }
  ];
}
