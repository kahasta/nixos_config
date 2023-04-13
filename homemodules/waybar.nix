{ config, pkgs, lib, ... }:
{
  programs.waybar.settings = {
    enable = true;
    mainBar = {
      layer = "top";
      position = "top";
      height = 30;
      output = [
        "DP-3"
        "HDMI-A-1"
      ];
      modules-left = [ "sway/workspaces" "sway/mode" "wlr/taskbar" ];
      modules-center = [ "sway/window" "custom/hello-from-waybar" ];
      modules-right = [ "mpd" "custom/mymodule#with-css-id" "temperature" ];

      "sway/workspaces" = {
        disable-scroll = true;
        all-outputs = true;
      };
      "custom/hello-from-waybar" = {
        format = "hello {}";
        max-length = 40;
        interval = "once";
        exec = pkgs.writeShellScript "hello-from-waybar" ''
          echo "from within waybar"
        '';
      };
    };
  };
}
