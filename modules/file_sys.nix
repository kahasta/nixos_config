{ config, pkgs, ... }:
{
  boot.supportedFilesystems = [ "ntfs" ];
  # File systems
  fileSystems."/mnt/archiew" = {
    device = "/dev/sda1";
    fsType = "auto";
    options = [ "defaults" "user" "rw" "utf8" "noauto" "umask=000" ];
  };

  fileSystems."/mnt/games" = {
    device = "/dev/sdd1";
    fsType = "auto";
    options = [ "defaults" "user" "rw" "utf8" "noauto" "umask=000" ];
  };

  fileSystems."/mnt/data" = {
    device = "/dev/sdb1";
    fsType = "auto";
    options = [ "defaults" "user" "rw" "utf8" "noauto" "umask=000" ];
  };
}
