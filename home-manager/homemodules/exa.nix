let
  aliases = {
    l = "exa";
    ls = "exa";
    ll = "exa -l";
    la = "exa -a";
    lt = "exa --tree";
    lla = "exa -la";
  };
in
{
  programs.bash.shellAliases = aliases;

  programs.zsh.shellAliases = aliases;

  programs.fish.shellAliases = aliases;

  programs.ion.shellAliases = aliases;

  programs.exa = {
    enable = true;
    enableAliases = true;
  };
}
