# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

# sudo nix-channel --list is different from nix-channel --list !
# update: sudo nixos-rebuild switch --upgrade

{ config, pkgs, lib, ... }:

let
  pragmatapro = import ./pragmatapro.nix {runCommand = pkgs.runCommand;
                                          requireFile = pkgs.requireFile;
                                          unzip = pkgs.unzip;
                                         };
  dockerRegistryPort = 5000;
  dockerRegistryConfigPath = "/tmp/daemon.json";
in
{
  nix = {
    package = pkgs.nixFlakes;
    # keep-outputs + keep-derivations: for nix-direnv
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
    autoOptimiseStore = true;
  };
  # Use the systemd-boot EFI boot loader.
  # boot.loader.systemd-boot.enable = true;
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
192.168.50.30 kl2376.aperigroup.com
# Jacky Maes
10.120.0.20 kl9861.aperigroup.com
192.168.50.17 kl9999.aperigroup.com
# De Vijvers
10.107.4.16 kl0044.aperigroup.com
192.168.50.18 webrtcdemo.aperigroup.com
172.20.4.20 kl0091.aperigroup.com
10.210.0.15 kl0108.aperigroup.com
10.141.0.15 kl2050.aperigroup.com
23.88.107.148 classyprod
159.69.6.177 classyacc
192.168.202.235 showroom
192.168.202.240 showroom_500
94.107.215.44 translations
192.168.50.26 labo
10.131.0.16 flightcase
172.16.100.253 aperiproxy
  '';

 # 10.141.1.127

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  # networking.useDHCP = false;
  # networking.interfaces.br-5f63e8c54cf3.useDHCP = true;
  # networking.interfaces.br-641ea6177424.useDHCP = true;
  # networking.interfaces.br-6a08ed9bc73d.useDHCP = true;
  # networking.interfaces.br-89dd2147bcac.useDHCP = true;
  # networking.interfaces.br-c11bc3afca50.useDHCP = true;
  # networking.interfaces.br-d3743917c436.useDHCP = true;
  # networking.interfaces.br-e30495c9b7e6.useDHCP = true;
  # networking.interfaces.br-f49da29c9eb0.useDHCP = true;
  # networking.interfaces.docker0.useDHCP = true;
  # networking.interfaces.enp0s31f6.useDHCP = true;

  # networking.defaultGateway = "192.168.1.1";
  # networking.nameservers = [ "8.8.8.8" ];
  # networking.interfaces.enp0s31f6.ipv4.addresses = [ {
  #   address = "192.168.1.2";
  #   prefixLength = 24;
  # } ];


  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.plasma
  i18n = {
    defaultLocale = "en_US.UTF-8";
  };
  fonts = {
    fontconfig = {
      defaultFonts = {
        monospace = ["PragmataPro"];
      };
    };
    fonts = [
      pragmatapro
      pkgs.victor-mono
    ];
  };

  # Select internationalisation properties.
  console.useXkbConfig = true;
  # console.packages = [pragmatapro];
  # console.font = "PragmataPro Mono";
  # console.font = "pragmata-pro-0828";
  # console.font = "PragmataPro-Regular0.828";

  # virtualisation.docker.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Brussels";
  programs.adb.enable = true;

  nixpkgs.config.allowUnfree = true; # For Chrome ao.
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget google-chrome firefox git

    ((emacsPackagesFor emacsUnstable).emacsWithPackages (epkgs: [
      epkgs.vterm
    ]))

    # linphone

    htop jq
    du-dust
    # android-studio

    gnumake direnv nix-direnv libnotify
    entr silver-searcher ripgrep
    unzip
    autoconf automake libtool

    vscode
    # blender
    # unityhub
    # omnisharp-roslyn

    gparted

    openvpn

    # pgformatter

    docker
    docker-compose

    # obs-studio
    # jdk8
    # gradle
    # jetbrains.idea-community
    # maven

    neovide

    pragmatapro

    chrysalis

    # zoom-us

    # alacritty

    # nodejs # to get coc-nvim working

    neovim
    gcc # to compile treesitter layouts
    xclip # For neovim clipboard integration
    # luajitPackages.lua-lsp
    # jumpapp # custom neovim "workspaces" solution


    # cockroachdb

    # (perl.withPackages(p: with p; [
    #   RPCEPCService
    #   DBI
    #   DBDPg
    # ])) # edbi -> dbi:Pg:dbname=urwebschool
  ];
  services.lorri.enable = true;
  #services.tlp.enable = true;

  # nix-direnv
  # https://github.com/nix-community/nix-direnv#via-configurationnix-in-nixos
  environment.pathsToLink = [
    "/share/nix-direnv"
  ];
  # nix-direnv support for flakes 
  nixpkgs.overlays = [
    (self: super: { nix-direnv = super.nix-direnv.override { enableFlakes = true; }; } )
  ];

  virtualisation.docker.enable = true;

  # services.mysql = {
  #         enable = true;
  #         package = pkgs.mariadb;
  #       };

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


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  programs.ssh.startAgent = true; # Using keys in ~/.ssh to eg. authenticate with Github / Bitbucket

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    8080
    8010 # VLC chromecast
    8000 # docker testing
    8001 # docker testing
    8002 # docker testing
    8003 # engine testing
    443
    80
  ];
  services.avahi.enable = true; # VLC chromecasting
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  nixpkgs.config.pulseaudio = true;

  environment.variables.BROWSER = "firefox";

  # services.compton.enable = true;
  # services.compton.backend = "xrender";

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Desktop Environment.
   services.xserver.desktopManager.plasma5.enable = true;
   # services.xserver.desktopManager.plasma5.useQtScaling = false;
   services.xserver.displayManager.sddm.enable = true;
   services.xserver.displayManager.autoLogin.user = "simon";
   services.xserver.displayManager.autoLogin.enable = true;
   security.pam.services.sddm.enableKwallet = true;
   services.xserver.libinput.mouse.leftHanded = true;

  # OLD
  # environment.variables.PLASMA_USE_QT_SCALING = "1";
  # services.xserver.desktopManager.xfce.enable = true;
  # services.xserver.desktopManager.lumina.enable = true;
  # services.xserver.displayManager.lightdm.enable = true;
  # security.pam.services.lightdm.enableKwallet = true;


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
      "postgres"
      "audio"
      "docker"
      "adbusers"
    ];
  };


  # Gamepad stuff
  services.udev.extraRules = ''

