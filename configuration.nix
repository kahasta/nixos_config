# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  user = "kahasta";
in
{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # ./modules/neovim.nix
      # <home-manager/nixos>
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.supportedFilesystems = [ "ntfs" ];
  boot.loader.systemd-boot.configurationLimit = 5;
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
   # initrd.kernelModules = [ "amdgpu" ];
  };

  boot.kernelModules = [ "kvm-amd" "kvm-intel" ];
  boot.extraModprobeConfig = "options kvm_intel nested=1";


  # nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };

  networking.hostName = "deeptown"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;


  # Set your time zone.
  time.timeZone = "Europe/Saratov";

  # Select internationalisation properties.
  i18n.defaultLocale = "ru_RU.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  fonts.fonts = with pkgs; [
    source-code-pro
    iosevka
    jetbrains-mono
    noto-fonts
    noto-fonts-emoji
    font-awesome
    nerdfonts
    proggyfonts
  ];

  # Video amd driver
  hardware = {
    enableRedistributableFirmware = true;
    opengl = {
      enable = true;
      driSupport = true;
      extraPackages = [
        #rocm-opencl-icd
        pkgs.amdvlk
      ];
      extraPackages32 = [
        pkgs.driversi686Linux.amdvlk
      ];
    };
  };

  environment = {
    variables.AMD_VULKAN_ICD = "RADV";
  };


  environment.etc.openvpn.source = "${pkgs.update-resolv-conf}/libexec/openvpn";

  environment.pathsToLink = [ "/libexec" ];

  services = {
    fstrim = {
      enable = true;
    };

    resolved = {
      enable = true;
      extraConfig = ''
        nameserver 1.1.1.1
        dns=none
      '';
    };

    picom = {
      enable = true;
      fade = true;
      inactiveOpacity = 1;
      shadow = true;
      backend = "glx";
      fadeDelta = 4;
      opacityRules = [
        "100:class_g = 'chromium-browser'"
      ];
    };

    xserver = {
      videoDrivers = [ "amdgpu" ];
      # Configure keymap in X11
      layout = "us,ru";
      xkbVariant = "";
      xkbOptions = "grp:ctrl_shift_toggle";
      # Enable the X11 windowing system.
      enable = true;
      displayManager = {
        lightdm.enable = true;
        defaultSession = "none+i3";
      };
      desktopManager.xfce.enable = true;
      windowManager.i3 = {
        enable = true;
        package = pkgs.i3-gaps;
        # configFile = builtins.getEnv "HOME" + ".config/i3/config";


      };
    };
  };




  # Systemd polkit config
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  security.polkit.adminIdentities = [ "unix-group:whell" ];

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  security.polkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    description = user;
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "polkit" "video" "audio" "storage" "qemu-libvirtd" "libvirtd" "disk" ];
    packages = with pkgs; [
      firefox
      #  thunderbird
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;




  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    openvpn
    i3
    polkit
    polkit_gnome
    virt-manager
    

  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  virtualisation.libvirtd.enable = true;

  programs.dconf.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

  # Auto upgrade
  #system.autoUpgrade = {
  #  enable = true;
  #  channel = "https://nixos.org/channels/nixos-unstable";
  #};


}
