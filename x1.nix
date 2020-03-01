{ config, pkgs, ... }:
let 
  nixoshw = builtins.fetchTarball {
	  url = https://github.com/nixos/nixos-hardware/archive/6f502bc6e62ef8519be4a5ff37b03d8ca5007dce.tar.gz;
	};
  hwimports =
    [ # Include the results of the hardware scan.
      "${nixoshw}/lenovo/thinkpad/x1/6th-gen"
      "${nixoshw}/lenovo/thinkpad/x1/6th-gen/QHD"
      ./hardware-configuration-x1.nix ];
in
  import ./configuration-shared.nix {config = config;
                                    pkgs = pkgs;
                                    hwimports = hwimports; }
