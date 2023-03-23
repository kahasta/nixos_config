{ config, pkgs, ... }:
  {
   programs.neovim = {
     viAlias = true;
     vimAlias = true;
     enable = true;
     defaultEditor = true;
     configure = {
     customRC = ''
       set number
     '';

     extraPackages = with pkgs; [
      # Language servers
      pyright
      ccls
      gopls
      ltex-ls
      emmet-ls
      lua-language-server
      nodePackages.bash-language-server
      nodePackages.graphql-language-service-cli
      nodePackages.vscode-langservers-extracted
      stable.nil

      # null-ls sources
      alejandra
      asmfmt
      black
      cppcheck
      deadnix
      editorconfig-checker
      gofumpt
      gitlint
      mypy
      nodePackages.alex
      nodePackages.prettier
      nodePackages.markdownlint-cli
      python3Packages.flake8
      shellcheck
      shellharden
      shfmt
      statix
      stylua
      vim-vint

      # DAP servers
      delve 
     ];
     packages.myVimPackage = with pkgs.vimPlugins; {
       start = [
         vim-nix
       ];
     };
     };
  };
  }
