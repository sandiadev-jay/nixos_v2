{ inputs, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    style = ./waybar.css;
    settings = {
    
      mainbar = {
        
        # General positional settings
        layer = "top";
        position = "top";
        height = 30;
        spacing = 4;

        # Module Layout
        modules-left = [
          "hyprland/workspaces"
          "hyprland/submap"
          "sway/workspaces"
          "sway/mode"
          # "wlr/taskbar"
        ];

        modules-center = [
          "hyprland/window"
          "sway/window"
        ];
        modules-right = [
          "tray"
          "idle_inhibitor"
          "pulseaudio"
          "network"
          "bluetooth"
          # "power-profiles-daemon"
          "cpu"
          "memory"
          "temperature"
          "backlight"
          "keyboard-state"
          # "hyprland/language"
          "battery"
          # "battery#bat2"
          "clock"
        ];

        # Module configurations
        "hyprland/workspaces" = {
          format = "{name}:{windows} |";
          format-window-separator = " ";
          window-rewrite-default = "";
          window-rewrite = {
            chrome = "";
            firefox = "󰈹";
            code = "";
            kitty = "";
            nwg-look = "";
            brave = "󰄛";
            "1password" = "";
          };
        };

        keyboard-state = {
          numlock = true;
          capslock = true;
          format = "{name} {icon}";
          format-icons = {
            locked = "";
            unlocked = "";
          };
        };

        "hyprland/submap" = {
          format = "{icon} {count}";
          show-empty = false;
          format-icons = ["" ""];
          tooltip = true;
          tooltip-format = "{app}: {title}";
        };

        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "󰈈";
            deactivated = " ";
          };
        };

        clock = {
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format = "{:%Y-%m-%d | %H:%M}";
        };

        cpu = {
          format = "";
          tooltip = "CPU Usage {usage}%";
          on-click = "btop";
        };

        memory = {
          format = " ";
          tooltip = "Memory Usage {}%";
          on-click = "btop";
        };

        temperature = {
          thermal-zone = 13;
          critical-threshold = 80;
          format-critical = "{icon}";
          format = "{icon}";
          format-icons = ["" "" ""];
          tooltip = "CPU Temp: {temperatureC}C";
        };

        backlight = {
          format = "{icon}";
          format-icons = ["" "" "" "" "" "" "" "" "" "" "" "" "" "" ""];
          tooltip = "Backlight: {percent}%";
        };

        battery = {
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-time = "{H}h {M}m";
          format-full = "{capacity}% {icon}";
          format-charging = "{capacity}% 󰂄";
          format-plugged = "{capacity}% 󰚥";
          format-icons = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
          tooltip = "Discharging: {capacity}% {time}";
          tooltip-full = "Discharging: {capacity}% {time}";
          tooltip-charging = "Time to full: {capacity}% {time}";
          tooltip-plugged = "Plugged In: {capacity}%";
        };

        network = {
          format-wifi = "{icon}";
          format-ethernet = "󰈀";
          tooltip-format = ''Signal Strength: {signalStrength}%
          {essid}
          {ipaddr}/{cidr}
          {ifname} via {gwaddr}'';
          format-linked = "{ifname} (No IP) ";
          format-disconnected = "Disconnected ⚠";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
          format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
          on-click = "nm-applet";
        };

        pulseaudio = {
          # // "scroll-step": 1; // %; can be a float
          format = "{icon} {format_source}";
          format-bluetooth = "{icon}  {format_source}";
          format-bluetooth-muted = "󰸈 {icon}  {format_source}";
          format-muted = "󰸈 {format_source}";
          format-source = "";
          format-source-muted = "󰍭";
          format-icons = {
              headphone = "";
              hands-free = "";
              headset = "";
              phone = "";
              portable = "";
              car = "";
              default = ["󰕿" "󰖀" "󰕾"];
          };
          tooltip = "Sound: {volume}% | Microphone: {format_source}";
          on-click = "pwvucontrol";
        };

        bluetooth = {
          format = "󰂯";
          format-disabled = "󰂲"; # an empty format will hide the module
          format-connected = " {num_connections}";
          tooltip-format = "{controller_alias}\t{controller_address}";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
          on-click = "blueman-manager";
        };

      #   "custom/media" = {
      #     format=  "{icon} {}";
      #     return-type=  "json";
      #     max-length=  40;
      #     format-icons=  {
      #         spotify =  "";
      #         default =  "🎜";
      #     };
      #     escape = true;
      #     exec = "$HOME/.config/waybar/mediaplayer.py 2> /dev/null"; # Script in resources folder
      #     exec = "$HOME/.config/waybar/mediaplayer.py --player spotify 2> /dev/null"; # Filter player based on name
      # };
      };
    };
  };
}