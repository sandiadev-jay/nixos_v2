# Add system fonts
{ config, pkgs, ... }:

{
  # Add fonts
  fonts.packages = with pkgs; [
    nerdfonts
    roboto
  ];
}
