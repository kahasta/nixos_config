{
  programs.kitty = {
    enable = true;
    settings = {
      include = "./theme.conf";
      confirm_os_window_close = "0";
      font_family = "JetBrains Mono";
      italic_font = "auto";
      bold_font = "auto";
      bold_italic_font = "auto";
      # Font size (in pts)
      font_size = 13;
      background_opacity = "1.0";
    };
  };
}
