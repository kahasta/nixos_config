{ pkgs, lib, ... }:
let
  nixvim = import (builtins.fetchGit {
    url = "https://github.com/nix-community/nixvim";
  });
in
{
  imports = [
    # For home-manager
    nixvim.homeManagerModules.nixvim
    ./nixvim/bufferline.nix
    ./nixvim/lspsaga.nix
    ./nixvim/colorizer.nix
    ./nixvim/comment.nix
    ./nixvim/gitsigns.nix
    ./nixvim/whichkeys.nix
    ./nixvim/indent-blankline.nix
    ./nixvim/chadtree.nix
    ./nixvim/telescope.nix
    ./nixvim/treesitter.nix
    ./nixvim/trouble.nix
    ./nixvim/leap.nix
    ./nixvim/illuminate.nix
    ./nixvim/autopairs.nix
    ./nixvim/null-ls.nix
    # ./nixvim/lsp.nix

    # For NixOS
    # nixvim.nixosModules.nixvim
    # # For nix-darwin
    # nixvim.nixDarwinModules.nixvim
  ];

  programs.nixvim.enable = true;
  programs.nixvim = {
    viAlias = true;
    vimAlias = true;
    package = pkgs.neovim-unwrapped;
    globals.mapleader = " ";

    extraPlugins = with pkgs.vimPlugins; [
      vim-nix
      vim-just
      vim-visual-multi
      plenary-nvim
      gruvbox-material
      mini-nvim
    ];

    extraConfigVim = ''
      :set dir=~/tmp
    '';

    # Esc bind on jj
    maps = {
      insert."jj" = {
        silent = true;
        action = "<Esc>";
        noremap = true;
      };
    };

    plugins = {
      lightline.enable = true;
      airline.enable = true;
      airline.theme = "onedark";
    };
    colorschemes.gruvbox.enable = true;

    options = {
      number = true;
      termguicolors = true;
      # Use X clipboard
      clipboard = "unnamedplus";
      tabstop = 2;
      expandtab = true;
      shiftwidth = 2;
    };

  };
}
