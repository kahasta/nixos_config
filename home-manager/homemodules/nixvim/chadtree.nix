{
  programs.nixvim = {
    plugins.chadtree.enable = true;
    maps = {
      #Chadtree 
      normal."<C-n>" = {
        silent = true;
        action = "<cmd>CHADopen<CR>";
      };
    };
};
}
