{ config, pkgs, lib, ... }:
let 
  specifics = 
    { config, lib, pkgs, ... }:
    {
      networking.hostName = "nixos-x1"; # Define your hostname.
      services.xserver.layout = "be";
      services.xserver.xkbOptions = "caps:swapescape";
      networking.networkmanager.enable = true;
      networking.interfaces.enp0s31f6.useDHCP = true;
      networking.interfaces.wlp0s20f3.useDHCP = true;

      # Bluetooth support:
      # * bluetooth is heel goeie audio met A2DP, maar dan kan je niet babbelen
      # * HSP/HFP is om ook te kunnen babbelen, maar dan is de kwaliteit echt slecht
      #
      hardware.pulseaudio = {
        enable = true;
        package = pkgs.pulseaudioFull;
        extraModules = [ pkgs.pulseaudio-modules-bt ];
      };
      hardware.bluetooth.enable = true;
      hardware.bluetooth.config = {
        General = {
          Enable = "Source,Sink,Media,Socket";
        };
      };

      system.stateVersion = "20.09"; # Did you read the comment?
    };
  nixoshw = builtins.fetchTarball {
	  url = https://github.com/nixos/nixos-hardware/archive/6f502bc6e62ef8519be4a5ff37b03d8ca5007dce.tar.gz;
	};
  hwimports =
    [ # Include the results of the hardware scan.
      "${nixoshw}/lenovo/thinkpad/x1/6th-gen"
      "${nixoshw}/lenovo/thinkpad/x1/6th-gen/QHD"
      specifics
      ./hardware-configuration-x1.nix ];
in
import ./configuration-shared.nix {
  config = config;
  pkgs = pkgs;
  lib = lib;
  hwimports = hwimports ++ [/etc/nixos/cachix.nix];
}
