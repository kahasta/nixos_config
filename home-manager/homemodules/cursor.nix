{ pkgs, ... }:


{
  xdg.desktopEntries = {
    cursorIDE = {
      name = "CursorIDE";
      genericName = "Cursor Ide with AI";
      exec = "appimage-run /home/kahasta/CursorIDE/cursor-0.6.0.AppImage";
      terminal = false;
    };
  };
}
