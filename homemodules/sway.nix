{ config, options, pkgs, lib, ... }:

{

  wayland.windowManager.sway = {
    enable = true;
    config =

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
              "${mod}+d" = "exec --no-startup-id rofi -show drun -font \"Noto Sans 13\"";
              "${mod}+t" = "exec telegram-desktop";
              "${mod}+F1" = "exec --no-startup-id chromium";
              "${mod}+F2" = "exec --no-startup-id pcmanfm";
              "Control+Mod1+f" = "exec --no-startup-id ~/trans.sh";
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

              "${mod}+F12" = "exec systemctl poweroff";
              "${mod}+F11" = "exec systemctl suspend";

              # next/previous workspace
              "Mod1+Tab" = "workspace next";
              "Mod1+Shift+Tab" = "workspace prev";
              "${mod}+Tab" = "workspace back_and_forth";

              "XF86AudioRaiseVolume" = "exec --no-startup-id pamixer -i 5";
              "XF86AudioLowerVolume" = "exec --no-startup-id pamixer -d 5";
              "XF86AudioMute" = "exec --no-startup-id pamixer -t";

            };

        startup = [
          { command = "exec --no-startup-id xrandr --output HDMI-A-1 --right-of DP-3 --auto"; always = false; }
          # { command = "feh --randomize --bg-fill /mnt/archiew/Torrent/Abstract\\ wallpapers\\ 4k\\ UHD\\ \\&\\ 8k\\ UHD/3840x2160/"; always = true;  }
        ];

        gaps = {
          inner = 12;
          outer = 6;
        };
        bars = [{
          # position = "top";
          # fonts = {
          #   # names = [ "Iosevka" "Font Awesome 6 Free" ];
          #   names = [ "JetBrains Mono" "Font Awesome 6 Free" ];
          #   size = 12.0;
          # };
          # # statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-top.toml";
          # statusCommand =
          #   "${pkgs.waybar}";
          command = "waybar";
        }];
      };
    extraConfig = ''
      floating_modifier Mod4
      for_window [class="^.*"] border pixel 2
      workspace "1" output DP-3 
      workspace "2" output HDMI-A-1 
    '';
  };

}
