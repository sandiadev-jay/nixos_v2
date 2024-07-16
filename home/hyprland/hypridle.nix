{ pkgs, ... }:

{
  # Hypridle config
  services.hypridle = {
    enable = true;
    settings = 
    let
      lock = "(pidof hyprlock || hyprlock)";
      screen_on = "hyprctl dispatch dpms on";
      screen_off = "hyprctl dispatch dpms off";
    in
      {
      general = {
        lock_cmd = lock;  # avoid starting multiple hyprlock instances.
        before_sleep_cmd = lock;  # lock before suspend.
        after_sleep_cmd = screen_on;  # to avoid having to press a key twice to turn on the display.
      };
      listener = 
      let 
        on_batt = ''[ "$(cat /sys/class/power_supply/AC/online)" = "0" ]'';
        on_plug = ''[ "$(cat /sys/class/power_supply/AC/online)" = "1" ]'';
        sleep = "systemctl suspend";  # Nvidia only supports "suspend" and "hibernate" without hackiness 
      in
      [
        {
          timeout = 30;  # 0.5min.
          on-timeout = "brightnessctl -sd rgb:kbd_backlight set 0";  # turn off keyboard backlight.
          on-resume = "brightnessctl -rd rgb:kbd_backlight";  # turn on keyboard backlight.
        }
        # Listeners on battery power
        {
          timeout = 120;  # 2min.
          on-timeout = ''${on_batt} && brightnessctl -s set 10''; # set monitor backlight to minimum, avoid 0 on OLED monitor.
          on-resume = "brightnessctl -r";  # monitor backlight restore.
        }
        {
          timeout = 180;  # 3min
          on-timeout = ''${on_batt} && (pidof hyprlock || hyprlock)''; # lock screen when timeout has passed
        }
        {
          timeout = 210;  # 3.5min
          on-timeout = ''${on_batt} && ${screen_off}'';  # screen off when timeout has passed
          on-resume = screen_on;  # screen on when activity is detected after timeout has fired.
        }
        {
          timeout = 600;  # 10min
          on-timeout = ''${on_batt} && ${sleep}''; # suspend pc
        }
        # Listeners on plugged in power
        {
          timeout = 300;  # 5min
          on-timeout = ''${on_plug} && brightnessctl -s set 10''; # set monitor backlight to minimum, avoid 0 on OLED monitor.
          on-resume = "brightnessctl -r";  # monitor backlight restore.
        }
        {
          timeout = 600;  # 10min
          on-timeout = ''${on_plug} && (pidof hyprlock || hyprlock)''; # lock screen when timeout has passed
        }
        {
          timeout = 630;  # 10.5min
          on-timeout = ''${on_plug} && ${screen_off}'';  # screen off when timeout has passed
          on-resume = screen_on;  # screen on when activity is detected after timeout has fired.
        }
        {
          timeout = 1000;  # 30min
          on-timeout = ''${on_plug} && ${sleep}''; # suspend pc
        }
      ];
    };
  };
}