{ inputs, config, pkgs, ... }:

{
  # Ancillary service enablement
  # programs.waybar.enable = true;
  services.swaync.enable = true;

  # Hyprland setup
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    systemd.variables = ["--all"];
    xwayland.enable = true;

    # Hyprland config 
    settings = {
      "$mod" = "SUPER";
      "$terminal" = "kitty";
      "$fileManager" = "io.elementary.files";

      general = {
        gaps_in = 2;
        gaps_out = 4;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
        allow_tearing = false;
      };

      group = {
        "col.border_active" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.border_inactive" = "rgba(595959aa)";
        groupbar = {
          "col.active" = "rgba(1A355Bee)";
          "col.inactive" = "rgba(595959dd)";
        };
      };

      decoration = {
        rounding = 5;
        blur = {
          enabled = false;
          size = 3;
          passes = 1;
        };
        drop_shadow = false;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
      };

      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windowsIn, 0, 7, myBezier"
          "windowsOut, 0, 7, default, popin 80%"
          "border, 0, 10, default"
          "borderangle, 0, 8, default"
          "fade, 0, 7, default"
          "workspaces, 0, 6, default"
        ];
      };

      # Set up monitor preferences
      monitor = [
        ", preferred, auto, auto"
        "eDP-1, preferred, -1729x1080, 2"
        "desc:Samsung Electric Company U32R59x HNAR100470, preferred, 0x0, 1"
        "desc:Samsung Electric Company U32R59x H4ZM712156, preferred, 3840x0, 1"
      ];

      # Bind workspaces to monitors
      workspace = [
        "1, monitor:eDP-1, default:true"
        "2, monitor:desc:Samsung Electric Company U32R59x HNAR100470, default:true"
        "3, monitor:desc:Samsung Electric Company U32R59x H4ZM712156, default:true"
      ];

      # Dwindle is standard - use mod P to toggle pseudotile
      dwindle = {
        pseudotile = true; 
        preserve_split = true;
        force_split = 2;
        no_gaps_when_only = 1;
      };

      misc = {
        force_default_wallpaper = 0;
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = true;
        vfr = true;  # Frame rate reduction when no changes occur, true could save battery life
      };

      # Set floating windows
      windowrulev2 = [
        "float, title:^(Open Folder)$"
        "float, title:^(Open File)$"
      ];

      # Launch programs at start
      exec-once = [
        # "1password"
        "waybar"
        "hypridle"
        "swaync"
        "lxqt-policykit-agent"
        "nm-applet"
        "sleep 5 && google-drive-ocamlfuse -label SandiaDev ~/SandiaDev\ GDrive"
        "sleep 5 && google-drive-ocamlfuse -label Kinektit ~/Kinektit\ GDrive"
      ];

      # Set environment variables
      env = [
        "XDG_SESSION_TYPE,wayland"
        "QT_QPA_PLATFORM,wayland"
        # "LIBVA_DRIVER_NAME,nvidia"
        # "GBM_BACKEND,nvidia-drm"
        # "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        # "NVD_BACKEND,direct"
      ];

      input = {
        kb_layout = "us";
        numlock_by_default = true;
        follow_mouse = true;
        sensitivity = 0;

        touchpad = {
          natural_scroll = true;
          disable_while_typing = true;
        };
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 4;
        workspace_swipe_forever = false;
        workspace_swipe_cancel_ratio = 0.4;
      };

      bindr = [
        # Launcher
        "SUPER, SUPER_L, exec, pkill rofi || rofi -show drun"
      ];

      bind = [
        # App Shortcuts
        "$mod, SPACE, exec, pkill rofi || rofi -show window"
        "$mod ALT, SPACE, exec, pkill rofi || rofi -show run"
        ", PRINT, exec, pkill hyprshot || hyprshot -m region -o ~/Pictures/Screen\ Shots"
        "$mod, RETURN, exec, kitty"
        "$mod, F, exec, io.elementary.files"
        "$mod, R, exec, kitty -e ranger"
        "$mod, Q, killactive,"
        "$mod SHIFT, E, exit,"
        "$mod SHIFT, F, fullscreen, 1"  # Toggle full screen (1 keeps title bar)
        "$mod SHIFT, SPACE, togglefloating,"
        ''$mod, SEMICOLON, exec, google-chrome-stable --profile-directory="SandiaDev"''  # SandiaDev profile
        ''$mod SHIFT, SEMICOLON, exec, google-chrome-stable --profile-directory="Kinektit"''  # Kinektit profile
        "$mod SHIFT CTRL, SEMICOLON, exec, brave"
        "$mod, C, exec, code"

        # Window layouts
        "$mod, P, pseudo,"  # dwindle
        "$mod, J, togglesplit,"  # dwindle
        
        # Move focus
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"        

        # Move window
        "$mod SHIFT, left, movewindoworgroup, l"
        "$mod SHIFT, right, movewindoworgroup, r"
        "$mod SHIFT, up, movewindoworgroup, u"
        "$mod SHIFT, down, movewindoworgroup, d"

        # Move workspace in a certain direction
        "$mod ALT CTRL, left, movecurrentworkspacetomonitor, l"
        "$mod ALT CTRL, right, movecurrentworkspacetomonitor, r"
        "$mod ALT CTRL, up, movecurrentworkspacetomonitor, u"
        "$mod ALT CTRL, down, movecurrentworkspacetomonitor, d"

        # Switch workspaces (with keypad alternative)
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"
        "$mod CTRL, RIGHT, workspace, +1"
        "$mod CTRL, LEFT, workspace, -1"
        "$mod, KP_END, workspace, 1"
        "$mod, KP_DOWN, workspace, 2"
        "$mod, KP_NEXT, workspace, 3"
        "$mod, KP_LEFT, workspace, 4"
        "$mod, KP_BEGIN, workspace, 5"
        "$mod, KP_RIGHT, workspace, 6"
        "$mod, KP_HOME, workspace, 7"
        "$mod, KP_UP, workspace, 8"
        "$mod, KP_PRIOR, workspace, 9"
        "$mod, KP_INSERT, workspace, 10"

        # Move active window to a workspace
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"
        "$mod CTRL SHIFT, RIGHT, movetoworkspace, +1"
        "$mod CTRL SHIFT, LEFT, movetoworkspace, -1"
        "$mod SHIFT, KP_END, movetoworkspace, 1"
        "$mod SHIFT, KP_DOWN, movetoworkspace, 2"
        "$mod SHIFT, KP_NEXT, movetoworkspace, 3"
        "$mod SHIFT, KP_LEFT, movetoworkspace, 4"
        "$mod SHIFT, KP_BEGIN, movetoworkspace, 5"
        "$mod SHIFT, KP_RIGHT, movetoworkspace, 6"
        "$mod SHIFT, KP_HOME, movetoworkspace, 7"
        "$mod SHIFT, KP_UP, movetoworkspace, 8"
        "$mod SHIFT, KP_PRIOR, movetoworkspace, 9"
        "$mod SHIFT, KP_INSERT, movetoworkspace, 10"

        # Move active window but don't follow
        "$mod CTRL SHIFT, 1, movetoworkspacesilent, 1"
        "$mod CTRL SHIFT, 2, movetoworkspacesilent, 2"
        "$mod CTRL SHIFT, 3, movetoworkspacesilent, 3"
        "$mod CTRL SHIFT, 4, movetoworkspacesilent, 4"
        "$mod CTRL SHIFT, 5, movetoworkspacesilent, 5"
        "$mod CTRL SHIFT, 6, movetoworkspacesilent, 6"
        "$mod CTRL SHIFT, 7, movetoworkspacesilent, 7"
        "$mod CTRL SHIFT, 8, movetoworkspacesilent, 8"
        "$mod CTRL SHIFT, 9, movetoworkspacesilent, 9"
        "$mod CTRL SHIFT, 0, movetoworkspacesilent, 10"
        "$mod CTRL SHIFT, KP_END, movetoworkspacesilent, 1"
        "$mod CTRL SHIFT, KP_DOWN, movetoworkspacesilent, 2"
        "$mod CTRL SHIFT, KP_NEXT, movetoworkspacesilent, 3"
        "$mod CTRL SHIFT, KP_LEFT, movetoworkspacesilent, 4"
        "$mod CTRL SHIFT, KP_BEGIN, movetoworkspacesilent, 5"
        "$mod CTRL SHIFT, KP_RIGHT, movetoworkspacesilent, 6"
        "$mod CTRL SHIFT, KP_HOME, movetoworkspacesilent, 7"
        "$mod CTRL SHIFT, KP_UP, movetoworkspacesilent, 8"
        "$mod CTRL SHIFT, KP_PRIOR, movetoworkspacesilent, 9"
        "$mod CTRL SHIFT, KP_INSERT, movetoworkspacesilent, 10"

        # Scratchpad workspace
        "$mod, S, togglespecialworkspace, magic"
        "$mod SHIFT, S, movetoworkspace, special:magic"

        # Scroll through existing workspaces with mod + scroll
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"

        # Volume controls
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-"
        " CTRL, XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SOURCE@ 5%+"
        " CTRL, XF86AudioLowerVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SOURCE@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        " CTRL, XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        
        # Backlight controls
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
        ", XF86MonBrightnessUp, exec, brightnessctl set +5%"

        # Screen lock shortcut
        "$mod, L, exec, pidof hyprlock || hyprlock"

        # Group Binds
        "$mod, T, togglegroup"
        "$mod ALT, right, changegroupactive, f"
        "$mod ALT, left, changegroupactive, b"

        # Focus last focused window
        "$mod, TAB, focuscurrentorlast"
        "$mod, GRAVE, focusurgentorlast"
      ];

      bindm = [
        # Move/resize windows with LMB/RMB and mod
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      bindl = [
        ", switch:on:Lid Switch, exec, systemctl default"
        ", switch:off:Lid Switch, exec, systemctl hybrid-sleep"
        ", power-button, exec, systemctl suspend-then-hibernate"
      ];
    };
  };
}
