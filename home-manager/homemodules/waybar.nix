{ config, pkgs, lib, ... }:
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      # enable = true;
      mainBar = {
        layer = "top";
        position = "top";
        spacing = 4;
        height = 30;
        font-family = "Iosevka Font";
        output = [
          "DP-3"
          "HDMI-A-1"
        ];
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [ "temperature#gpu" "temperature" "cpu" "memory" "disk" "disk#home" "pulseaudio" "network" "clock" "tray" "hyprland/language" ];

        "hyprland/window" = {
          max-length = 40;
        };

        "hyprland/language" = {
          format = "{}";
          format-en = "EN";
          format-ru = "RU";
        };

        "hyprland/workspaces" = {
          format = "{id}:{icon}";
          # all-outputs = true;
          on-click = "activate";
          format-icons = {
            active = " 󰮯";
            default = "󰌽";
          };
          sort-by-number = true;
          persistent_workspaces = {
            "1" = [
              "DP-3"
              "HDMI-A-1"
            ];
            "2" = [
              "DP-3"
              "HDMI-A-1"
            ];
            "3" = [
              "DP-3"
              "HDMI-A-1"
            ];
            "4" = [
              "DP-3"
              "HDMI-A-1"
            ];
            "5" = [
              "DP-3"
              "HDMI-A-1"
            ];
            "6" = [
              "DP-3"
              "HDMI-A-1"
            ];
          };
        };


        "temperature" = {
          hmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
          format = "CPU:{temperatureC}°C ";
        };

        "temperature#gpu" = {
          hmon-path = "/sys/class/hwmon/hwmon4/temp1_input";
          format = "GPU:{temperatureC}°C ";
        };

        "cpu" = {
          interval = 1;
          format = "CPU {usage}%";
          max-length = 20;
        };

        "memory" = {
          interval = 30;
          format = "RAM:{used:0.1f}G/{total:0.1f}G";
          max-length = 16;
        };

        "disk" = {
          interval = 30;
          format = "/:{free}";
          path = "/";
        };

        "disk#home" = {
          interval = 30;
          format = "/home:{free}";
          path = "/home";
        };

        "pulseaudio" = {
          format = " {volume}%";
          format-muted = "m";
          on-click = "pavucontrol";
        };

        "network" = {
          format-wifi = " {signalStrength}%";
        };

        "clock" = {
          format-alt = "  {:%a %b %d}";
          format = "  {:%H:%M}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            on-click-right = "mode";
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              weeks = "<span color='#99ffdd'><b>W{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
        };

        "tray" = {
          icon-size = 21;
          spacing = 10;
        };

        "sway/language" = {
          format = "{}";
          format-en = "US";
          format-ru = "RU";
        };

        "custom/power-menu" = {
          format = "<span color='#6a92d7'>⏻</span>";
          on-click = "bash ~/.config/waybar/scripts/power-menu/powermenu.sh";
        };

        "sway/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
        };

        "sway/window" = {
          "format" = "{}";
          "max-length" = 15;
        };
        # "custom/hello-from-waybar" = {
        #   format = "hello {}";
        #   max-length = 40;
        #   interval = "once";
        #   exec = pkgs.writeShellScript "hello-from-waybar" ''
        #     echo "from within waybar"
        #   '';
        # };
      };
    };

    style = ''
      * {
          border: none;
          font-size: 13px;
          font-family: JetBrains Mono;
          border-radius: 3px;
          min-height: 0;
      }

     window.HDMI-A-1 * {
          border: none;
          font-size: 11px;
          font-family: JetBrains Mono;
          border-radius: 3px;
          min-height: 0;
      }

      window#waybar {
        background-color: rgba(26, 27, 38, 0.0);
        color: #ffffff;
        transition-property: background-color;
        transition-duration: 0.5s;
        border-top: 8px transparent;
        border-radius: 3px;
        border-color: #ccc;
        transition-duration: 0.5s;
        font-family: "JetBrains mono", "Font Awesome 5 Pro";
        font-size: 13px;
        font-weight: bold;
      }

      window#waybar.hidden {
        opacity: 0.2;
      }

      #workspaces button {
        padding: 0 0.5em;
        color: #7984A4;
        background-color: transparent;
        box-shadow: inset 0 -3px transparent;
        font-size: 1em;
        font-weight: bold;
        border: none;
        border-radius: 0;
      }

      #workspaces button:hover {
        background: rgba(0, 0, 0, 0.2);
        box-shadow: inset 0 -3px #ffffff;
      }

      #workspaces button.focused {
        color: #bf616a;
      }

      #workspaces button.active {
        color: #6a92d7;
      }

      #workspaces button.urgent {
        background-color: #eb4d4b;
      }

      #mode {
        background-color: #64727d;
        border-bottom: 3px solid #ffffff;
      }

      #window {
          margin-right: 40px;
          margin-left: 40px;
          font-weight: normal;
        color: #64727d;
      }

      #clock,
      #battery,
      #cpu,
      #memory,
      #disk,
      #temperature,
      #backlight,
      #network,
      #pulseaudio,
      #custom-media,
      #tray,
      #mode,
      #idle_inhibitor,
      #mpd,
      #bluetooth,
      #custom-hyprPicker,
      #custom-power-menu,
      #custom-spotify,
      #custom-weather,
      #custom-weather.severe,
      #custom-weather.sunnyDay,
      #custom-weather.clearNight,
      #custom-weather.cloudyFoggyDay,
      #custom-weather.cloudyFoggyNight,
      #custom-weather.rainyDay,
      #custom-weather.rainyNight,
      #custom-weather.showyIcyDay,
      #custom-weather.snowyIcyNight,
      #custom-weather.default {
        padding: 0 10px;
        color: #e5e5e5;
        border-radius: 9.5px;
        background-color: #1f2530;
      }

      #window,
      #workspaces {
        margin: 0 4px;
        border-radius: 7.8px;
        background-color: #1f2530;
      }

      #cpu {
        color: #fb958b;
        background-color: #1f2530;
      }

      #memory {
        color: #ebcb8b;
        background-color: #1f2530;
      }

      #custom-power-menu {
        border-radius: 9.5px;
        background-color: #1b242b;
        border-radius: 7.5px;
        padding: 0 5px;
      }

      #custom-launcher {
        background-color: #1b242b;
        color: #6a92d7;
        border-radius: 7.5px;
        padding: 0 5px;
      }

      #custom-weather.severe {
        color: #eb937d;
      }

      #custom-weather.sunnyDay {
        color: #c2ca76;
      }

      #custom-weather.clearNight {
        color: #cad3f5;
      }

      #custom-weather.cloudyFoggyDay,
      #custom-weather.cloudyFoggyNight {
        color: #c2ddda;
      }

      #custom-weather.rainyDay,
      #custom-weather.rainyNight {
        color: #5aaca5;
      }

      #custom-weather.showyIcyDay,
      #custom-weather.snowyIcyNight {
        color: #d6e7e5;
      }

      #custom-weather.default {
        color: #dbd9d8;
      }

      .modules-left > widget:first-child > #workspaces {
        margin-left: 0;
      }

      .modules-right > widget:last-child > #workspaces {
        margin-right: 0;
      }

      #pulseaudio {
        color: #7d9bba;
      }

      #backlight {
        color: #8fbcbb;
      }

      #clock {
        color: #c8d2e0;
      }

      #battery {
        color: #c0caf5;
      }

      #battery.charging,
      #battery.full,
      #battery.plugged {
        color: #26a65b;
      }

      @keyframes blink {
        to {
          background-color: rgba(30, 34, 42, 0.5);
          color: #abb2bf;
        }
      }

      #battery.critical:not(.charging) {
        color: #f53c3c;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      label:focus {
        background-color: #000000;
      }

      #language {
        color: #fbf5fb;
        background-color: #1f2530;
      }

      #disk {
        background-color: #065535;
      }

      #bluetooth {
        color: #707d9d;
      }

      #bluetooth.disconnected {
        color: #f53c3c;
      }

      #network {
        color: #b48ead;
      }

      #network.disconnected {
        color: #f53c3c;
      }

      #custom-media {
        background-color: #66cc99;
        color: #2a5c45;
        min-width: 100px;
      }

      #custom-media.custom-spotify {
        background-color: #66cc99;
      }

      #custom-media.custom-vlc {
        background-color: #ffa000;
      }

      #temperature {
        background-color: #4b6678;
      }

      #temperature.gpu {
        background-color: #0a932b;
      }

      #temperature.critical {
        background-color: #eb4d4b;
      }

      #tray > .passive {
        -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
        background-color: #eb4d4b;
      }

      #idle_inhibitor {
        background-color: #2d3436;
      }

      #idle_inhibitor.activated {
        background-color: #ecf0f1;
        color: #2d3436;
      }

      #mpd {
        color: #2a5c45;
      }

      #mpd.disconnected {
        color: #f53c3c;
      }

      #mpd.stopped {
        color: #90b1b1;
      }

      #mpd.paused {
        color: #51a37a;
      }

      #language {
        background: #00b093;
        color: #740864;
        padding: 0 0.4em;
        margin: 0 5px;
        min-width: 16px;
      }

      #keyboard-state {
        background: #97e1ad;
        color: #000000;
        padding: 0 0px;
        margin: 0 5px;
        min-width: 16px;
      }

      #keyboard-state > label {
        padding: 0 5px;
      }

      #custom-spotify {
        padding: 0 10px;
        margin: 0 4px;
        color: #abb2bf;
      }

      #keyboard-state > label.locked {
        background: rgba(0, 0, 0, 0.2);
      }
    '';
  };
}
