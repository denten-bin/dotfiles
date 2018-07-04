# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

# sudo stow nixos/ -t /etc/nixos/

{ config, pkgs, ... }:

{

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./10-boot.nix
      ./20-localize.nix
      ./21-fonts.nix
      ./30-packages.nix
      ./40-services.nix
      ./50-networking.nix
      ./60-users.nix
      ./70-power.nix
      ./80-apps.nix
    ];

}
