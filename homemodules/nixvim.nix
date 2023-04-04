{ pkgs, lib, ... }:
let
  nixvim = import (builtins.fetchGit {
    url = "https://github.com/pta2002/nixvim";
    rev = "3d64fab719567efea806d0e2cb09084f62072fa8";
  });
in
{
  imports = [
    # For home-manager
    nixvim.homeManagerModules.nixvim
    # For NixOS
    # nixvim.nixosModules.nixvim
    # # For nix-darwin
    # nixvim.nixDarwinModules.nixvim
  ];

  programs.nixvim.enable = true;
  programs.nixvim = {
    viAlias = true;
    vimAlias = true;
    extraPlugins = with pkgs.vimPlugins; [
      vim-nix
    ];
    plugins = {
      lightline.enable = true;
      airline.enable = true;
      airline.theme = "onedark";
      cmp-treesitter.enable = true;
      cmp-vim-lsp.enable = true;
      #nix
      lsp.servers.rnix-lsp.enable = true;
      #UI
      neo-tree.enable = true;
      # barbar.enable = true;
    };
    colorschemes.gruvbox.enable = true;

    options = {
      number = true;
      shiftwidth = 2;
    };

    maps = {
      #NeoTree 
      normal."<C-n>" = {
        silent = true;
        action = "<cmd>NeoTreeShowToggle<CR><cmd>NeoTreeFocusToggle<CR>";
      };

      normal."<A-,>" = {
        silent = true;
        action = "<cmd>BufferPrevious<CR>";
      };

      normal."<A-.>" = {
        silent = true;
        action = "<cmd>BufferPrevious<CR>";
      };
    };
  };
}
