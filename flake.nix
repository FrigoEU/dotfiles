{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware"; 
    }; 
    # emacs-overlay = { url    = "github:nix-community/emacs-overlay"; inputs = { nixpkgs.follows = "nixpkgs"; }; }; 
  }; 
  outputs = {
    self, nixpkgs, nixos-hardware # , emacs-overlay
  }: 
    let overlay = final: prev: (
          import nixpkgs { 
            system = "x86_64-linux"; 
            config.allowUnfree = true; 
            overlays = [
              # emacs-overlay.overlay
            ]; 
          });
    in
      {
        nixosConfigurations.nixos-desktop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hardware-configuration-desktop.nix
            ./configuration-shared.nix
            ./desktop.nix
          ];
        };

        # sudo nixos-rebuild switch --flake .#nixos-x1
        nixosConfigurations.nixos-x1 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            "${nixos-hardware}/lenovo/thinkpad/x1/7th-gen"
            ./hardware-configuration-x1.nix
            ./configuration-shared.nix
            ./x1.nix
          ];
        };

        # sudo nixos-rebuild switch --flake .#nixos-slim5
        nixosConfigurations.nixos-slim5 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            # ({ config, pkgs, ... }: {  nixpkgs.overlays = [overlay]; })
            #     "${nixos-hardware}/lenovo/ideapad/z510"
            "${nixos-hardware}/common/cpu/intel"
            "${nixos-hardware}/common/gpu/intel"
            "${nixos-hardware}/common/pc/laptop"
            # "${nixos-hardware}/common/pc/laptop/acpi_call.nix"
            "${nixos-hardware}/common/pc/ssd"
            ./hardware-configuration-slim5.nix
            # ./conf-default.nix
            ./configuration-shared.nix
            ./slim5.nix
          ];
        };
      };
}
