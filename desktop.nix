{ config, pkgs, lib, ... }:
let 
  specifics = 
    { config, lib, pkgs, ... }:
    {
      networking.hostName = "nixos-desktop"; # Define your hostname.
      nixpkgs.config.allowUnfree = true;
       services.xserver.layout = "us";
      # services.xserver.videoDrivers = [ "amdgpu-pro" ];
    };
  hwimports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration-desktop.nix
      specifics
    ];
in
import ./configuration-shared.nix {config = config;
                                   pkgs = pkgs;
                                   lib = lib;
                                   hwimports = hwimports; }
