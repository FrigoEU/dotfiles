{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, home-manager }:
    let
      overlay = final: prev: (import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
      });
    in
      {
        nixosConfigurations.nixos-desktop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay ]; })
            ./hardware-configuration-desktop.nix
            ./configuration-shared.nix
            ./desktop.nix
          ];
        };
        nixosConfigurations.nixos-x1 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay ]; })
            ./hardware-configuration-desktop.nix
            ./configuration-shared.nix
            ./x1.nix
            (home-manager.nixosModules.home-manager
                {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.users.jdoe = import ./home.nix;

                  # Optionally, use home-manager.extraSpecialArgs to pass
                  # arguments to home.nix
                })
          ];
        };
      };
}
