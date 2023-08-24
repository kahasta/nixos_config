{ config, options, pkgs, lib, ... }:

{

  wayland.windowManager.sway = {
    wrapperFeatures.gtk = true;
    enable = true;
    config = rec

    {
      modifier = "Mod4";
      keybindings =
        let
          mod = config.wayland.windowManager.sway.config.modifier;
        in
        lib.mkOptionDefault
          {
            "${mod}+Return" = "exec kitty";
            #"${modifier}+Shift+q" = "kill";
            "${mod}+d" = "exec --no-startup-id tofi-drun | xargs swaymsg exec --";
            "${mod}+Shift+d" = "exec --no-startup-id tofi-run | xargs swaymsg exec --";
            "${mod}+t" = "exec QT_QPA_PLATFORM=xcb kotatogram-desktop";
            "${mod}+F1" = "exec --no-startup-id chromium";
            "${mod}+F2" = "exec --no-startup-id pcmanfm-qt";
            "Control+Mod1+s" = "exec --no-startup-id ~/trans.sh";
            "Control+Mod1+a" = "exec --no-startup-id pkill crow";

            # Change Focus
            "${mod}+h" = "focus left";
            "${mod}+j" = "focus down";
            "${mod}+k" = "focus up";
            "${mod}+l" = "focus right";
            # Move focused window
            "${mod}+Shift+h" = "move left";
            "${mod}+Shift+j" = "move down";
            "${mod}+Shift+k" = "move up";
            "${mod}+Shift+l" = "move right";

            # move focused container to workspace
            "${mod}+Shift+1" = "move container to workspace 1; workspace1";
            "${mod}+Shift+2" = "move container to workspace 2; workspace2";
            "${mod}+Shift+3" = "move container to workspace 3; workspace3";
            "${mod}+Shift+4" = "move container to workspace 4; workspace4";
            "${mod}+Shift+5" = "move container to workspace 5; workspace5";
            "${mod}+Shift+6" = "move container to workspace 6; workspace6";
            "${mod}+Shift+7" = "move container to workspace 7; workspace7";
            "${mod}+Shift+8" = "move container to workspace 8; workspace8";
            "${mod}+Shift+9" = "move container to workspace 9; workspace9";
            "${mod}+Shift+0" = "move container to workspace 0; workspace0";

            "${mod}+Shift+F12" = "exec systemctl poweroff";
            "${mod}+Shift+F11" = "exec systemctl suspend";
            "${mod}+Shift+F10" = "exec sway exit";

            # next/previous workspace
            "Mod1+Tab" = "workspace next";
            "Mod1+Shift+Tab" = "workspace prev";
            "${mod}+Tab" = "workspace back_and_forth";

            "XF86AudioRaiseVolume" = "exec --no-startup-id pamixer -ui 5 && pamixer --get-volume > $WOBSOCK";
            "XF86AudioLowerVolume" = "exec --no-startup-id pamixer -ud 5 && pamixer --get-volume > $WOBSOCK";
            "XF86AudioMute" = "exec --no-startup-id pamixer -t";

          };

      input = {
        "*" = {
          xkb_layout = "us,ru";
          xkb_options = "grp:caps_toggle";
        };
      };

      startup = [
        { command = "~/wallpaper.sh"; always = true; }
      ];

      gaps = {
        inner = 8;
        outer = 6;
      };

      bars = [{
        # position = "top";
        fonts = {
          # names = [ "Iosevka" "Font Awesome 6 Free" ];
          names = [ "JetBrains Mono" "Font Awesome 6 Free" ];
          size = 10.0;
        };
        # # statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-top.toml";
        # statusCommand = "${pkgs.waybar}";
        command = "waybar";
      }];
    };

    extraConfig = ''
             set $WOBSOCK $XDG_RUNTIME_DIR/wob.sock
             exec rm -f $WOBSOCK && mkfifo $WOBSOCK && tail -f $WOBSOCK | wob
      exec dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK
                         floating_modifier Mod4
                         for_window [class="^.*"] border pixel 2
                         workspace "1" output DP-3 
                         workspace "2" output HDMI-A-1 
                   exec --no-startup-id systemctl --user import-environment DISPLAY WAYLAND_DISPLAY SWAYSOCK XDG_SESSION_TYPE XDG_SESSION_DESKTOP XDG_CURRENT_DESKTOP
                           exec --no-startup-id mako &
                           # exec --no-startup-id swayidle -w timeout 600 'swaymsg "output * dpms off"' resume 'swaymsg "output * dpms on"'
    '';
    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      export _JAVA_AWT_WM_NONREPARENTING=1
      export MOZ_ENABLE_WAYLAND=1
    '';
  };



}
