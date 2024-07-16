{ pkgs, ... }:

{
  # SwayIdle Config
  services.swayidle = {
    enable = true;
    events = [
      { 
        event = "before-sleep";
        command = "swaylock";
      }
      {
        event = "after-resume";
        command = "swaymsg 'output * dpms on'";
      }
      {
        event = "lock";
        command = "swaylock";
      }
    ];
    timeouts = 
    let 
      batt_status = ''"$(cat /sys/class/power_supply/AC/online)"'';
      screen_on = "swaymsg 'output * dpms on'";
      screen_off = "swaymsg 'output * dpms off'";
      sleep = "systemctl suspend";  # Nvidia only supports "suspend" and "hibernate" without hackiness 
    in
    [
      {
        timeout = 30;  # 0.5 min
        command = "brightnessctl -sd rgb:kbd_backlight set 0";  # Turn off keyboard backlight
        resumeCommand = "brightnessctl -rd rgb:kbd_backlight";  # Turns backlight back on
      }
      # Listeners on battery power
      {
        timeout = 120;  # 2 min
        command = ''[ ${batt_status} = "0" ] && brightnessctl -s set 10''; # set monitor backlight to minimum, avoid 0 on OLED monitor.
        resumeCommand = "brightnessctl -r";  # monitor backlight restore.
      }
      {
        timeout = 180;  # 3 min
        command = ''[ ${batt_status} = "0" ] && swaylock''; # lock screen when timeout has passed
      }
      {
        timeout = 210;  # 3.5 min
        command = ''[ ${batt_status} = "0" ] && ${screen_off}'';  # screen off when timeout has passed
        resumeCommand = screen_on;  # screen on when activity is detected after timeout has fired.
      }
      {
        timeout = 600;  # 5 min
        command = ''[ ${batt_status} = "0" ] && ${sleep}''; # suspend pc
      }
      # Listeners on plugged in power
      {
        timeout = 300;  # 5 min
        command = ''[ ${batt_status} = "1" ] && brightnessctl -s set 10''; # set monitor backlight to minimum, avoid 0 on OLED monitor.
        resumeCommand = "brightnessctl -r";  # monitor backlight restore.
      }
      {
        timeout = 600;  # 10 min
        command = ''[ ${batt_status} = "1" ] && swaylock''; # lock screen when timeout has passed
      }
      {
        timeout = 630;  # 10.5 min
        command = ''[ ${batt_status} = "1" ] && ${screen_off}'';  # screen off when timeout has passed
        resumeCommand = screen_on;  # screen on when activity is detected after timeout has fired.
      }
      {
        timeout = 1000;  # 30 min
        command = ''[ ${batt_status} = "1" ] && ${sleep}''; # suspend pc
      }
    ];
  };
}