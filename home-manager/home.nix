{ config, pkgs, inputs, ... }:

let
  username = "kahasta";
  homeDirectory = "/home/${username}";
  configHome = "${homeDirectory}/.config";
  # nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  # rust-overlay.url = "github:oxalica/rust-overlay";

  # dwmblocks = pkgs.dwmblocks.overrideAttrs (old: {
  #   src = /home/kahasta/dwm/dwmblocks;
  # });
  # neovim = pkgs.neovim.overrideAttrs (old: {
  #   src = https://github.com/neovim/neovim.git;
  # });
in
{
  imports = [
    # ./homemodules/nnn.nix
    ./homemodules/cursor.nix
    # ./homemodules/sway.nix
    ./homemodules/waybar.nix
    ./homemodules/hyprland/hyprland.nix
    # ./homemodules/pidgin.nix
    # ./homemodules/tint2.nix
    # ./homemodules/eww.nix
    # ./homemodules/bspwm.nix
    # ./homemodules/i3wm.nix
    # ./homemodules/spectrwm.nix
    # ./homemodules/herbstluftwm.nix
    # ./homemodules/i3blocks.nix
    # ./homemodules/polybar.nix
    ./homemodules/nixvim.nix
    ./homemodules/kitty.nix
    ./homemodules/zsh.nix
    ./homemodules/exa.nix
    ./homemodules/dunst.nix
    ./homemodules/rofi.nix
    # ./homemodules/i3status-rust.nix

  ];

 # nixpkgs.overlays = [ rust-overlay.overlays.default ];
  # nixpkgs.overlays = [
  #   # (import (builtins.fetchTarball {#     #   url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
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
  home.stateVersion = "23.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  # programs.home-manager = {
  #   path = "https://github.com/nix-community/home-manager/archive/master.tar.gz";
  # };

  programs.bat = {
    enable = true;
    config = {
      theme = "Coldark-Dark";
    };
  };



  programs.starship = {
    enable = true;
    # settings = {
    #   success_symbol = "[](bold #cba6f7)[](bold #f2cdcd)[](bold #b4befe)[ ](bold #a6e3a1)";
    #   error_symbol = "[](bold #cba6f7)[](bold #f2cdcd)[](bold #b4befe)[ ](bold #f38ba8)";
    # };
  };

  # services.sxhkd = {
  #   enable = true;
  # };

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
    # configFile."nvim/init.lua" = {
    #   target = "init.lua";
    # };
    # configFile."proton.conf" = {
    #   target = "proton.conf";
    #   text = ''
    #     steam = "${pkgs.steam}/bin/"
    #     data = "/mnt/games/Proton"
    #   '';
    # };
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
    BROWSER = "firefox";
    TERMINAL = "xterm-kitty";
    TERM = "xterm";
  };

  home.packages = with pkgs; [

    dwmblocks
    neofetch
    # Emacs
    ripgrep
    gtk3
    #shell
    xkblayout-state
    tigervnc
    trayer
    xlockmore
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
    appimage-run
    waybar
    #wireguard-tools
    qt6.qtwayland
    libsForQt5.qt5.qtwayland
    kotatogram-desktop

    #windows
    # proton-caller
    # protontricks
    # protonup-ng
    # protontricks
    dxvk
    bottles-unwrapped
    wineWowPackages.stable
    wine-staging
    winetricks
    # wineWowPackages.stagingFull
    # steam-run-native
    cabextract
    gnome.zenity

    # EMU
    # yuzu-mainline
    citra-canary

    #MULTIMEDIA                                                                      
    radeontop
    SDL2
    openal
    cmus
    easyeffects
    yt-dlp
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
    # telegrams
    ark
    bluedevil
    gwenview
    #Browsers
    vieb
    brave
    #chromium
    firefox


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
    #pcmanfm                                                                                                                                                                                   
    volumeicon
    volctl

    # Develop
    coreutils
    nixpkgs-fmt
    nodejs
    gcc
    gnumake
    ripgrep
    vscodium-fhs
    # Golang
    go
    go-outline
    gopls
    gopkgs
    go-tools
    godef
    delve
    # Rust langs
    rustup
    # rust-bin.stable.latest.default

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
