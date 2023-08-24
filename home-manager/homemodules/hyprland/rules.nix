{ ... }: {
  xdg.configFile."hypr/rules.conf".text = ''
         windowrule = float,         xfce-polkit
     windowrule = size 1262 202, polkit-gnome-authentication-agent-1
     windowrule = float,         title:^(.*float.*)$
     windowrule = float,         connman-gtk
     windowrule = workspace 2,   firedragon
    #windowrule = noborder,     firedragon
     windowrule = rounding 0,    firedragon
     windowrule = tile,          Spotify
     windowrule = noborder,      title:^(KotatogramDesktop)$
     windowrule = noblur,        title:^(KotatogramDesktop)$
     windowrule = noshadow,      title:^(KotatogramDesktop)$

    # Chat apps
      windowrule = workspace 3,       kotatogramdesktop
      # windowrule = workspace special, TelegramDesktop
      # windowrule = float,          title:^(Telegram)$
      # windowrule = size 600 1000,  title:^(Telegram)$
      # windowrule = move 1190 54,   title:^(Telegram)$ 
      # windowrule = pseudo,         title:^(Telegram)$
  
      # windowrule = float,          title:^(Kotatogram)$
      # windowrule = size 600 1000,  title:^(Kotatogram)$
      # windowrule = move 1190 54,   title:^(Kotatogram)$ 
      # windowrule = pseudo,         title:^(Kotatogram)$

      windowrule = float,              ncmpcpp
      windowrule = size 786 361,       ncmpcpp

        layerrule  = ignorezero,        waybar
        layerrule  = blur,              waybar
      # layerrule  = blur,              wallpaper
      # layerrule  = blur,              rofi
      # layerrule  = ignorezero,        rofi
      # layerrule  = blur,              gtk-layer-shell
      # layerrule  = ignorezero,        gtk-layer-shell
       layerrule  = blur,              notifications
       layerrule = ignorezero,         notifications

      # windowrule = workspace 3,   TelegramDesktop
      windowrule = workspace 3,   discord

      windowrule = workspace 4,   Steam
      windowrule = float,         nemo
      windowrule = move center,   nemo
      windowrule = float,         lutris
      windowrule = workspace 4,   lutris
      windowrule = float,         zenity
      windowrule = float,         imv
      windowrule = float,         io.github.seadve.Mousai
      windowrule = float,         nwg-look
    # windowrule = float,         Steam
    #  windowrule = float,         title:^(Firefox — Sharing Indicator)$
      windowrule = float,         title:^(Picture-in-Picture)$
      windowrule = float,         xdg-desktop-portal-gtk

      #  decorations
    #   windowrule = opacity 0.84,  firedragon
    #  windowrule = opacity 0.85,  title:^(Picture-inPicture)$ 
    #   windowrule = opacity 0.85,  kotatogramdesktop
    #   windowrule = rounding  25,  kotatogramdesktop
    #  windowrule = opacity 0.95,  discord
  '';
}
