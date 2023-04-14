{config, lib, pkgs, ...}:

{
  xsession.windowManager.herbstluftwm = {
    enable = true;
    settings = {
      set_monitors = "2560x1440+0+0 1920x1080+2560+0";
    };
    keybinds = lib.mkOptionDefault {
      Mod4-Shift-q = "close_and_remove";
      Mod4-Shift-e = "quit";
      Mod4-Return = "spawn kitty";
      Mod4-d = "spawn rofi -show drun";
      Mod4-Shift-r = "reload";
  };
  };
}
