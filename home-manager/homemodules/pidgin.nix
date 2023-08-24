{ pkgs, ... }:
{
  programs.pidgin = {
    enable = true;
    plugins = [ pkgs.tdlib-purple ];
  };
}
