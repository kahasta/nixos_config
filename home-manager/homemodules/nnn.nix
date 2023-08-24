{ pkgs, ... }:
{

  programs.zsh = {
    initExtra = ''
      export NNN_PLUG='p:preview-tui;v:imgview'
      export NNN_FCOLORS='0000E63100000000000000000'
      set --export NNN_FIFO "/tmp/nnn.fifo"
    '';
    shellAliases = {
      nnn = "nnn -a";
    };
  };
  programs.nnn = {
    enable = true;
    package = pkgs.nnn.override ({ withNerdIcons = true; });
    bookmarks = {
      d = "~/Downloads";
      h = "~/";
      c = "~/.config";
      C = "~/.config/nnn";
      e = "~/emu";
    };
    plugins = { };

    extraPackages = with pkgs; [
      ffmpegthumbnailer
      mediainfo
      sxiv
    ];
  };
}
