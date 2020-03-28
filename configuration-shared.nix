# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, hwimports, ... }:

let 
  emacsOverlay = import (builtins.fetchTarball {
      url = https://github.com/nix-community/emacs-overlay/archive/5f602f561ec0eaace6846656f5e6155c4d59a67b.tar.gz;
    });
  withOverlays = import <nixpkgs> { overlays = [ emacsOverlay ]; };
  pragmatapro = import ./pragmatapro.nix {runCommand = pkgs.runCommand;
                                          requireFile = pkgs.requireFile;
                                          unzip = pkgs.unzip;
                                         };
in
{
  imports = hwimports;
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # boot.loader.grub.device = "/dev/nvme0n1";
  boot.loader.grub.devices = [ "nodev" ];
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.useOSProber = true;

  # fill in <ifname> via nmcli device (eg: wlp0s20f3)
  # fill in <pw>
  # nmcli connection add con-name "M&S 2.4GHz Bonanza" type wifi ifname <ifname> ipv4.method auto autoconnect yes wifi.ssid "M&S 2.4GHz Bonanza" wifi-sec.psk "<pw>" wifi-sec.key-mgmt "wpa-psk"
  # networking.networkmanager.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp0s31f6.useDHCP = true;
  networking.interfaces.wlp0s20f3.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n = {
    consoleFont = "PragmataPro Mono";
    consoleUseXkbConfig = true;
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/Brussels";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget vim firefox git
    withOverlays.emacsGit 
    # emacs vterm
    withOverlays.emacsPackagesNg.emacs-libvterm
    gnumake direnv libnotify
    entr silver-searcher 
    unzip
  ];
  services.lorri.enable = true;
  services.tlp.enable = true;

  services.postgresql = {
    enable = true;
    initialScript = pkgs.writeText "backend-initScript" ''
      CREATE USER simon;
      ALTER USER simon WITH superuser;
    '';
    authentication = pkgs.lib.mkOverride 10 ''
      # Generated file via nix; do not edit!
      local all all              trust
      host  all all 127.0.0.1/32 trust
      host  all all ::1/128      trust
    '';
    extraConfig = ''
      log_statement = 'all'
      logging_collector = on
      log_directory = 'pg_log'
      max_connections = 300
      shared_buffers = 80MB
    '';
  };
  fonts.fonts = [
    pragmatapro
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  programs.ssh.startAgent = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  environment.variables = {
    PLASMA_USE_QT_SCALING = "1";

    # Preferred applications
    # EDITOR = "emacsclient -c";
    BROWSER = "firefox";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # services.compton.enable = true;
  # services.compton.backend = "xrender";

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.displayManager.lightdm.autoLogin = { enable = true; user = "simon"; };
  services.xserver.desktopManager.plasma5.enable = true;

  # EXWM: Emacs Window Manager
  # https://www.reddit.com/r/NixOS/comments/8ghg4f/exwm_problem/
  # services.xserver.displayManager.sessionCommands = "${pkgs.xorg.xhost}/bin/xhost +SI:localuser:$USER";
  # services.xserver.windowManager.session = lib.singleton {
  #   name = "exwm";
  #   start = ''
  #     ${withOverlays.emacsGit}/bin/emacs --eval "(exwm-enable)"
  #   '';
  # };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.mutableUsers = false;
  users.users.simon = {
    isNormalUser = true;
    hashedPassword = "$6$Jm3nlU.X$ssyK4RCasLJcEViRlsMBYAWD9e8rdgNUALMTEwhoTwQ.1Oeniu0yDSzetPz.3.T8tgr7mKXqw7DHWuQ7tgd./0";
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?

}

