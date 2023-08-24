{ pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    wofi
    waybar
    hyprpaper
    wl-clipboard
    eww-wayland
  ];
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    xwayland.hidpi = true;
  };
}
