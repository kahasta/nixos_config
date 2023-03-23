{
  description = "My awesome doom";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };

      lib = nixpkgs.lib;
    in

    {
      hmConfigurations = {
        kahasta = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          # inherit system;
          modules = [
            ./home-manager/home.nix
            {
              home = {
                username = "kahasta";
                homeDirectory = "/home/kahasta";
                stateVersion = "22.11";
              };
            }
          ];
        };
      };
      nixosConfigurations = {
        deeptown = lib.nixosSystem {
          inherit system;

          modules = [
            ./configuration.nix
          ];
        };
      };
    };
}
