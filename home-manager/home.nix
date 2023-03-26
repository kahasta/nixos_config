{ config, pkgs, ... }:

let
  username = "kahasta";
  homeDirectory = "/home/${username}";
  configHome = "${homeDirectory}/.config";
in
{
  imports = [
    ./homemodules/nixvim.nix
    ./homemodules/kitty.nix
    ./homemodules/zsh.nix
    ./homemodules/exa.nix
  ];

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

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  xdg = {
    inherit configHome;
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
  };


  home.file.".emacs.d" = {
    source = ./.emacs.d;
    recursive = true;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "chromium";
    TERMINAL = "xterm-kitty";
    TERM = "xterm-kitty";
  };

  home.packages = with pkgs; [
    neofetch
    # Emacs
    ripgrep
    gtk3
    #shell
    ranger
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
    libreoffice
    ark
    bluedevil
    gwenview
    #Browsers
    chromium
    qutebrowser
    #yandex-browser

    # for i3
    dunst
    # picom
    feh
    dmenu
    rofi
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
    firejail
  ];


  services = {
    dunst = {
      enable = true;
    };
  };
}
