{ inputs, config, pkgs, lib, ... }:

{
  wayland.windowManager.sway = {
    enable = true;
    checkConfig = true;
    swaynag.enable = true;  # Error bar

    config = {

      # General Stuff
      modifier = "Mod4";
      terminal = "kitty";
      workspaceAutoBackAndForth = true;  # Toggle current workspace to return to where I came from
      menu = "rofi";

      startup = [
        { command = "hypridle"; }
        { command = "nm-applet"; }
        { command = "google-drive-ocamlfuse -label SandiaDev ~/SandiaDev\ GDrive"; }
        { command = "google-drive-ocamlfuse -label Kinektit ~/Kinektit\ GDrive"; }
      ];


      # Direction keys
      left = "Left";
      right = "Right";
      up = "Up";
      down = "Down";

      # Focus stuff
      focus = {
        followMouse = "yes";
        wrapping = "yes";
        mouseWarping = true;
        newWindow = "smart";

      };

      # Key Binds
      keybindings = let 
        mod = config.wayland.windowManager.sway.config.modifier;
      in {
        # Sway General Shortcuts
        "${mod}+Q" = "kill";
        "${mod}+Shift+E" = "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -B 'Yes, exit sway' 'swaymsg exit'";
        "${mod}+Shift+R" = "reload";
        "${mod}+Space" = "exec pkill rofi || rofi -show drun";  # Drun list (desktop files) from path
        "${mod}+Alt+Space" = "exec pkill rofi || rofi -show window";  # Open windows
        "${mod}+Ctrl+Alt+Space" = "exec pkill rofi || rofi -show run";  # Application list from path
        "${mod}+L" = "exec pkill hyprlock || hyprlock";  # Lock screen

        # Brightness Control
        "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
        "XF86MonBrightnessUp" = "exec brightnessctl set +5%";

        # Sound Control
        "XF86AudioRaiseVolume" = "exec wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+";
        "XF86AudioLowerVolume" = "exec wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-";
        "XF86AudioMute" = "exec wpctl set-mute";
        "Ctrl+XF86AudioRaiseVolume" = "wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SOURCE@ 5%+";
        "Ctrl+XF86AudioLowerVolume" = "wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SOURCE@ 5%-";
        "Ctrl+XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";

        # Layout Stuff
        "${mod}+V" = "splitv";
        "${mod}+B" = "splith";
        "${mod}+S" = "layout stacking";
        "${mod}+T" = "layout tabbed";
        "${mod}+J" = "layout toggle split";
        "${mod}+F" = "fullscreen";
        "${mod}+Shift+Space" = "floating toggle";
        "${mod}+Ctrl+Space" = "focus mode_toggle";

        # Scratchpad
        "${mod}+Minus" = "scratchpad show";
        "${mod}+Shift+Minus" = "move scratchpad";

        # Modes (enter modes)
        "${mod}+R" = ''mode "resize"'';
        
        # App Shortcuts
        "${mod}+Return" = "exec kitty";  # Terminal
        "${mod}+Semicolon" = ''exec google-chrome-stable --profile-directory="SandiaDev"'';  # Chrome SaniaDev Profile
        "${mod}+Shift+Semicolon" = ''exec google-chrome-stable --profile-directory="Kinektit"'';  # Chrome Kinektit Profile
        "${mod}+Shift+Ctrl+Semicolon" = "exec brave";  # Brave Browser
        "${mod}+C" = "exec code";  # VS Code

        ### Focus ###
        # Move focus
        "${mod}+A" = "focus parent";
        "${mod}+Left" = "focus left";
        "${mod}+Right" = "focus right";
        "${mod}+Up" = "focus up";
        "${mod}+Down" = "focus down";

        # Move focused window
        "${mod}+Shift+Left" = "move left";
        "${mod}+Shift+Right" = "move right";
        "${mod}+Shift+Up" = "move up";
        "${mod}+Shift+Down" = "move down";
        
        ### Workspaces ###
        # Switch to workspace
        "${mod}+1" = "workspace number 1";
        "${mod}+2" = "workspace number 2";
        "${mod}+3" = "workspace number 3";
        "${mod}+4" = "workspace number 4";
        "${mod}+5" = "workspace number 5";
        "${mod}+6" = "workspace number 6";
        "${mod}+7" = "workspace number 7";
        "${mod}+8" = "workspace number 8";
        "${mod}+9" = "workspace number 9";
        "${mod}+0" = "workspace number 10";

        # Move focused container to workspace
        "${mod}+Shift+1" = "move container to workspace number 1";
        "${mod}+Shift+2" = "move container to workspace number 2";
        "${mod}+Shift+3" = "move container to workspace number 3";
        "${mod}+Shift+4" = "move container to workspace number 4";
        "${mod}+Shift+5" = "move container to workspace number 5";
        "${mod}+Shift+6" = "move container to workspace number 6";
        "${mod}+Shift+7" = "move container to workspace number 7";
        "${mod}+Shift+8" = "move container to workspace number 8";
        "${mod}+Shift+9" = "move container to workspace number 9";
        "${mod}+Shift+0" = "move container to workspace number 10";

        # Move workspace in a certain direction
        "${mod}+Alt+Ctrl+Left" = "move workspace to output left";
        "${mod}+Alt+Ctrl+Right" = "move workspace to output right";
        "${mod}+Alt+Ctrl+Up" = "move workspace to output up";
        "${mod}+Alt+Ctrl+Down" = "move workspace to output down";
      };

      # Default workspace
      defaultWorkspace = "workspace number 1";

      # Inputs
      input = {
        "type:touchpad" = {
          dwt = "enabled";
          tap = "enabled";
          natural_scroll = "enabled";
          middle_emulation = "enabled";
        };
        "type:keyboard" = {
          xkb_numlock = "enabled";
        };
      };

      # Modes (for layout)
      modes = {
        resize = {
          Down = "resize grow height 10 px";
          Left = "resize shrink width 10 px";
          Right = "resize grow width 10 px";
          Up = "resize shrink height 10 px";
          Escape = "mode default";
          Return = "mode default";
        };
      };

      # Bar
      bars = [ 
        { command = "waybar"; } 
      ];

      # Starting with border configs
      colors = {

        # Urgent
        urgent = {
          background = "#900000";
          border = "#2f343a";
          childBorder = "#900000";
          indicator = "#900000";
          text = "#ffffff";
        };

        # Unfocused
        unfocused = {
          background = "#222222";
          border = "#333333";
          childBorder = "#222222";
          indicator = "#292d2e";
          text = "#888888";
        };

        # Focused
        focused = {
          background = "#0ADD08";
          border = "#0ADD08";
          childBorder = "#0ADD08";
          indicator = "#2e9ef4";
          text = "#ffffff";
        };

        # Focused Inactive
        focusedInactive = {
          background = "#5f676a";
          border = "#333333";
          childBorder = "#5f676a";
          indicator = "#484e50";
          text = "#ffffff";
        };
      };

      # Gaps
      gaps = {
        smartBorders = "on";
        smartGaps = true;
        inner = 4;
        outer = 4;
      };

      # Window Settings
      window = {
        border = 2;
        titlebar = false;
      };
    };
    
    # Extra Config
    # Touchpad gestures
    # Output config
    extraConfig = '' 
      bindgesture swipe:4:right workspace prev
      bindgesture swipe:4:left workspace next
      bindgesture swipe:3:right focus left
      bindgesture swipe:3:left focus right
      bindgesture swipe:3:down focus up
      bindgesture swipe:3:up focus down
      output eDP-1 pos -1729 1080 scale 2
      output "Samsung Electric Company U32R59x HNAR100470" pos 0 0 scale 1
      output "Samsung Electric Company U32R59x H4ZM712156" pos 3840 0 scale 1
      workspace 1 output eDP-1
      workspace 2 output "Samsung Electric Company U32R59x HNAR100470"
      workspace 3 output "Samsung Electric Company U32R59x H4ZM712156"
    '';
  };
}