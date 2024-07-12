{ pkgs, ... }:

{
  # Hypridle config
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";  # avoid starting multiple hyprlock instances.
        before_sleep_cmd = "pidof hyprlock || hyprlock";  # lock before suspend.
        after_sleep_cmd = "hyprctl dispatch dpms on";  # to avoid having to press a key twice to turn on the display.
      };
      listener = 
      let 
        batt_status = ''"$(cat /sys/class/power_supply/AC/online)"'';
        screen_on = "hyprctl dispatch dpms on";
        screen_off = "hyprctl dispatch dpms off";
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
          on-timeout = ''[ ${batt_status} = "0" ] && brightnessctl -s set 10''; # set monitor backlight to minimum, avoid 0 on OLED monitor.
          on-resume = "brightnessctl -r";  # monitor backlight restore.
        }
        {
          timeout = 180;  # 3min
          on-timeout = ''[ ${batt_status} = "0" ] && (pidof hyprlock || hyprlock)''; # lock screen when timeout has passed
        }
        {
          timeout = 210;  # 3.5min
          on-timeout = ''[ ${batt_status} = "0" ] && ${screen_off}'';  # screen off when timeout has passed
          on-resume = screen_on;  # screen on when activity is detected after timeout has fired.
        }
        {
          timeout = 600;  # 10min
          on-timeout = ''[ ${batt_status} = "0" ] && ${sleep}''; # suspend pc
        }
        # Listeners on plugged in power
        {
          timeout = 300;  # 5min
          on-timeout = ''[ ${batt_status} = "1" ] && brightnessctl -s set 10''; # set monitor backlight to minimum, avoid 0 on OLED monitor.
          on-resume = "brightnessctl -r";  # monitor backlight restore.
        }
        {
          timeout = 600;  # 10min
          on-timeout = ''[ ${batt_status} = "1" ] && (pidof hyprlock || hyprlock)''; # lock screen when timeout has passed
        }
        {
          timeout = 630;  # 10.5min
          on-timeout = ''[ ${batt_status} = "1" ] && ${screen_off}'';  # screen off when timeout has passed
          on-resume = screen_on;  # screen on when activity is detected after timeout has fired.
        }
        {
          timeout = 1000;  # 30min
          on-timeout = ''[ ${batt_status} = "1" ] && ${sleep}''; # suspend pc
        }
      ];
    };
  };
}