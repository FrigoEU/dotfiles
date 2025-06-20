# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

# !!!
# Problems rebuilding NixOS (kernel), not enough space in /boot
# Action I took:
# > sudo nix-collect-garbage -d       # Didn't actually do anything
# > dust /boot                        
# # Deleted linux kernel vs 6.6.66, wasn't used anywhere, was from previous attempt but was not cleaned up, use "> uname -r" to get current kernel version
# # Deleted Windows Asian font files, eg: /boot/EFI/Microsoft/Boot/Fonts/kor_boot.ttf
#
# See also: https://discourse.nixos.org/t/no-space-left-on-boot/24019/20

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
    package = pkgs.nixVersions.stable;
    # keep-outputs + keep-derivations: for nix-direnv
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
    settings.auto-optimise-store = true;
  };
  # Use the systemd-boot EFI boot loader.
  boot.loader.efi.canTouchEfiVariables = true;

  # fill in <ifname> via nmcli device (eg: wlp0s20f3)
  # fill in <pw>
  # nmcli connection add con-name "M&S 2.4GHz Bonanza" type wifi ifname <ifname> ipv4.method auto autoconnect yes wifi.ssid "M&S 2.4GHz Bonanza" wifi-sec.psk "<pw>" wifi-sec.key-mgmt "wpa-psk"
  # networking.networkmanager.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.extraHosts =
    ''
23.88.107.148 classyprod
159.69.6.177 classyacc
159.69.6.177 prodtest3.classy.school
  '';
  # 192.168.202.235 showroom
  # 192.168.202.240 showroom_500
  # 94.107.215.44 translations
  # 10.121.0.16 kl0063.aperigroup.com
  # 10.131.0.16 flightcase
  # 172.16.100.253 aperiproxy
  # # Keiheuvel
  # 10.21.16.87 keiheuvel
  # 10.21.16.95 puthof
  # 10.21.16.27 diepenbroeck
  # 10.21.16.97 labo
  # 10.21.16.77 vauban
  # 192.168.50.30 kl2376.aperigroup.com
  # # Jacky Maes
  # 10.120.0.20 kl9861.aperigroup.com
  # 192.168.50.17 kl9999.aperigroup.com
  # # De Vijvers
  # 10.107.4.16 kl0044.aperigroup.com
  # 192.168.50.18 webrtcdemo.aperigroup.com
  # 172.20.4.20 kl0091.aperigroup.com
  # 10.210.0.15 kl0108.aperigroup.com
  # 10.141.0.15 kl2050.aperigroup.com

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
    packages = [
      pragmatapro
      pkgs.victor-mono
      pkgs.commit-mono
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
    wget google-chrome firefox git xarchiver

    ((emacsPackagesFor emacs).emacsWithPackages (epkgs: [
      epkgs.vterm
      # epkgs.treesit-grammars.with-all-grammars
    ]))

    # linphone

    htop jq
    du-dust

    # deluge # torrents
    # mpv # media player
    # android-studio

    gnumake direnv nix-direnv libnotify
    entr silver-searcher ripgrep fd
    unzip
    autoconf automake libtool

    # vscode
    # blender
    # unityhub
    # omnisharp-roslyn

    gparted

    openvpn

    # pgformatter

    # docker
    # docker-compose

    # obs-studio
    # jdk8
    # gradle
    # jetbrains.idea-community
    # maven


    pragmatapro

    # chrysalis

    # zoom-us

    # alacritty

    # nodejs # to get coc-nvim working

    neovim
    neovide
    gcc # to compile treesitter layouts
    xclip # For neovim clipboard integration
    # luajitPackages.lua-lsp
    # jumpapp # custom neovim "workspaces" solution

    libreoffice

    # cockroachdb

    # (perl.withPackages(p: with p; [
    #   RPCEPCService
    #   DBI
    #   DBDPg
    # ])) # edbi -> dbi:Pg:dbname=urwebschool

    # Aider / Aidermacs
    aider-chat
    python312Packages.pip
    python312Packages.google-generativeai
  ];

  environment.extraInit = ''
    if [ -f "$HOME/.secrets" ]; then
      set -a               # Automatically export all variables
      . "$HOME/.secrets"   # Source the file (POSIX-compliant)
      set +a               # Stop automatically exporting
    fi
  '';

  # Add an alias for on-demand sourcing in interactive shells
  environment.interactiveShellInit = ''
    alias loadsecrets='if [ -f "$HOME/.secrets" ]; then set -a && . "$HOME/.secrets" && set +a; else echo "~/.secrets not found" >&2; fi'
  '';

  services.lorri.enable = true;
  #services.tlp.enable = true;

  # nix-direnv
  # https://github.com/nix-community/nix-direnv#via-configurationnix-in-nixos
  # environment.pathsToLink = [
  #   "/share/nix-direnv"
  # ];
  programs.direnv.enable = true;
  virtualisation.docker.enable = true;

  # services.mysql = {
  #         enable = true;
  #         package = pkgs.mariadb;
  #       };

  services.postgresql = {
    package = pkgs.postgresql_15;
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
    # settings = {
    #   log_statement = "all";
    #   logging_collector = true;
    #   log_directory = "pg_log";
    #   max_connections = 300;
    #   shared_buffers = "80MB";
    # };
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
  # services.openssh.enable = true;
  programs.ssh.startAgent = true; # Using keys in ~/.ssh to eg. authenticate with Github / Bitbucket

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    8080 # school testing
    8081 # school testing
    8082 # school testing
    8010 # VLC chromecast
    # 8000 # docker testing
    # 8001 # docker testing
    # 8002 # docker testing
    # 8003 # engine testing
    # 7775 # docker testing
    443
    80
  ];
  # services.avahi.enable = true; # VLC chromecasting
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  nixpkgs.config.pulseaudio = true;

  environment.variables.BROWSER = "firefox";

  # services.compton.enable = true;
  # services.compton.backend = "xrender";

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Desktop Environment.
  # services.xserver.desktopManager.plasma5.enable = true;
  services.desktopManager.plasma6.enable = true;

  # In case you boot into a black screen, add the following option, and rebuild:
  # services.xserver.displayManager.sddm.wayland.enable = true;

  # services.xserver.desktopManager.plasma5.useQtScaling = false;
  services.displayManager.sddm.enable = true;
  services.displayManager.autoLogin.user = "simon";
  services.displayManager.autoLogin.enable = true;
  security.pam.services.sddm.enableKwallet = true;
  services.libinput.mouse.leftHanded = true;

  # OLD
  # environment.variables.PLASMA_USE_QT_SCALING = "1";
  # services.xserver.desktopManager.xfce.enable = true;
  #  services.xserver.desktopManager.lumina.enable = true;
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

