{ config, pkgs, ... }:

{
  fonts.fonts = with pkgs; [
      liberastika
  ];
}
