{ pkgs, config, lib, ... }:
{
  xdg.configFile."spectrwm/spectrwm.conf".text = ''
      workspace_limit  = 9
    focus_mode       = default
    focus_close      = previous
    focus_close_wrap = 1
    focus_default    = last
    spawn_position   = next
    workspace_clamp  = 0
    warp_focus       = 0
    warp_pointer     = 1

    # Window Decorations

    #color_focus             = rgb:e4/6a/6a # Material-Black-Cherry
    # color_focus             = rgb:86/6c/b4 # Material-Black-Plum
    color_focus             = rgb:a9/dc/76 # Material-Black-Lime
    color_unfocus           = rgb:0f/10/1a

    border_width            = 1
    disable_border          = 1
    region_padding          = 8
    tile_gap                = 12

    # ---------------------------------- Bar -----------------------------------

    bar_enabled             = 1
    bar_border_width        = 0
    bar_action_expand       = 1

    bar_color[1]            = rgb:0f/10/1a # Material Ocean
    # bar_color[1]            = rgb:2d/2a/2e # Monokai Pro

    # bar_font_color[1]       = rgb:a6/ac/cd, rgb:f0/f0/f0, rgb:4c/56/6a # White
    bar_font_color[1]       = rgb:a6/ac/cd, rgb:e4/6a/6a, rgb:4c/56/6a # Material-Black-Cherry
    # bar_font_color[1]       = rgb:a6/ac/cd, rgb:86/6c/b4, rgb:4c/56/6a # Material-Black-Plum
    # bar_font_color[1]       = rgb:fc/fc/fa, rgb:a9/dc/76, rgb:72/70/72 # Material-Black-Lime

    bar_font_color_selected = black
    bar_font                = UbuntuMono Nerd Font:size=16, UbuntuMono Nerd Font:size=10, UbuntuMono Nerd Font:size=13
    bar_action              = ~/.config/spectrwm/baraction.sh
    bar_justify             = center
    bar_format              = +|L+@fn=2; +@fn=0;+@fg=1; +D+@fn=1;+@fg=2;+3<+W+|R+@fn=2;+A +20<
    # Arch icon: nf-linux-archlinux (https://www.nerdfonts.com/cheat-sheet)
    workspace_indicator     = listcurrent,listactive,markcurrent,printnames
    bar_at_bottom           = 0
    stack_enabled           = 1
    clock_enabled           = 0
    # clock_format          = %a %b %d %R %Z %Y
    iconic_enabled          = 0
    maximize_hide_bar       = 0
    window_class_enabled    = 0
    window_instance_enabled = 0
    window_name_enabled     = 0
    verbose_layout          = 1
    urgent_enabled          = 1

    # ------------------------------- Workspaces -------------------------------

    # Get the icons at https://www.nerdfonts.com/cheat-sheet (you need a Nerd Font)
    name = ws[1]:1  # nf-fa-firefox
    name = ws[2]:2  # nf-dev-react
    name = ws[3]:3  # nf-dev-terminal
    name = ws[4]:4  # nf-fa-code
    name = ws[5]:5  # nf-fa-code_fork
    name = ws[6]:6  # nf-linux-docker
    name = ws[7]:7  # nf-mdi-folder
    name = ws[8]:8  # nf-fa-image
    name = ws[9]:9  # nf-fa-cubes

    # ---------------------------------- Keys ----------------------------------

    modkey = Mod4

    # ---------------- Windows -----------------

    # Switch between windows in current stack pane
    bind[focus_next]    = MOD+j
    bind[focus_prev]    = MOD+k
    # Change window sizes
    bind[master_grow]   = MOD+Shift+l
    bind[master_shrink] = MOD+Shift+h
    # Toggle floating
    bind[float_toggle]  = MOD+Shift+f
    # Move windows up or down in current stack
    bind[swap_next]     = MOD+Shift+j
    bind[swap_prev]     = MOD+Shift+k
    # Toggle between layouts
    bind[cycle_layout]  = MOD+Tab
    # Kill window
    bind[wind_del]      = MOD+Shift+q
    # Focus next/prev monitor
    bind[rg_next]		= MOD+period
    bind[rg_prev]		= MOD+comma
    # Restart
    bind[restart]       = MOD+Shift+r
    # Quit
    bind[quit]          = MOD+F10

    # --------------- Workspaces ---------------

    # Go to workspace N
    bind[ws_1]          = MOD+1
    bind[ws_2]          = MOD+2
    bind[ws_3]          = MOD+3
    bind[ws_4]          = MOD+4
    bind[ws_5]          = MOD+5
    bind[ws_6]          = MOD+6
    bind[ws_7]          = MOD+7
    bind[ws_8]          = MOD+8
    bind[ws_9]          = MOD+9

    # Move window to workspace N
    bind[mvws_1]        = MOD+Shift+1
    bind[mvws_2]        = MOD+Shift+2
    bind[mvws_3]        = MOD+Shift+3
    bind[mvws_4]        = MOD+Shift+4
    bind[mvws_5]        = MOD+Shift+5
    bind[mvws_6]        = MOD+Shift+6
    bind[mvws_7]        = MOD+Shift+7
    bind[mvws_8]        = MOD+Shift+8
    bind[mvws_9]        = MOD+Shift+9

    # Send workspace to next / prev screen
    # bind[rg_move_next]  = MOD+Control+j
    # bind[rg_move_prev]  = MOD+Control+k

    # ------------------ Apps ------------------

    #Speaker
    program[speaker]   = ~/trans.sh
    bind[speaker]      = Control+Mod1+s
    program[stop_speak]= pkill crow
    bind[stop_speak]   = Control+Mod1+a

    # Menu
    program[rofi]      = rofi -show drun
    bind[rofi]         = MOD+d

    # Power Managers
    program[suspend]   = systemctl suspend
    bind[suspend]      = MOD+F11
    program[poweroff]  = systemctl poweroff
    bind[poweroff]     = MOD+F12

    # Nav
    program[nav]       = rofi -show
    bind[nav]          = MOD+Shift+d

    # Terminal
    program[term]      = kitty
    bind[term]         = MOD+Return

    # Telegram
    program[telegram]  = telegram-desktop
    bind[telegram]     = MOD+t

    # Browser
    program[browser]   = chromium
    bind[browser]      = MOD+F1

    # File explorer
    program[pcmanfm]   = pcmanfm
    bind[pcmanfm]      = MOD+F2

    # # Redshift
    # program[redon]     = redshift -O 2400
    # bind[redon]        = MOD+r
    # program[redoff]    = redshift -x
    # bind[redoff]       = MOD+Shift+r

    # Screenshot
    # program[scrot]     = scrot
    # bind[scrot]        = MOD+s
    # program[scrot-s]   = scrot -s
    # bind[scrot-s]      = MOD+Shift+s

    # ---------------- Hardware ----------------

    # Volume
    program[voldown]   = pamixer -d 5
    bind[voldown]      = XF86AudioLowerVolume
    program[volup]     = pamixer -i 5
    bind[volup]        = XF86AudioRaiseVolume
    program[mute]      = pamixer -t
    bind[mute]         = XF86AudioMute

    # Brightness
    # program[brup]      = brightnessctl set +10%
    # bind[brup]         = XF86MonBrightnessUp
    # program[brdown]    = brightnessctl set 10%-
    # bind[brdown]       = XF86MonBrightnessDown

    # -------------------------------- Autorun ---------------------------------

    autorun = ws[1]:~/.config/spectrwm/autostart.sh

    quirk[trayer] = FLOAT + ANYWHERE + MINIMALBORDER + NOFOCUSCYCLE + NOFOCUSONMAP

  '';
  xsession.windowManager.spectrwm = {
    enable = true;
    # settings = {
    #   modkey = "Mod4";
    #   workspace_limit = 10;
    #   region_padding = 8;
    #   tile_gap = 12;
    #   color_focus = "rgb:cb/ed/e9";
    #   bar_enabled = 1;

    #   bar_font = "Iosevka:style=Regular:pixelsize=14:antialias=true";
    #   autorun = "ws[1]:~/.config/spectrwm/autorun.sh";
    # };

    # quirks = lib.mkOptionDefault { };
    # programs = {
    #   term = "kitty";
    #   browser = "chromium";
    #   rofi = "rofi -show drun";
    #   telegram = "telegram-desktop";
    #   speak = "~/trans.sh";
    #   speak_stop = "pkill crow";
    # };

    # bindings = lib.mkOptionDefault {
    #   term = "Mod+Return";
    #   restart = "Mod+Shift+r";
    #   quit = "Mod+F10";
    #   wind_del = "Mod+Shift+q";
    #   wind_kill = "Mod+Shift+x";
    #   browser = "Mod+F1";
    #   rofi = "Mod+d";
    #   telegram = "Mod+t";
    #   float_toggle = "Mod+Shift+t";
    #   speak = "Control+Mod1+f";
    #   speak_stop = "Control+Mod1+a";

    # };
  };
}
