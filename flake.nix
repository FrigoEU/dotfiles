{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05";
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware"; 
    }; 
    llm-agents.url = "github:numtide/llm-agents.nix";
    awsvpnclient-nix = {
      url = "github:AddG0/awsvpnclient-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    # emacs-overlay = { url    = "github:nix-community/emacs-overlay"; inputs = { nixpkgs.follows = "nixpkgs"; }; };
  };
  outputs = {
    self, nixpkgs, nixos-hardware, llm-agents, awsvpnclient-nix, home-manager, plasma-manager # , emacs-overlay
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
            # Nobi VPN
            awsvpnclient-nix.nixosModules.default
            {
              programs.awsvpnclient.enable = true;
              # Order after systemd-resolved: the service's bwrap launcher
              # only adds --symlink /etc/resolv.conf when the symlink resolves
              # at start time. Otherwise the sandbox has no DNS for its
              # whole lifetime and openvpn can't resolve the VPN endpoint.
              systemd.services.awsvpnclient = {
                after = [ "systemd-resolved.service" ];
                wants = [ "systemd-resolved.service" ];
              };
            }
            # Nobi VPN - END
            ({config, pkgs, lib, ...}: 
              import ./configuration-shared.nix {
                inherit config;
                inherit pkgs;
                inherit lib;
                llm-agents = llm-agents.packages.${system};
              })
            ./desktop.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit plasma-manager; };
              home-manager.users.simon = import ./home.nix;
            }
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
            # Nobi VPN
            awsvpnclient-nix.nixosModules.default
            {
              programs.awsvpnclient.enable = true;
              systemd.services.awsvpnclient = {
                after = [ "systemd-resolved.service" ];
                wants = [ "systemd-resolved.service" ];
              };
            }
            # Nobi VPN - END
            ({config, pkgs, lib, ...}:
              import ./configuration-shared.nix {
                inherit config;
                inherit pkgs;
                inherit lib;
                llm-agents = llm-agents.packages.${system};
              })
            ./slim5.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit plasma-manager; };
              home-manager.users.simon = import ./home.nix;
            }
          ];
        };
      };
  nixConfig = {
    extra-substituters = [ "https://cache.numtide.com" ];
    extra-trusted-public-keys = [ "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g=" ];
  };
}
