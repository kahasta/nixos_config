{ config, pkgs, ... }: {
  imports = [
    # ./variables.nix
    ./themes.nix
    ./binds.nix
    ./rules.nix
    ./execs.nix
  ];
  home.packages = with pkgs; [
    foot
    wbg
    wl-clipboard
    pcmanfm-qt
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    # xwayland.hidpi = true;
    
    extraConfig = ''

            $mod = SUPER
            $term = foot

            source =    $HOME/.config/hypr/themes/mocha.conf
            source =    $HOME/.config/hypr/rules.conf
            source =    $HOME/.config/hypr/binds.conf
            source =    $HOME/.config/hypr/execs.conf



      general {
               gaps_in                 = 6
               gaps_out                = 12
               border_size             = 3.5
               col.active_border       = $mauve $pink $lavender 45deg
               col.inactive_border     = $surface1
               col.group_border_active = $mauve
               col.group_border        = $surface0

               # no_focus_fallback = true
               cursor_inactive_timeout = 5
               layout = dwindle
            }

            decoration {
               rounding            = 6
               blur                = false
               blur_size           = 3
               blur_passes         = 2
               blur_ignore_opacity = true
               drop_shadow         = false
               shadow_range        = 55
               shadow_render_power = 4
               col.shadow          = $mantle
               shadow_offset       = -12, 12
            }



animations {
         enabled   = yes
         bezier    = myBezier, 0.05, 0.9, 0.1, 1.05

         animation = windows,     1, 2,  default
         animation = windowsOut,  1, 2,  default
         animation = border,      1, 2,  default
         animation = borderangle, 1, 2,  default
         animation = fade,        1, 2,  default
         animation = workspaces,  1, 2,  default
      }

      dwindle {
         pseudotile        = yes
         preserve_split    = yes
         no_gaps_when_only = true
      }

      master {
         new_is_master     = true
      }

      gestures {
         workspace_swipe   = true
      }

      misc {
         render_titles_in_groupbar = true
         groupbar_gradients        = false
         disable_hyprland_logo     = true
         disable_splash_rendering  = true
         vrr                       = 1
         disable_autoreload        = true
         enable_swallow            = true
         swallow_regex             = kitty|Alacritty|foot
         cursor_zoom_factor = 0.6
         # swallow_exception_regex  = ^()
      }

      binds {
         allow_workspace_cycles = true
      }

    '';
  };

}
