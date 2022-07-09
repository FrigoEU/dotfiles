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
}
