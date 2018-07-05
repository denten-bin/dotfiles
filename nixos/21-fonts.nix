{ config, pkgs, ... }:

{

  # get the packages
  environment.systemPackages = with pkgs; [
    liberation_ttf
    liberastika
    lmodern
  ];

  # add to fonts
  fonts.fonts = with pkgs; [
      liberation_ttf
      liberastika
      lmodern
  ];

}
