{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    shellAliases = {
      em = "emacs -nw";
      ems = "sudo -E emacs -nw";
      edhome = "em ~/.config/home-manager/home.nix";
      edcfg = "ems /etc/nixos/configuration.nix";
    };
    enableAutosuggestions = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        #            "command-not-found"
        #            "poetry"
      ];
      theme = "agnoster";
    };
    plugins = [
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "2d60a47cc407117815a1d7b331ef226aa400a344";
          sha256 = "1pnxr39cayhsvggxihsfa3rqys8rr2pag3ddil01w96kw84z4id2";
        };
      }
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.5.0";
          sha256 = "0za4aiwwrlawnia4f29msk822rj9bgcygw6a8a6iikiwzjjz0g91";
        };
      }
    ];
  };
}
