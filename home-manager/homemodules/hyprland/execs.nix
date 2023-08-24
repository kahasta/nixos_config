{
  xdg.configFile."hypr/execs.conf".text = ''
    # exec-once = waybar
    # Clipboard history
    exec = ~/wallpaper_wayland.sh
    exec-once = wl-paste --watch cliphist store
    exec-once = nm-applet --indicator

  '';
}
