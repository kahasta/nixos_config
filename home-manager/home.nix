{ config, pkgs, ... }:

let
  username = "kahasta";
  homeDirectory = "/home/${username}";
  configHome = "${homeDirectory}/.config";
in
{
  imports = [
    # ./homemodules/sway.nix
     # ./homemodules/waybar.nix
    # ./homemodules/eww.nix
    ./homemodules/bspwm.nix
     ./homemodules/i3wm.nix
     ./homemodules/spectrwm.nix
    # ./homemodules/herbstluftwm.nix
     ./homemodules/i3blocks.nix
    ./homemodules/polybar.nix
    ./homemodules/nixvim.nix
    ./homemodules/kitty.nix
    ./homemodules/zsh.nix
    ./homemodules/exa.nix
    ./homemodules/dunst.nix
    ./homemodules/rofi.nix
    # ./homemodules/i3status-rust.nix
  ];

  # nixpkgs.overlays = [
  #   # (import (builtins.fetchTarball {
  #     #   url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
  #     #   sha256 = "0ghdh82a5yihqqinbr23smk870pi8imjjqasvaw5br4iwh4qi7pp";
  #     # }))
  #     (import (builtins.fetchGit {
  #       url = https://github.com/nix-community/emacs-overlay.git;
  #       rev= "c470756d69bc9195d0ddc1fcd70110376fc93473";
  #       ref = "master";
  #     }))
  # ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = username;
  home.homeDirectory = homeDirectory;

  nixpkgs.config.allowUnfree = true;
  home.file.".config/nixpkgs/config.nix".text = ''
    { allowUnfree = true; }
  '';

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;


  programs.bat = {
    enable = true;
    config = {
      theme = "Coldark-Dark";
    };
  };



  programs.starship = {
    enable = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultOptions = [
      "--color=dark"
      "--color=fg:-1,bg:-1,hl:#c678dd,fg+:#ffffff,bg+:#4b5263,hl+:#d858fe"
      "--color=info:#98c379,prompt:#61afef,pointer:#be5046,marker:#e5c07b,spinner:#61afef,header:#61afef"
    ];
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };




  xdg = {
    inherit configHome;
    configFile."proton.conf" = {
      target = "proton.conf";
      text = ''
        steam = "${pkgs.steam}"
        data = "/mnt/games/Proton"
      '';
    };
    configFile."starship.toml" = {
      target = "starship.toml";
      text = ''
        "$schema" = 'https://starship.rs/config-schema.json'

        add_newline = false

        [package]
        disabled = true

        [character]
        success_symbol = '[ ](bold #cba6f7)[ ](bold #f2cdcd)[ ](bold #b4befe)[ ](bold #a6e3a1)'
        error_symbol = '[ ](bold #cba6f7)[ ](bold #f2cdcd)[ ](bold #b4befe)[ ](bold #f38ba8)'
        vimcmd_symbol = '[ NORMAL](bold #fab387)'
        vimcmd_visual_symbol = '[ VISUAL](bold #89dceb)'

        [git_branch]
        symbol = ' '

        [git_status]
        modified = ''
        untracked = ''
        staged = ''
      '';
    };
    enable = true;
  };

  programs.emacs = {
    enable = true;
    # package = pkgs.emacsGit;
  };




  home.file.".emacs.d" = {
    source = ./.emacs.d;
    recursive = true;
  };


  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "chromium";
    TERMINAL = "xterm-kitty";
    TERM = "xterm-256color";
  };



  home.packages = with pkgs; [
    neofetch
    # Emacs
    ripgrep
    gtk3
    #shell
    trayer
    xlockmore
    ranger
    vifm-full
    tldr
    bash
    zip
    unzip
    htop-vim
    dnsutils
    whois
    killall
    nethogs
    binutils
    lsof
    lm_sensors
    xclip
    duf
    xdotool
    asciiquarium
    #wireguard-tools

    #windows
    proton-caller
    protontricks
    protonup-ng
    wineWowPackages.stagingFull

    #multimedia
    cmus
    easyeffects
    youtube-dl
    mkchromecast
    pavucontrol

    #translate
    crow-translate
    # kitty
    xsel

    # GUI
    qbittorrent
    lxappearance
    tdesktop
    mupdf
    mpv
    #libreoffice
    ark
    bluedevil
    gwenview
    #Browsers
    chromium
    qutebrowser
    librewolf


    #other
    baobab
    #yandex-browser

    # for i3
    dunst
    pamixer
    i3blocks-gaps
    # picom
    feh
    dmenu
    pcmanfm
    volumeicon

    # Develop
    coreutils
    nixpkgs-fmt
    nodejs
    cargo
    gcc
    gnumake
    ripgrep
    vscodium-fhs

    #Android
    jmtpfs
    gphoto2
    libmtp
    mtpfs

    #langs
    python3

    nix-prefetch-git
    ntfs3g
    trash-cli

    usbutils
    mesa
    #firejail
  ];


}
