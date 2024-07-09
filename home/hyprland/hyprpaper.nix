{ config, pkgs, ... }:

{
  # Hyprpaper config
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;

      preload = [ "/home/jay/Pictures/Backgrounds/background.jpg" ];
      wallpaper = [ ",/home/jay/Pictures/Backgrounds/background.jpg" ];
    };
  };
}