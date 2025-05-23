{ config, pkgs, lib, ... }:
{
  networking.hostName = "nixos-desktop"; # Define your hostname.
  services.xserver.xkb.layout = "us";

  boot.loader.grub.enable = true;
  # boot.loader.grub.device = "/dev/nvme0n1";
  boot.loader.grub.devices = [ "nodev" ];
  boot.loader.grub.configurationLimit = 10;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.useOSProber = true;

  networking.networkmanager.enable = true;

  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia.open = false;
  hardware.bluetooth.enable = true;

  # services.plex = {
  #  enable = true;
  #  openFirewall = true;
  #  user = "simon";
  #};

  boot.kernel.sysctl."net.ipv4.ip_forward" = true; # https://nixos.wiki/wiki/Gitlab_runner
  # services.gitlab-runner = {
  #   enable = true;
  #   # settings.concurrent = 16;
  #   services = {
  #     aperi-ci = {
  #       executor = "docker";
  #       # File should contain at least these two variables:
  #       # CI_SERVER_URL=https://gitlab.com
  #       # REGISTRATION_TOKEN=<token>
  #       #
  #       registrationConfigFile = "/run/secrets/gitlab-runner-registration";
  #       dockerImage = "alpine";
  #       dockerDisableCache = true;
  #       dockerPrivileged = true; # https://gitlab.com/gitlab-org/gitlab-runner/-/issues/1544#note_13439656
  #       environmentVariables = {
  #         DOCKER_TLS_CERTDIR = ""; 
  #         USER = "root";
  #       };
  #       dockerVolumes = [
  #         "/var/run/docker.sock:/var/run/docker.sock" # removed:  https://gitlab.com/gitlab-org/gitlab-runner/-/issues/4260#note_173549548 UPDATE: toch terug erbij gestoken na fout "error during connect: Post http://docker:2375/v1.40/auth: dial tcp: lookup docker on 195.130.130.1:53: no such host"
  #         # "${dockerRegistryConfigPath}:/etc/docker/daemon.json" # local file /tmp/daemon.json (contains registry address) gets mapped to /etc/docker/daemon.json in docker which is it's well-known config file location
  #         # "/cache"
  #         # "/certs/client" # https://gitlab.com/gitlab-org/gitlab-runner/-/issues/4501
  #       ];
  #     };
  #   };
  # };

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

    # rtkit is optional but recommended
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  # hardware.pulseaudio = {
  #   enable = true;
  #   # package = pkgs.pulseaudioFull;
  #   extraModules = [];
  #   # https://www.reddit.com/r/linux/comments/2yqfqp/just_found_that_pulseaudio_have_noise/
  #   # https://wiki.archlinux.org/index.php/PulseAudio/Troubleshooting#Enable_Echo/Noise-Cancellation
  #   # pacmd list-sources | grep -e 'index:' -e device.string -e 'name:' 
  #   # module-echo-cancel makes a new source and sink based on the CURRENT DEFAULT source and sink
  #   #
  #   # module-udev-detect:
  #   # https://wiki.archlinux.org/index.php/PulseAudio/Troubleshooting#Glitches,_skips_or_crackling

  #   extraConfig = ''
  #     # set-default-source alsa_input.usb-Native_Instruments_Komplete_Audio_1_00007D92-00.analog-stereo
  #     # set-default-sink alsa_output.pci-0000_00_1f.3.analog-stereo
  #     load-module module-echo-cancel aec_method=webrtc adjust_time=5 aec_args="analog_gain_control=0\ digital_gain_control=1" source_master=alsa_input.usb-Native_Instruments_Komplete_Audio_1_00007D92-00.analog-stereo sink_master=alsa_output.usb-Native_Instruments_Komplete_Audio_1_00007D92-00.analog-stereo source_name=echoCancel_source sink_name=echoCancel_sink
  #     set-default-source echoCancel_source
  #     set-default-sink echoCancel_sink
  #     load-module module-udev-detect tsched=0
  #     unload-module module-suspend-on-idle
  #   '';
  # };
}
