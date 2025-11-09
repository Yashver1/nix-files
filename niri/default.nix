{
  pkgs,
  ...
}:
{
  # In home.nix
  programs.niri = {
    enable = true;
    package = pkgs.niri;

    settings = {

      input = {
        keyboard = {
          xkb = {
            # Example:
            # layout = "us,ru";
            # options = "grp:win_space_toggle,compose:ralt,ctrl:nocaps";
          };
          numlock = true;
        };

        touchpad = {
          tap = true;
          natural-scroll = true;
        };

        mouse = {
          # off = true;
        };

        trackpoint = {
          # off = true;
        };

        # warp-mouse-to-focus = true;

        focus-follows-mouse = {
          max-scroll-amount = "0%";
        };
      };

      /*
        # Outputs are defined by their name. Find yours with `niri msg outputs`
        # The user's original config had this commented out.
        outputs."eDP-1" = {
          # off = true;
          mode = "1920x1080@120.030";
          scale = 2;
          transform = "normal";
          position = { x = 1280; y = 0; };
        };
      */

      # Use the output config from your previous attempts
      outputs."eDP-1".scale = 2.0;

      layout = {
        gaps = 16;
        center-focused-column = "never";

        # KDL nodes with the same name become a list in Nix
        preset-column-widths = [
          { proportion = 0.33333; }
          { proportion = 0.5; }
          { proportion = 0.66667; }
          # { fixed = 1920; }
        ];

        # preset-window-heights = [ ];

        default-column-width = {
          proportion = 0.5;
        };

        focus-ring = {
          off = true;
          width = 4;
          active-color = "#7fc8ff";
          inactive-color = "#505050";
          # active-gradient = { from = "#80c8ff"; to = "#c7ff7f"; angle = 45; };
        };

        border = {
          off = true;
          width = 4;
          active-color = "#ffc87f";
          inactive-color = "#505050";
          urgent-color = "#9b0000";
        };

        shadow = {
          # on = true;
          # draw-behind-window = true;
          softness = 30;
          spread = 5;
          offset = {
            x = 0;
            y = 5;
          };
          color = "#0007";
        };

        struts = {
          # left = 64;
          # right = 64;
          # top = 64;
          # bottom = 64;
        };
      };

      # KDL nodes with the same name become a list in Nix
      spawn-at-startup = [
        "noctalia-shell"
      ];

      # spawn-sh-at-startup = [
      #   "qs -c ~/source/qs/MyAwesomeShell"
      # ];

      hotkey-overlay = {
        # skip-at-startup = true;
      };

      prefer-no-csd = true;

      screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";
      # screenshot-path = null;

      animations = {
        # off = true;
        # slowdown = 3.0;
      };

      # KDL 'window-rule' (singular) becomes 'window-rules' (plural) in Nix
      window-rules = [
        {
          # KDL 'match' (singular) becomes 'match' (plural list) in Nix
          match = [
            # Use Nix indented strings (two single quotes) for regexes
            { app-id = ''^org\.wezfurlong\.wezterm$''; }
          ];
          default-column-width = { };
        }
        {
          match = [
            {
              app-id = ''firefox$'';
              title = ''^Picture-in-Picture$'';
            }
          ];
          open-floating = true;
        }
        /*
          {
            match = [
              { app-id = ''^org\.keepassxc\.KeePassXC$''; }
              { app-id = ''^org\.gnome\.World\.Secrets$''; }
            ];
            block-out-from = "screen-capture";
          }
        */
        /*
          {
            geometry-corner-radius = 12;
            clip-to-geometry = true;
          }
        */
      ];

      binds = {
        "Mod+Shift+Slash" = {
          show-hotkey-overlay = true;
        };

        "Mod+T" = {
          hotkey-overlay-title = "Open a Terminal: ghostty";
          spawn = [ "ghostty" ]; # KDL 'spawn "arg"' becomes 'spawn = [ "arg" ]'
        };
        "Mod+D" = {
          hotkey-overlay-title = "Run an Application: fuzzel";
          spawn = [ "fuzzel" ];
        };
        "Super+Alt+L" = {
          hotkey-overlay-title = "Lock the Screen: swaylock";
          spawn = [ "swaylock" ];
        };

        "Super+Alt+S" = {
          allow-when-locked = true;
          hotkey-overlay-title = null;
          spawn-sh = "pkill orca || exec orca";
        };

        "XF86AudioRaiseVolume" = {
          allow-when-locked = true;
          spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+";
        };
        "XF86AudioLowerVolume" = {
          allow-when-locked = true;
          spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-";
        };
        "XF86AudioMute" = {
          allow-when-locked = true;
          spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        };
        "XF86AudioMicMute" = {
          allow-when-locked = true;
          spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
        };

        # KDL 'spawn "arg1" "arg2"' becomes 'spawn = [ "arg1" "arg2" ]'
        "XF86MonBrightnessUp" = {
          allow-when-locked = true;
          spawn = [
            "brightnessctl"
            "--class=backlight"
            "set"
            "+10%"
          ];
        };
        "XF86MonBrightnessDown" = {
          allow-when-locked = true;
          spawn = [
            "brightnessctl"
            "--class=backlight"
            "set"
            "10%-"
          ];
        };

        "Mod+O" = {
          repeat = false;
          toggle-overview = true;
        };
        "Mod+Q" = {
          repeat = false;
          close-window = true;
        };

        "Mod+Left" = {
          focus-column-left = true;
        };
        "Mod+Down" = {
          focus-window-down = true;
        };
        "Mod+Up" = {
          focus-window-up = true;
        };
        "Mod+Right" = {
          focus-column-right = true;
        };
        "Mod+H" = {
          focus-column-left = true;
        };
        "Mod+J" = {
          focus-window-down = true;
        };
        "Mod+K" = {
          focus-window-up = true;
        };
        "Mod+L" = {
          focus-column-right = true;
        };

        "Mod+Ctrl+Left" = {
          move-column-left = true;
        };
        "Mod+Ctrl+Down" = {
          move-window-down = true;
        };
        "Mod+Ctrl+Up" = {
          move-window-up = true;
        };
        "Mod+Ctrl+Right" = {
          move-column-right = true;
        };
        "Mod+Ctrl+H" = {
          move-column-left = true;
        };
        "Mod+Ctrl+J" = {
          move-window-down = true;
        };
        "Mod+Ctrl+K" = {
          move-window-up = true;
        };
        "Mod+Ctrl+L" = {
          move-column-right = true;
        };

        "Mod+Home" = {
          focus-column-first = true;
        };
        "Mod+End" = {
          focus-column-last = true;
        };
        "Mod+Ctrl+Home" = {
          move-column-to-first = true;
        };
        "Mod+Ctrl+End" = {
          move-column-to-last = true;
        };

        "Mod+Shift+Left" = {
          focus-monitor-left = true;
        };
        "Mod+Shift+Down" = {
          focus-monitor-down = true;
        };
        "Mod+Shift+Up" = {
          focus-monitor-up = true;
        };
        "Mod+Shift+Right" = {
          focus-monitor-right = true;
        };
        "Mod+Shift+H" = {
          focus-monitor-left = true;
        };
        "Mod+Shift+J" = {
          focus-monitor-down = true;
        };
        "Mod+Shift+K" = {
          focus-monitor-up = true;
        };
        "Mod+Shift+L" = {
          focus-monitor-right = true;
        };

        "Mod+Shift+Ctrl+Left" = {
          move-column-to-monitor-left = true;
        };
        "Mod+Shift+Ctrl+Down" = {
          move-column-to-monitor-down = true;
        };
        "Mod+Shift+Ctrl+Up" = {
          move-column-to-monitor-up = true;
        };
        "Mod+Shift+Ctrl+Right" = {
          move-column-to-monitor-right = true;
        };
        "Mod+Shift+Ctrl+H" = {
          move-column-to-monitor-left = true;
        };
        "Mod+Shift+Ctrl+J" = {
          move-column-to-monitor-down = true;
        };
        "Mod+Shift+Ctrl+K" = {
          move-column-to-monitor-up = true;
        };
        "Mod+Shift+Ctrl+L" = {
          move-column-to-monitor-right = true;
        };

        "Mod+Page_Down" = {
          focus-workspace-down = true;
        };
        "Mod+Page_Up" = {
          focus-workspace-up = true;
        };
        "Mod+U" = {
          focus-workspace-down = true;
        };
        "Mod+I" = {
          focus-workspace-up = true;
        };
        "Mod+Ctrl+Page_Down" = {
          move-column-to-workspace-down = true;
        };
        "Mod+Ctrl+Page_Up" = {
          move-column-to-workspace-up = true;
        };
        "Mod+Ctrl+U" = {
          move-column-to-workspace-down = true;
        };
        "Mod+Ctrl+I" = {
          move-column-to-workspace-up = true;
        };

        "Mod+Shift+Page_Down" = {
          move-workspace-down = true;
        };
        "Mod+Shift+Page_Up" = {
          move-workspace-up = true;
        };
        "Mod+Shift+U" = {
          move-workspace-down = true;
        };
        "Mod+Shift+I" = {
          move-workspace-up = true;
        };

        "Mod+WheelScrollDown" = {
          cooldown-ms = 150;
          focus-workspace-down = true;
        };
        "Mod+WheelScrollUp" = {
          cooldown-ms = 150;
          focus-workspace-up = true;
        };
        "Mod+Ctrl+WheelScrollDown" = {
          cooldown-ms = 150;
          move-column-to-workspace-down = true;
        };
        "Mod+Ctrl+WheelScrollUp" = {
          cooldown-ms = 150;
          move-column-to-workspace-up = true;
        };

        "Mod+WheelScrollRight" = {
          focus-column-right = true;
        };
        "Mod+WheelScrollLeft" = {
          focus-column-left = true;
        };
        "Mod+Ctrl+WheelScrollRight" = {
          move-column-right = true;
        };
        "Mod+Ctrl+WheelScrollLeft" = {
          move-column-left = true;
        };

        "Mod+Shift+WheelScrollDown" = {
          focus-column-right = true;
        };
        "Mod+Shift+WheelScrollUp" = {
          focus-column-left = true;
        };
        "Mod+Ctrl+Shift+WheelScrollDown" = {
          move-column-right = true;
        };
        "Mod+Ctrl+Shift+WheelScrollUp" = {
          move-column-left = true;
        };

        "Mod+1" = {
          focus-workspace = 1;
        };
        "Mod+2" = {
          focus-workspace = 2;
        };
        "Mod+3" = {
          focus-workspace = 3;
        };
        "Mod+4" = {
          focus-workspace = 4;
        };
        "Mod+5" = {
          focus-workspace = 5;
        };
        "Mod+6" = {
          focus-workspace = 6;
        };
        "Mod+7" = {
          focus-workspace = 7;
        };
        "Mod+8" = {
          focus-workspace = 8;
        };
        "Mod+9" = {
          focus-workspace = 9;
        };

        "Mod+Ctrl+1" = {
          move-column-to-workspace = 1;
        };
        "Mod+Ctrl+2" = {
          move-column-to-workspace = 2;
        };
        "Mod+Ctrl+3" = {
          move-column-to-workspace = 3;
        };
        "Mod+Ctrl+4" = {
          move-column-to-workspace = 4;
        };
        "Mod+Ctrl+5" = {
          move-column-to-workspace = 5;
        };
        "Mod+Ctrl+6" = {
          move-column-to-workspace = 6;
        };
        "Mod+Ctrl+7" = {
          move-column-to-workspace = 7;
        };
        "Mod+Ctrl+8" = {
          move-column-to-workspace = 8;
        };
        "Mod+Ctrl+9" = {
          move-column-to-workspace = 9;
        };

        "Mod+BracketLeft" = {
          consume-or-expel-window-left = true;
        };
        "Mod+BracketRight" = {
          consume-or-expel-window-right = true;
        };
        "Mod+Comma" = {
          consume-window-into-column = true;
        };
        "Mod+Period" = {
          expel-window-from-column = true;
        };

        "Mod+R" = {
          switch-preset-column-width = true;
        };
        "Mod+Shift+R" = {
          switch-preset-window-height = true;
        };
        "Mod+Ctrl+R" = {
          reset-window-height = true;
        };
        "Mod+F" = {
          maximize-column = true;
        };
        "Mod+Shift+F" = {
          fullscreen-window = true;
        };
        "Mod+Ctrl+F" = {
          expand-column-to-available-width = true;
        };
        "Mod+C" = {
          center-column = true;
        };
        "Mod+Ctrl+C" = {
          center-visible-columns = true;
        };

        "Mod+Minus" = {
          set-column-width = "-10%";
        };
        "Mod+Equal" = {
          set-column-width = "+10%";
        };
        "Mod+Shift+Minus" = {
          set-window-height = "-10%";
        };
        "Mod+Shift+Equal" = {
          set-window-height = "+10%";
        };

        "Mod+V" = {
          toggle-window-floating = true;
        };
        "Mod+Shift+V" = {
          switch-focus-between-floating-and-tiling = true;
        };
        "Mod+W" = {
          toggle-column-tabbed-display = true;
        };

        "Print" = {
          screenshot = true;
        };
        "Ctrl+Print" = {
          screenshot-screen = true;
        };
        "Alt+Print" = {
          screenshot-window = true;
        };

        "Mod+Escape" = {
          allow-inhibiting = false;
          toggle-keyboard-shortcuts-inhibit = true;
        };

        "Mod+Shift+E" = {
          quit = true;
        };
        "Ctrl+Alt+Delete" = {
          quit = true;
        };
        "Mod+Shift+P" = {
          power-off-monitors = true;
        };
      };
    };
  };
}
