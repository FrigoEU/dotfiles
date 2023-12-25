{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.11";
    nixos-hardware = {
      url = "github:nixos/nixos-hardware";
    };
    emacs-overlay = {
      url    = "github:nix-community/emacs-overlay";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
  };
  outputs = { self, nixpkgs, nixos-hardware, emacs-overlay }:
    let
      overlay = final: prev: (import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
        overlays = [ emacs-overlay.overlay ];
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
            ({ config, pkgs, ... }: { nixpkgs.overlays = [overlay]; })
            "${nixos-hardware}/lenovo/thinkpad/x1/7th-gen"
            ./hardware-configuration-x1.nix
            ./configuration-shared.nix
            ./x1.nix
          ];
        };
      };
}
