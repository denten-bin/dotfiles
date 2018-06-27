{ config, pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.extraUsers.guest = {
  #   isNormalUser = true;
  #   uid = 1000;
  # };

  users.users.denten = {
    isNormalUser = true;
    home = "/home/denten";
    extraGroups = ["wheel" "video" "audio" "disk" "networkmanager"];
  };
}
