# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

# sudo nix-channel --list is different from nix-channel --list !
# update: sudo nixos-rebuild switch --upgrade

{ config, pkgs, lib, hwimports, ... }:

let 
  # emacsOverlay = import (builtins.fetchTarball {
  #   url = https://github.com/nix-community/emacs-overlay/archive/b3b8bcce385ea339289d03b6c2083b417e15e82b.tar.gz;
  # });
  # withOverlays = import <nixpkgs> { overlays = [ emacsOverlay ]; };

  pragmatapro = import ./pragmatapro.nix {runCommand = pkgs.runCommand;
                                          requireFile = pkgs.requireFile;
                                          unzip = pkgs.unzip;
                                         };
  dockerRegistryPort = 5000;
  dockerRegistryConfigPath = "/tmp/daemon.json";
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
  networking.extraHosts =
    ''
192.168.202.235 kl0000.aperigroup.com
  '';

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n = {
    consoleFont = "PragmataPro Mono";
    consoleUseXkbConfig = true;
    defaultLocale = "en_US.UTF-8";
  };

  virtualisation.docker.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Brussels";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget vim google-chrome chromium firefox git teams

    ((emacsPackagesNgGen emacs).emacsWithPackages (epkgs: [
      epkgs.emacs-libvterm
    ]))

    htop jq
    
    gnumake direnv libnotify
    entr silver-searcher 
    unzip
    autoconf automake libtool
    teams
    blender openvpn

    docker
    docker-compose
    jetbrains.idea-community
    maven

    # (perl.withPackages(p: with p; [
    #   RPCEPCService
    #   DBI
    #   DBDPg
    # ])) # edbi -> dbi:Pg:dbname=urwebschool
  ];
  services.lorri.enable = true;
  services.tlp.enable = true;

  services.postgresql = {
    package = pkgs.postgresql_12;
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
    settings = {
      log_statement = "all";
      logging_collector = true;
      log_directory = "pg_log";
      max_connections = 300;
      shared_buffers = "80MB";
    };
  };
  systemd.extraConfig = ''
    DefaultTimeoutStopSec=10s
  '';

  systemd.user.services.writedockerregistryconf = { # https://gitlab.com/gitlab-org/gitlab-runner/-/issues/27171
    script = ''
      rm ${dockerRegistryConfigPath} && echo '{"registry-mirrors": ["http://127.0.01:${toString dockerRegistryPort}"]}' > ${dockerRegistryConfigPath} 
    '';
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
  };
  # services.dockerRegistry = { # So we can cache gitlab runner docker images. https://docs.docker.com/registry/recipes/mirror/
  #   enable = true;
  #   port = dockerRegistryPort;
  #   extraConfig = { proxy.remoteurl = "https://registry-1.docker.io"; };
  # };
  # services.gitlab-runner = {
  #   enable = true;
  #   concurrent = 16;
  #   services = {
  #     docker-images = {
  #       # File should contain at least these two variables:
  #       # `CI_SERVER_URL=xxx`
  #       # `REGISTRATION_TOKEN=xxx`
  #       executor = "docker";
  #       registrationConfigFile = "/run/secrets/gitlab-runner-registration";
  #       dockerImage = "docker:stable";
  #       environmentVariables = { DOCKER_TLS_CERTDIR = ""; }; 
  #       dockerPrivileged = true; # https://gitlab.com/gitlab-org/gitlab-runner/-/issues/1544#note_13439656
  #       dockerVolumes = [
  #         # "/var/run/docker.sock:/var/run/docker.sock" # removed:  https://gitlab.com/gitlab-org/gitlab-runner/-/issues/4260#note_173549548
  #         "${dockerRegistryConfigPath}:/etc/docker/daemon.json" # local file /tmp/daemon.json (contains registry address) gets mapped to /etc/docker/daemon.json in docker which is it's well-known config file location
  #         "/cache"
  #         "/certs/client" # https://gitlab.com/gitlab-org/gitlab-runner/-/issues/4501
  #       ];
  #     };
  #   };
  # };
  fonts.fonts = [
    pragmatapro
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  programs.ssh.startAgent = true; # Using keys in ~/.ssh to eg. authenticate with Github / Bitbucket

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    # package = pkgs.pulseaudioFull;
    extraModules = [];
    # https://www.reddit.com/r/linux/comments/2yqfqp/just_found_that_pulseaudio_have_noise/
    # https://wiki.archlinux.org/index.php/PulseAudio/Troubleshooting#Enable_Echo/Noise-Cancellation
    # pacmd list-sources | grep -e 'index:' -e device.string -e 'name:' 
    # module-echo-cancel makes a new source and sink based on the CURRENT DEFAULT source and sink
    #
    # module-udev-detect:
    # https://wiki.archlinux.org/index.php/PulseAudio/Troubleshooting#Glitches,_skips_or_crackling
    extraConfig = ''
      set-default-source alsa_input.usb-Native_Instruments_Komplete_Audio_1_00007D92-00.analog-stereo
      set-default-sink alsa_output.pci-0000_00_1f.3.analog-stereo
      load-module module-echo-cancel use_master_format=1 aec_method=webrtc aec_args="analog_gain_control=0\ digital_gain_control=1" source_name=echoCancel_source sink_name=echoCancel_sink
      set-default-source echoCancel_source
      set-default-sink echoCancel_sink
      load-module module-udev-detect tsched=0
      unload-module module-suspend-on-idle
    '';
    # extraConfig = ''
    #   set-default-source alsa_input.usb-E-MU_Systems__Inc._E-MU_0404___USB_E-MU-31-3F04-07D9040B-075D6-STATION_02-00.analog-stereo
    #   set-default-sink alsa_output.pci-0000_00_1f.3.analog-stereo
    #   load-module module-echo-cancel use_master_format=1 aec_method=webrtc aec_args="analog_gain_control=0\ digital_gain_control=1" source_name=echoCancel_source sink_name=echoCancel_sink
    #   set-default-source echoCancel_source
    #   set-default-sink echoCancel_sink
    # '';
  };
  nixpkgs.config.pulseaudio = true;

  # keyboardio
  services.udev.extraRules = ''
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="1209", ATTRS{idProduct}=="2300",
    SYMLINK+="model01", ENV{ID_MM_DEVICE_IGNORE}:="1",
    ENV{ID_MM_CANDIDATE}:="0" SUBSYSTEMS=="usb", ATTRS{idVendor}=="1209",
    ATTRS{idProduct}=="2301", SYMLINK+="model01",
    ENV{ID_MM_DEVICE_IGNORE}:="1", ENV{ID_MM_CANDIDATE}:="0"
  '';

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
    extraGroups = [
      "wheel" # Enable ‘sudo’ for the user.
      "dialout" # ao, keyboardio flashing
      "networkmanager"
      "audio"
      "docker"
    ];
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?

}

