{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    initExtra = ''
    '';
    shellAliases = {
      em = "emacs -nw";
      ems = "sudo -E emacs -nw";
      edhome = "em ~/.config/home-manager/home.nix";
      edcfg = "ems /etc/nixos/configuration.nix";
      cat = "bat";
      du = "duf";
      useriso = "sudo -i -u useriso";
      vi = "nvim";
      vim = "nvim";
    };
    # enableAutosuggestions = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "command-not-found"
        "ag"
        "colored-man-pages"
        "cp"
        "z"
        #            "poetry"
      ];
      theme = "agnoster";
    };
    plugins = [
      {
        # will source zsh-autosuggestions.plugin.zsh
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.4.0";
          sha256 = "0z6i9wjjklb4lvr7zjhbphibsyx51psv50gm07mbb0kj9058j6kc";
        };
      }
      # {
      #   name = "enhancd";
      #   file = "init.sh";
      #   src = pkgs.fetchFromGitHub {
      #     owner = "b4b4r07";
      #     repo = "enhancd";
      #     rev = "v2.2.1";
      #     sha256 = "0iqa9j09fwm6nj5rpip87x3hnvbbz9w9ajgm6wkrd5fls8fn8i5g";
      #   };
      # }
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
