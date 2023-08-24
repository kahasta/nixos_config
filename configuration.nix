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
      # ./hyperland.nix
      # ./modules/neovim.nix
      # <home-manager/nixos>
    ];


  # Bootloader.
  # boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.loader.timeout = 10;
  boot.loader.grub = {
    efiSupport = true;
    enable = true;
    #efiInstallAsRemovable = true; # in case canTouchEfiVariables doesn't work for your system
    device = "nodev";
    useOSProber = true;
  };
  boot.supportedFilesystems = [ "ntfs" ];
  # boot.loader.systemd-boot.configurationLimit = 5;
  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    initrd.kernelModules = [ "amdgpu" ];
    # kernelPatches = [{
    #   name = "big-navi";
    #   patch = null;
    #   extraConfig = ''
    #     DRM_AMD_DC_DCN3_0 y
    #   '';
    # }];
  };

  boot.kernelModules = [ "amdgpu kvm-amd" "kvm-intel" ];
  boot.extraModprobeConfig = "options kvm_intel nested=1";


  # nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };

  nix.settings = {
    substituters = [ "https://nix-gaming.cachix.org" ];
    trusted-public-keys = [ "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=" ];
  };

  networking.hostName = "deeptown"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  networking.nameservers = [ "1.1.1.1" "8.8.8.8" "8.8.4.4" ];
  #networking.resolvconf.enable = pkgs.lib.mkForce false;
  networking.dhcpcd.extraConfig = "nohook resolv.conf";
  networking.networkmanager = lib.mkForce {
    dns = "none";
    enable = true;
  };
  networking.dhcpcd.enable = false;
  
  # services.dnscrypt-proxy2 = {
  #   enable = true;
  #   settings = {
  #     ipv6_servers = true;
  #     require_dnssec = true;

  #     sources.public-resolvers = {
  #       urls = [
  #         "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
  #         "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
  #       ];
  #       cache_file = "/var/lib/dnscrypt-proxy2/public-resolvers.md";
  #       minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
  #     };

  #     server_names = [ "adguard-dns-doh" ];
  #   };
  # };

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
    fira-code
    fira-code-symbols
    inter
    iosevka
    liberation_ttf
    roboto
    jetbrains-mono
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    font-awesome
    terminus-nerdfont
    nerdfonts
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
      driSupport32Bit = true;
      # package = unstablepkgs.mesa.drivers;
      # package32 = unstablepkgs.pkgsi686Linux.mesa.drivers;
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


  # environment.etc.openvpn.source = "${pkgs.update-resolv-conf}/libexec/openvpn";
  environment.etc = {
    "pipewire/pipewire.conf.d/pipewire.conf".text = ''
        context.properties = {
        default.clock.rate = 96000
        default.clock.allowed-rates = [ 96000 192000]
      }
    '';
    "wireplumber/main.lua.d/99-alsa-lowlatency.lua".text = ''
      alsa_monitor.rules = {
                                     {
                                           matches = {{{ "node.name", "matches", "alsa_output.*" }}};
                                           apply_properties = {
                                                   ["audio.format"] = "S32LE",
                                                   ["audio.rate"] = "96000", -- for USB soundcards it should be twice your desired rate
                                                   ["api.alsa.period-size"] = 2, -- defaults to 1024, tweak by trial-and-error
                                                   -- ["api.alsa.disable-batch"] = true, -- generally, USB soundcards use the batch mode
                                           },
                                     },
                                 }
    '';
  };



  environment.pathsToLink = [ "/libexec" ];

  # DWM custom build
  nixpkgs.overlays = [
    (final: prev: {
      # dwm = prev.dwm.overrideAttrs (old: { src = /home/kahasta/dwm;});
      dwm = prev.dwm.overrideAttrs (old: { src = /home/kahasta/dwm-flexipatch; });
      #pdwm = prev.dwm.overrideAttrs (old: { src = /home/kahasta/pdwm;});
      # dwmblocks = prev.dwmblocks.overrideAttrs (old: { src = /home/kahasta/dwm/dwmblocks;});
    })
  ];


  services = {
    cockpit = {
      enable = true;
      openFirewall = true;
    };

    # openssh = {
    #   enable = true;
    #   passwordAuthentication = false;
    #   kbdInteractiveAuthentication = false;

    # };

    spice-vdagentd = {
      enable = true;
    };

    spice-webdavd = {
      enable = true;
    };
    openvpn.servers = {
      kahasta-vpn = {
        config = ''
          config /home/kahasta/openvpn/MyAWS/kahasta.ovpn
          script-security 2
          up ${pkgs.update-systemd-resolved}/libexec/openvpn/update-systemd-resolved
          up-restart
          down ${pkgs.update-systemd-resolved}/libexec/openvpn/update-systemd-resolved
          down-pre
          '';
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
      enable = false;
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
      autorun = true; #enable x
      desktopManager.xfce.enable = true;
      # desktopManager.gnome.enable = true;
      # windowManager.leftwm.enable = true;
      # windowManager.dk.enable = true;
      # windowManager.dwm.enable = true;
      windowManager.awesome = {
        enable = true;
        luaModules = with pkgs.luaPackages; [
          luarocks
          luadbi-mysql
        ];
      };



      displayManager = {
        startx.enable = true;
        sddm = {
          enable = true;
          theme = "chili";
        };

        #lightdm.enable = true;
        # gdm = {
        #   enable = true;
        #   wayland = false;
        # };
        # defaultSession = "sway";
      };
      #   windowManager.qtile = {
      #     enable = true;
      #     backend = "x11";
      #     configFile = builtins.getEnv "HOME" + ".config/qtile/config.py";
      # extraPackages = python3Packages: with python3Packages; [
      #   qtile-extras
      # ];
      #   };
      # windowManager.herbstluftwm.enable = true;
      # windowManager.spectrwm.enable = true;
      # windowManager.bspwm.enable = true;
      # windowManager.i3 = {
      #   enable = true;
      #   package = pkgs.i3-gaps;
      #   # configFile = builtins.getEnv "HOME" + ".config/i3/config";
      #   extraPackages = with pkgs; [
      #     i3lock
      #     # (python3Packages.py3status.overrideAttrs (oldAttrs: {
      #     #   propagatedBuildInputs = with python3Packages; [ pytz tzlocal ] ++ oldAttrs.propagatedBuildInputs;
      #     # }))
      #   ];

      # };
    };
  };

  # programs.xwayland.enable = true;

  # programs.sway = {
  #   enable = true;
  #   wrapperFeatures.gtk = true; # so that gtk works properly
  #   extraPackages = with pkgs;
  #     let
  #       dbus-sway-environment = writeShellScriptBin "dbus-sway-environment" ''
  #         dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
  #         systemctl --user stop pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
  #         systemctl --user start pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
  #       '';
  #     in
  #     [
  #       swaylock
  #       swayidle
  #       dbus-sway-environment
  #       xdg-utils
  #       xwayland
  #       wl-clipboard
  #       wf-recorder
  #       wlr-randr
  #       wlroots
  #       wlr-protocols
  #       wlrctl
  #       tofi
  #       wob
  #       pcmanfm-qt
  #       wbg
  #       mako # notification daemon
  #       grim
  #       #kanshi
  #       slurp
  #       dmenu # Dmenu is the default in the config but i recommend wofi since its wayland native
  #     ];
  #   extraSessionCommands = ''
  #     export SDL_VIDEODRIVER=wayland
  #     export QT_QPA_PLATFORM=wayland
  #     export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
  #     export _JAVA_AWT_WM_NONREPARENTING=1
  #     export MOZ_ENABLE_WAYLAND=1
  #     systemctl --user import-environment XDG_SESSION_TYPE XDG_CURRENT_DESKTOP
  #     dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
  #     export TERM=xterm
  #   '';
  # };

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };
  services.dbus.enable = true;

  #programs.waybar.enable = true;


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
    user.services.shadowsocks-rust = {
      description = "shadowsocks-rust Daemon";
      after = [ "network.target" "openvpn-kahasta-vpn.service"];
      wantedBy = [ "multi-user.target" ];
      path = [ pkgs.shadowsocks-rust ];
      serviceConfig.PrivateTmp = true;
      script = ''
        exec sslocal -c /home/kahasta/shadowsocks/my.json
      '';
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
  services.blueman.enable = true;
  hardware.bluetooth.enable = true;


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    description = user;
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "polkit" "video" "audio" "storage" "qemu-libvirtd" "libvirtd" "libvirt" "kvm" "input" "disk" ];
    packages = with pkgs; [
      #firefox
      #  thunderbird
    ];
  };


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;
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
    sddm-chili-theme
    vulkan-tools


  ];

  # environment.sessionVariables = {
  #   GTK_USE_PORTAL = "0";
  # };

  # environment.sessionVariables.XDG_DATA_DIRS = [ (pkgs.glib.getSchemaDataDirPath pkgs.gsettings-desktop-schemas) ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  virtualisation.libvirtd.enable = true;
  virtualisation.waydroid.enable = true;
  # virtualisation.anbox.enable = true;
  virtualisation.podman.enable = true;
  # xdg.portal = {
  #   enable = true;
  #   wlr = {
  #     enable = true;
  #   };
  # extraPortals = with pkgs; [
  #   xdg-desktop-portal-wlr
  #   xdg-desktop-portal-kde
  #   # xdg-desktop-portal-gtk 
  # ];
  # };

  programs.dconf.enable = true;
  programs.zsh.enable = true;
  hardware.steam-hardware.enable = true;
  # programs.steam.enable = true;
  programs.ssh.askPassword = "";

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 5900 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

  # Auto upgrade
  #system.autoUpgrade = {
  #  enable = true;
  #  channel = "https://nixos.org/channels/nixos-unstable";
  #};


}
