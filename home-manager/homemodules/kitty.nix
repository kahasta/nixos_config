{
  programs.kitty = {
    enable = true;
    settings = {
  #    include = "./theme.conf";
      confirm_os_window_close = "0";
      font_family = "JetBrains Mono";
      italic_font = "auto";
      bold_font = "auto";
      bold_italic_font = "auto";
      # Font size (in pts)
      font_size = 13;
      background_opacity = "1.0";
    };
    extraConfig = ''
      background #212733
      foreground #d9d7ce
      cursor #ffcc66
      selection_background #343f4c
      color0 #191e2a
      color8 #686868
      color1 #ed8274
      color9 #f28779
      color2  #a6cc70
      color10 #bae67e
      color3  #fad07b
      color11 #ffd580
      color4  #6dcbfa
      color12 #73d0ff
      color5  #cfbafa
      color13 #d4bfff
      color6  #90e1c6
      color14 #95e6cb
      color7  #c7c7c7
      color15 #ffffff
      selection_foreground #212733

    '';
  };
}
