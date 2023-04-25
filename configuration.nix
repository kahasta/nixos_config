# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

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
  networking.nameservers = [ "1.1.1.1" "8.8.8.8" "8.8.4.4" ];
  networking.resolvconf.enable = pkgs.lib.mkForce false;
  networking.dhcpcd.extraConfig = "nohook resolv.conf";
  networking.networkmanager = lib.mkForce {
    dns = "none";
    enable = true;
  };
  networking.dhcpcd.enable = false;
  services.dnscrypt-proxy2 = {
    enable = true;
    settings = {
      ipv6_servers = true;
      require_dnssec = true;

      sources.public-resolvers = {
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
          "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
        ];
        cache_file = "/var/lib/dnscrypt-proxy2/public-resolvers.md";
        minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
      };

      server_names = [ "adguard-dns-doh" ];
    };
  };

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

  time.timeZone = "Europe/Saratov";

  fonts.fonts = with pkgs; [
    source-code-pro
    inter
    iosevka
    roboto
    jetbrains-mono
    # noto-fonts
    noto-fonts-emoji
    font-awesome
    nerdfonts
    # proggyfonts
  ];

  fonts = {
    enableDefaultFonts = true;
    fontDir.enable = true;
    fontconfig = {
      enable = true;
      antialias = true;
      defaultFonts = {
        serif = [ "Noto Sans" ];
        sansSerif = [ "Inter" ];
        monospace = [ "Iosevka" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };

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
  environment.etc = {
    "pipewire/pipewire.conf.d/pipewire.conf".text = ''
        context.properties = {
        default.clock.allowed-rates = [ 96000 192000]
      }
    '';
  };

  environment.pathsToLink = [ "/libexec" ];

  services = {
    openvpn.servers = {
      kahasta-vpn = {
        config = "config /home/kahasta/openvpn/MyAWS/kahasta.ovpn";
        autoStart = false;
        updateResolvConf = true;
      };
    };
    avahi.enable = true;
    ntp = {
      enable = true;
    };
    fstrim = {
      enable = true;
    };

    resolved = {
      enable = true;
      extraConfig = ''
        LLMNR=no
        ReadEtcHosts=no
        DNSSEC=no
        nameserver 1.1.1.1
        nameserver 8.8.8.8
        nameserver 8.8.4.4
      '';
      #dns=none
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
      xkbOptions = "grp:caps_toggle";
      # Enable the X11 windowing system.
      enable = true;
      displayManager = {
        lightdm.enable = true;
        # gdm = {
        #   enable = true;
        #   wayland = false;
        # };
        # defaultSession = "sway";
      };
      desktopManager.xfce.enable = true;
      #   windowManager.qtile = {
      #     enable = true;
      #     backend = "x11";
      #     configFile = builtins.getEnv "HOME" + ".config/qtile/config.py";
      # extraPackages = python3Packages: with python3Packages; [
      #   qtile-extras
      # ];
      #   };
      # windowManager.herbstluftwm.enable = true;
      windowManager.spectrwm.enable = true;
      windowManager.leftwm.enable = true;
      windowManager.bspwm.enable = true;
      windowManager.i3 = {
        enable = true;
        package = pkgs.i3-gaps;
        # configFile = builtins.getEnv "HOME" + ".config/i3/config";
        extraPackages = with pkgs; [
          i3lock
          # (python3Packages.py3status.overrideAttrs (oldAttrs: {
          #   propagatedBuildInputs = with python3Packages; [ pytz tzlocal ] ++ oldAttrs.propagatedBuildInputs;
          # }))
        ];

      };
    };
  };

  # programs.xwayland.enable = true;

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  # programs.sway = {
  #   enable = true;
  #   wrapperFeatures.gtk = true; # so that gtk works properly
  #   extraPackages = with pkgs; [
  #     swaylock
  #     swayidle
  #     xwayland
  #     wl-clipboard
  #     wf-recorder
  #     mako # notification daemon
  #     grim
  #     #kanshi
  #     slurp
  #     dmenu # Dmenu is the default in the config but i recommend wofi since its wayland native
  #   ];
  #   extraSessionCommands = ''
  #     export SDL_VIDEODRIVER=wayland
  #     export QT_QPA_PLATFORM=wayland
  #     export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
  #     export _JAVA_AWT_WM_NONREPARENTING=1
  #     export MOZ_ENABLE_WAYLAND=1
  #   '';
  # };

  # programs.waybar.enable = true;


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
    extraGroups = [ "networkmanager" "wheel" "polkit" "video" "audio" "storage" "qemu-libvirtd" "libvirtd" "libvirt" "kvm" "input" "disk" ];
    packages = with pkgs; [
      firefox
      #  thunderbird
    ];
  };

  users.extraUsers.useriso = {
    home = "/home/user1-isolated";
    group = "users";
    isNormalUser = true;
    extraGroups = [ "networkmanager" ];
    createHome = true;
    uid = 1001;
    shell = "/run/current-system/sw/bin/zsh";
    isSystemUser = false;
    packages = with pkgs; [
      # yandex-browser
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  # nixpkgs.config.permittedInsecurePackages = [
  #   "yandex-browser-22.9.1.1110-1"
  # ];




  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    openvpn
    openresolv
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
  programs.zsh.enable = true;
  programs.steam.enable = true;
  programs.ssh.askPassword = "";

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
