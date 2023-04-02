{ config, pkgs, lib, ... }:
{
  programs.i3status-rust = {
    enable = true;
    bars = {
      top = {
        blocks = [
          {
            block = "focused_window";
            # interval = 1;
            format = " $title.str(0,15) |";
          }
          {
            block = "disk_space";
            path = "/";
            info_type = "available";
            format = "$icon /:$available/$total";
            interval = 60;
            warning = 20.0;
            alert = 10.0;
          }
          {
            block = "disk_space";
            path = "/home";
            info_type = "available";
            format = "$icon /home:$available/$total";
            interval = 60;
            warning = 20.0;
            alert = 10.0;
          }
          {
            block = "memory";
            format_mem = " $icon $mem_used_percents.eng(w:1) ";
          }
          {
            block = "cpu";
            interval = 1;
            # format = " $icon $barchart $utilization ";
          }
          {
            block = "load";
            interval = 1;
            format = " $icon $1m ";
          }
          # {
          #   block = "amd_gpu";
          #   format = " $icon $utilization ";
          #   format_alt = " $icon MEM: $vram_used_percents ($vram_used/$vram_total) ";
          #   interval = 1;
          # }
          {
            block = "sound";
          }
          {
            block = "time";
            interval = 60;
            format = " %a %d/%m %R ";
          }
        ];
        settings = {
          theme = "solarized-dark";
          overrides = {
            idle_bg = "#123456";
            idle_fg = "#abcdef";
          };
        };
        icons = "awesome5";
        theme = "solarized-dark";
      };
    };
  };
}