SUBSYSTEMS=="usb", ATTRS{idVendor}=="1209", ATTRS{idProduct}=="2300", SYMLINK+="model01", ENV{ID_MM_DEVICE_IGNORE}="1", ENV{ID_MM_CANDIDATE}="0", TAG+="uaccess", TAG+="seat"
SUBSYSTEMS=="usb", ATTRS{idVendor}=="1209", ATTRS{idProduct}=="2301", SYMLINK+="model01", ENV{ID_MM_DEVICE_IGNORE}="1", ENV{ID_MM_CANDIDATE}="0", TAG+="uaccess", TAG+="seat"
SUBSYSTEMS=="usb", ATTRS{idVendor}=="1209", ATTRS{idProduct}=="2302", SYMLINK+="Atreus2", ENV{ID_MM_DEVICE_IGNORE}="1", ENV{ID_MM_CANDIDATE}="0", TAG+="uaccess", TAG+="seat"
SUBSYSTEMS=="usb", ATTRS{idVendor}=="1209", ATTRS{idProduct}=="2303", SYMLINK+="Atreus2", ENV{ID_MM_DEVICE_IGNORE}="1", ENV{ID_MM_CANDIDATE}="0", TAG+="uaccess", TAG+="seat"
SUBSYSTEMS=="usb", ATTRS{idVendor}=="3496", ATTRS{idProduct}=="0005", SYMLINK+="model100", ENV{ID_MM_DEVICE_IGNORE}="1", ENV{ID_MM_CANDIDATE}="0", TAG+="uaccess", TAG+="seat"
SUBSYSTEMS=="usb", ATTRS{idVendor}=="3496", ATTRS{idProduct}=="0006", SYMLINK+="model100", ENV{ID_MM_DEVICE_IGNORE}="1", ENV{ID_MM_CANDIDATE}="0", TAG+="uaccess", TAG+="seat"
'';
  #   # https://steamcommunity.com/app/353370/discussions/0/490123197956024380/
  #   # This rule is necessary for gamepad emulation.
  #   KERNEL=="uinput", MODE="0660", GROUP="users", OPTIONS+="static_node=uinput"

  #   # DualShock 4 over USB hidraw
  #   KERNEL=="hidraw*", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="05c4", MODE="0666"

  #   # DualShock 4 wireless adapter over USB hidraw
  #   KERNEL=="hidraw*", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="0ba0", MODE="0666"

  #   # DualShock 4 Slim over USB hidraw
  #   KERNEL=="hidraw*", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="09cc", MODE="0666"

  #   # DualShock 4 over bluetooth hidraw
  #   KERNEL=="hidraw*", KERNELS=="*054C:05C4*", MODE="0666"

  #   # DualShock 4 Slim over bluetooth hidraw
  #   KERNEL=="hidraw*", KERNELS=="*054C:09CC*", MODE="0666"
  # '';


  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  # system.stateVersion = "20.09"; # Did you read the comment?
  system.stateVersion = "22.05"; # Did you read the comment?

}

