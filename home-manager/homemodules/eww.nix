{ lib, pkgs, config, ...}:
{
  programs.eww = {
    enable = true;
   configDir = ~/.config/eww-config;
  };

}
