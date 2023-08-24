{pkgs, ...}: let
  # runs processes as systemd transient services
  hyprstart = pkgs.writeShellScriptBin "hyprstart" ''
    export NIXOS_OZONE_WL="1"
    export __GL_GSYNC_ALLOWED="0"
    export __GL_VRR_ALLOWED="0"
    export SSH_AUTH_SOCK="/run/user/1000/keyring/ssh"
    export DISABLE_QT5_COMPAT="0"
    # ANKI_WAYLAND="1"
    export DIRENV_LOG_FORMAT=""
    export WLR_DRM_NO_ATOMIC="1"

    # mozilla
    export MOZ_ENABLE_WAYLAND="1"
    export MOZ_DBUS_REMOTE="1"

    # wlroots
    export WLR_BACKEND="vulkan"
    export WLR_RENDERER="vulkan"
    export WLR_NO_HARDWARE_CURSORS="1"
    # toolkits
    export GDK_BACKEND="wayland,x11"
    export SDL_VIDEODRIVER="wayland"
    export XDG_SESSION_TYPE="wayland"
    export XDG_CURRENT_DESKTOP="Hyprland"
    export XDG_SESSION_DESKTOP="Hyprland"

    export CLUTTER_BACKEND="wayland"
    export QT_AUTO_SCREEN_SCALE_FACTOR="1"
    export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
    export QT_QPA_PLATFORM="wayland;xcb"
    export QT_QPA_PLATFORMTHEME="xdgdekstopportal"

    export WINIT_UNIX_BACKEND="wayland"
    # QT_STYLE_OVERRIDE="kvantum"
    export _JAVA_AWT_WM_NONEREPARENTING="1"

    export XCURSOR_SIZE="24"
    export XCURSOR_THEME="LyraQ-cursors"

    # apps
    export TERM="footclient"
    export BROWSER="firedragon"
    export EDITOR="nvim"

    Hyprland
  '';
in {
  home = {
    packages = [hyprstart];
  };
}
