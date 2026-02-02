{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware"; 
    }; 
    llm-agents.url = "github:numtide/llm-agents.nix";
    # emacs-overlay = { url    = "github:nix-community/emacs-overlay"; inputs = { nixpkgs.follows = "nixpkgs"; }; }; 
  }; 
  outputs = {
    self, nixpkgs, nixos-hardware, llm-agents # , emacs-overlay
  }: 
    let
      # overlay = final: prev: (
      #     import nixpkgs { 
      #       system = "x86_64-linux"; 
      #       config.allowUnfree = true; 
      #       overlays = [
      #         # llm-agents.overlays.default
      #         # emacs-overlay.overlay
      #       ]; 
      #     });
      system = "x86_64-linux";
    in
      {
        nixosConfigurations.nixos-desktop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hardware-configuration-desktop.nix
            ({config, pkgs, lib, ...}: 
              import ./configuration-shared.nix {
                inherit config;
                inherit pkgs;
                inherit lib;
                llm-agents = llm-agents.packages.${system};
              })
            ./desktop.nix
          ];
        };

        # sudo nixos-rebuild switch --flake .#nixos-slim5
        nixosConfigurations.nixos-slim5 = nixpkgs.lib.nixosSystem {
          inherit system;
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

            ({config, pkgs, lib, ...}: 
              import ./configuration-shared.nix {
                inherit config;
                inherit pkgs;
                inherit lib;
                llm-agents = llm-agents.packages.${system};
              })
            ./slim5.nix
          ];
        };
      };
  nixConfig = {
    extra-substituters = [ "https://cache.numtide.com" ];
    extra-trusted-public-keys = [ "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g=" ];
  };
}
