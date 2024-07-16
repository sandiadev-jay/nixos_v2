{ inputs, config, pkgs, lib, ... }:

{
  imports = [
    ./sway.nix
    ./swayidle.nix
    ./swaylock.nix
  ];
}