{ config, pkgs, ... }:

{
  fonts.fonts = with pkgs; [
      liberation_ttf
      liberastika
      lmodern
  ];
}
