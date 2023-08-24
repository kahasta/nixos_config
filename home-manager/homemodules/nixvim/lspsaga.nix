{
  programs.nixvim = {
    plugins.lspsaga.enable = true;


    maps = {
      normal = {
        "gh" = "<cmd>Lspsaga lsp_finder<CR>";
        "gr" = "<cmd>Lspsaga rename<CR>";
        "gd" = "<cmd>Lspsaga peek_definition<CR>";
      };
      normalVisualOp."<leader>ca" = "<cmd>Lspsaga code_action<CR>";
    };
  };
}
