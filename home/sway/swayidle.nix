{ pkgs, ... }:

{
  # SwayIdle Config
  services.swayidle = 
  let 
    lock_cmd = "${pkgs.swaylock}/bin/swaylock";
    swaymsg_cmd = "${pkgs.sway}/bin/swaymsg";
  in
  {
    enable = true;
    events = [
      { 
        event = "before-sleep";
        command = lock_cmd;
      }
      {
        event = "after-resume";
        command = "${swaymsg_cmd} 'output * dpms on'";
      }
      {
        event = "lock";
        command = lock_cmd;
      }
    ];
    timeouts = 
    let 
      on_batt = ''[ "$(cat /sys/class/power_supply/AC/online)" = "0" ]'';
      on_plug = ''[ "$(cat /sys/class/power_supply/AC/online)" = "1" ]'';
      batt_status = ''"$(cat /sys/class/power_supply/AC/online)"'';
      screen_on = "${swaymsg_cmd} 'output * dpms on'";
      screen_off = "${swaymsg_cmd} 'output * dpms off'";
      dim_screen = "${pkgs.brightnessctl}/bin/brightnessctl -s set 10";
      undim_screen = "${pkgs.brightnessctl}/bin/brightnessctl -r";
      sleep = "systemctl suspend";  # Nvidia only supports "suspend" and "hibernate" without hackiness 
    in
    [
      {
        timeout = 30;  # 0.5 min
        command = "brightnessctl -sd rgb:kbd_backlight set 0";  # Turn off keyboard backlight
        resumeCommand = "brightnessctl -rd rgb:kbd_backlight";  # Turns backlight back on
      }
            # Listeners on plugged in power
      {
        timeout = 5;  # 5 min
        command = ''${on_plug} && ${dim_screen}''; # set monitor backlight to minimum, avoid 0 on OLED monitor.
        resumeCommand = "${undim_screen}";  # monitor backlight restore.
      }
      {
        timeout = 10;  # 10 min
        command = ''${on_plug} && ${lock_cmd}''; # lock screen when timeout has passed
      }
      {
        timeout = 15;  # 10.5 min
        command = ''${on_plug} && ${screen_off}'';  # screen off when timeout has passed
        resumeCommand = screen_on;  # screen on when activity is detected after timeout has fired.
      }
      {
        timeout = 20;  # 30 min
        command = ''${on_plug} && ${sleep}''; # suspend pc
      }
      # Listeners on battery power
      {
        timeout = 120;  # 2 min
        command = ''${on_batt} && ${dim_screen}''; # set monitor backlight to minimum, avoid 0 on OLED monitor.
        resumeCommand = "${undim_screen}";  # monitor backlight restore.
      }
      {
        timeout = 180;  # 3 min
        command = ''${on_batt} && ${lock_cmd}''; # lock screen when timeout has passed
      }
      {
        timeout = 210;  # 3.5 min
        command = ''${on_batt} && ${screen_off}'';  # screen off when timeout has passed
        resumeCommand = screen_on;  # screen on when activity is detected after timeout has fired.
      }
      {
        timeout = 600;  # 5 min
        command = ''${on_batt} && ${sleep}''; # suspend pc
      }
    ];
  };
}