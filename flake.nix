{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-21.11"; 
  };
  outputs = { self, nixpkgs }:
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
      };
}
