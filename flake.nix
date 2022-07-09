{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.05";
    nixos-hardware = {
      url = "github:nixos/nixos-hardware";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, home-manager, nixos-hardware }:
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

        # sudo nixos-rebuild switch --flake .#nixos-x1
        nixosConfigurations.nixos-x1 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay ]; })
            "${nixos-hardware}/lenovo/thinkpad/x1/7th-gen"
            ./hardware-configuration-x1.nix
            ./configuration-shared.nix
            ./x1.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.simon = import ./home.nix;

              # Optionally, use home-manager.extraSpecialArgs to pass
              # arguments to home.nix
            }
          ];
        };
      };
}
