{ config, pkgs, lib, ... }:
let 
  specifics = 
    { config, lib, pkgs, ... }:
    {
      networking.hostName = "nixos-desktop"; # Define your hostname.
      nixpkgs.config.allowUnfree = true;
      services.xserver.layout = "us";
      networking.interfaces.enp0s31f6.useDHCP = true;
      services.xserver.videoDrivers = [ "amdgpu" ];
      environment.systemPackages = with pkgs; [
        obs-studio openshot-qt
      ];
    };
  hwimports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration-desktop.nix
      /etc/nixos/cachix.nix
      specifics
    ];
in
import ./configuration-shared.nix {config = config;
                                   pkgs = pkgs;
                                   lib = lib;
                                   hwimports = hwimports; }
