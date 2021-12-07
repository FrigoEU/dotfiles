{ config, pkgs, lib, ... }:
let 
  nixpkgsUnstable20211004 = import ( builtins.fetchTarball { # for newer gitlab-runner
    name = "nixpkgs-unstable-20211004";
    url = https://github.com/NixOS/nixpkgs/archive/573317418695d7d634e7d3f652bf9db3b3897589.tar.gz;
  }) {};
  specifics = 
    { config, lib, pkgs, ... }:
    {
      networking.hostName = "nixos-desktop"; # Define your hostname.
      nixpkgs.config.allowUnfree = true;
      services.xserver.layout = "us";
      services.xserver.videoDrivers = [ "amdgpu" ];


      services.gitlab-runner = {
        enable = true;
        concurrent = 16;
        package = nixpkgsUnstable20211004.gitlab-runner;
        services = {
          aperi-ci = {
            # File should contain at least these two variables:
            # `CI_SERVER_URL=xxx`
            # `REGISTRATION_TOKEN=xxx`
            executor = "docker";
            registrationConfigFile = "/run/secrets/gitlab-runner-registration";
            dockerImage = "docker:stable";
            environmentVariables = { DOCKER_TLS_CERTDIR = ""; }; 
            dockerPrivileged = true; # https://gitlab.com/gitlab-org/gitlab-runner/-/issues/1544#note_13439656
            dockerVolumes = [
              # "/var/run/docker.sock:/var/run/docker.sock" # removed:  https://gitlab.com/gitlab-org/gitlab-runner/-/issues/4260#note_173549548
              # "${dockerRegistryConfigPath}:/etc/docker/daemon.json" # local file /tmp/daemon.json (contains registry address) gets mapped to /etc/docker/daemon.json in docker which is it's well-known config file location
              "/cache"
              "/certs/client" # https://gitlab.com/gitlab-org/gitlab-runner/-/issues/4501
            ];
          };
        };
      };

      # systemd.user.services.writedockerregistryconf = { # https://gitlab.com/gitlab-org/gitlab-runner/-/issues/27171
      #   script = ''
      #     rm ${dockerRegistryConfigPath} && echo '{"registry-mirrors": ["http://127.0.01:${toString dockerRegistryPort}"]}' > ${dockerRegistryConfigPath} 
      #   '';
      #   wantedBy = [ "graphical-session.target" ];
      #   partOf = [ "graphical-session.target" ];
      # };
      # services.dockerRegistry = { # So we can cache gitlab runner docker images. https://docs.docker.com/registry/recipes/mirror/
      #   enable = true;
      #   port = dockerRegistryPort;
      #   extraConfig = { proxy.remoteurl = "https://registry-1.docker.io"; };
      # };

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
      # set-default-source alsa_input.usb-Native_Instruments_Komplete_Audio_1_00007D92-00.analog-stereo
      # set-default-sink alsa_output.pci-0000_00_1f.3.analog-stereo
      load-module module-echo-cancel aec_method=webrtc adjust_time=5 aec_args="analog_gain_control=0\ digital_gain_control=1" source_master=alsa_input.usb-Native_Instruments_Komplete_Audio_1_00007D92-00.analog-stereo sink_master=alsa_output.usb-Native_Instruments_Komplete_Audio_1_00007D92-00.analog-stereo source_name=echoCancel_source sink_name=echoCancel_sink
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
      system.stateVersion = "21.05"; # Did you read the comment?
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
