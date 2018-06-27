{ config, pkgs, ... }:

{
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "ctrl:nocaps";

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  services.xserver.windowManager.i3.enable = true;
  services.xserver.desktopManager.default = "none";
  services.xserver.windowManager.default = "i3";
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.displayManager.lightdm.autoLogin.enable = true;
  services.xserver.displayManager.lightdm.autoLogin.user = "denten";
  services.xserver.displayManager.slim.defaultUser = "denten";

}
