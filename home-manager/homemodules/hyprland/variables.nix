_: let
  vars = {
    NIXOS_OZONE_WL = "1";
    __GL_GSYNC_ALLOWED = "0";
    __GL_VRR_ALLOWED = "0";
    SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";
    DISABLE_QT5_COMPAT = "0";
    # ANKI_WAYLAND = "1";
    DIRENV_LOG_FORMAT = "";
    WLR_DRM_NO_ATOMIC = "1";

    # mozilla
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_DBUS_REMOTE = "1";

    # wlroots
    WLR_BACKEND = "vulkan";
    WLR_RENDERER = "vulkan";
    WLR_NO_HARDWARE_CURSORS = "1";
    # toolkits
    GDK_BACKEND = "wayland,x11";
    SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";

    CLUTTER_BACKEND = "wayland";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_QPA_PLATFORMTHEME = "xdgdesktopportal";

    WINIT_UNIX_BACKEND = "wayland";
    # QT_STYLE_OVERRIDE = "kvantum";
    _JAVA_AWT_WM_NONEREPARENTING = "1";

    XCURSOR_SIZE = "24";
    XCURSOR_THEME = "LyraQ-cursors";

    # apps
    BROWSER = "chromium";
    EDITOR = "nvim";
  };
in {
  home.sessionVariables = vars;
  systemd.user.sessionVariables = vars;
}
