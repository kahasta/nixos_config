{ lib, pkgs, config, ...}:
{
  services.sxhkd = {
    enable= true;
    extraConfig = ''
super + d
  rofi -show drun

super + F1
  chromium

super + F2
  pcmanfm
# WM INDEPENDENT KEYBINDINGS

# make sxhkd reload its configuration files:
super + Escape
	pkill -USR1 -x sxhkd


# BSPWM HOTKEYS

# kill/restart bspwm
super + shift + {q,r}
	bspc {node -c,wm -r}

# close and kill
# super + shift + c
# 	bspc node -c

# alternate between the tiled and monocle layout
super + m
	bspc desktop -l next


# swap the current node and the biggest node
super + g
	bspc node -s biggest

# Switch workspaces
super + {1,2,3,4,5,6,7,8,9,0}
	bspc desktop -f {1,2,3,4,5,6,7,8,9,0}

super + shift + {1-9,0}
	bspc node -d '^{1-9,10}'


# STATE/FLAGS

# set the window state
super + {t,shift + t,s,f}
	bspc node -t {tiled,pseudo_tiled,floating,fullscreen}

# set the node flags
super + ctrl + {m,x,y,z}
	bspc node -g {marked,locked,sticky,private}


# FOCUS/SWAP

# focus the node in the given direction
super + {_,shift + }{h,j,k,l}
	bspc node -{f,s} {west,south,north,east}

# focus the node for the given path jump
super + {p,b,comma,period}
	bspc node -f @{parent,brother,first,second}

# focus the next/previous node in the current desktop
super + {_,shift + }n
	bspc node -f {next,prev}.local

# focus the next/previous desktop in the current monitor
super + bracket{left,right}
	bspc desktop -f {prev,next}.local

# focus the last node/desktop
super + {grave,Tab}
	bspc {node,desktop} -f last

# focus the older or newer node in the focus history
super + {o,i}
	bspc wm -h off; \
	bspc node {older,newer} -f; \
	bspc wm -h on

# focus or send to the given desktop
# super + {_,shift + }{1-9,0}
# 	bspc {desktop -f,node -d} focused:'^{1-9,10}'


# PRESELECT

# preselect the direction
super + ctrl + {h,j,k,l}
	bspc node -p {west,south,north,east}

# preselect the ratio
super + ctrl + {1-9}
	bspc node -o 0.{1-9}

# cancel the preselection for the focused node
super + ctrl + space
	bspc node -p cancel

# cancel the preselection for the focused desktop
super + ctrl + shift + space
	bspc query -N -d | xargs -I id -n 1 bspc node id -p cancel


# MOVE/RESIZE

# expand a window by moving one of its side outward
super + shift + {h,j,k,l}
	bspc node -z {left -20 0,bottom 0 20,top 0 -20,right 20 0}

# contract a window by moving one of its side inward
# super + alt + shift + {h,j,k,l}
# 	bspc node -z {right -20 0,top 0 20,bottom 0 -20,left 20 0}

# move a floating window
super + {Left,Down,Up,Right}
	bspc node -v {-20 0,0 20,0 -20,20 0}


# APPLICATION KEYBINDINGS (Super + Alt + Key)

# terminal emulator
super + Return
	kitty

'';
  };
  xsession.windowManager.bspwm = {
    enable = true;
    # configFile = builtins.getEnv "HOME" + "/.config/bspwm/bspwmrc";
    # sxhkd.configFile = builtins.getEnv "HOME" + ".config/sxhkd/sxhkdrc";
    extraConfig = ''
#### VARIABLES ####
COLORSCHEME="DoomOne"

#### AUTOSTART ####
# sxhkd &
# picom &
killall nm-applet && nm-applet &
killall volumeicon && volumeicon &

feh --randomize --bg-fill /mnt/archiew/Torrent/Abstract/3840x2160 &
# nitrogen --restore &

#### MONITORS ####
for monitor in $(bspc query -M)
do
    # set the workspaces on each monitor to 1-9
    bspc monitor $monitor -d 1 2 3 4 5 6 7 8 9
    #polybar hidden when fullscreen for vlc, youtube, mpv ...
    # xdo below -t $(xdo id -n root) $(xdo id -a polybar-main_$monitor)
done

#polybar hidden when fullscreen for vlc, youtube, mpv ...
#find out the name of your monitor with xrandr
# xdo below -t $(xdo id -n root) $(xdo id -a polybar-main_DisplayPort-0)
# xdo below -t $(xdo id -n root) $(xdo id -a polybar-main_DisplayPort-1)
# xdo below -t $(xdo id -n root) $(xdo id -a polybar-main_HDMI-A-0)

#### BSPWM configuration ####
#bspc config border_radius                8
bspc config border_width                  2
bspc config window_gap                    10
bspc config top_padding                   20
bspc config bottom_padding                0
bspc config left_padding                  0
bspc config right_padding                 0
bspc config single_monocle                false
bspc config click_to_focus                true
bspc config split_ratio                   0.50
bspc config borderless_monocle            true
bspc config gapless_monocle               true
bspc config focus_by_distance             true
bspc config focus_follows_pointer         true
bspc config history_aware_focus           true
bspc config remove_disabled_monitors      true
bspc config merge_overlapping_monitors    true
bspc config pointer_modifier mod4
bspc config pointer_action1 move
bspc config pointer_action2 resize_side
bspc config pointer_action3 resize_corner

#### BSPWM coloring ####
bspc config normal_border_color           "#4c566a"
bspc config active_border_color	      "#1e1e1e"
bspc config focused_border_color	      "#5e81ac"
bspc config presel_feedback_color	      "#5e81ac"
bspc config urgent_border_color 	      "#dd2727"


bspc rule -a Gimp desktop='^8' state=floating follow=on
bspc rule -a Chromium desktop='^2'
bspc rule -a mplayer2 state=floating
bspc rule -a Kupfer.py focus=on
bspc rule -a Screenkey manage=off

'';
  };
}
