{
  programs.nixvim = {
    plugins.comment-nvim.enable = true;
    # Neovim seems to register <C-/> as <C-_>
    maps.normal."<c-/>" = "<Plug>(comment_toggle_linewise_current)";
    maps.visual."<c-/>" = "<Plug>(comment_toggle_linewise_visual)";
  };
}
