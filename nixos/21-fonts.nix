{ config, pkgs, ... }:

{

  # get the packages
  environment.systemPackages = with pkgs; [
    cabin
    liberation_ttf
    liberastika
    lmodern
    paratype-pt-serif
    poly
  ];

  # add to fonts
  fonts.fonts = with pkgs; [
      cabin
      liberation_ttf
      liberastika
      lmodern
      paratype-pt-serif
      poly
  ];

}
