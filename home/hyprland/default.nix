{ inputs, config, pkgs, ... }:

{
  imports = [
    ./hypridle.nix
    ./hyprland.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./waybar.nix
  ];
}

