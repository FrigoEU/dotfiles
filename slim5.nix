{ config, lib, pkgs, ... }:
{
  boot.loader.systemd-boot.enable = true;

  networking.hostName = "nixos-slim5"; # Define your hostname.
  services.xserver.layout = "be";
  services.xserver.xkbOptions = "caps:swapescape";

  networking.networkmanager.enable = true;
  # programs.nm-applet.enable = true;

  # networking.interfaces.enp0s31f6.useDHCP = true;
  # networking.interfaces.wlp0s20f3.useDHCP = true;
  # security.rtkit.enable = true;
# services.pipewire = {
# enable = true;
# alsa.enable= true;
# alsa.support32Bit = true;
# pulse.enable = true;
# };

  

  # Bluetooth support:
  # * bluetooth is heel goeie audio met A2DP, maar dan kan je niet babbelen
  # * HSP/HFP is om ook te kunnen babbelen, maar dan is de kwaliteit echt slecht
  #
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
    extraModules = [ ];
  };
  hardware.bluetooth.enable = true;
  # hardware.bluetooth.settings = {
  #   General = {
  #     Enable = "Source,Sink,Media,Socket";
  #   };
  # };

  # services.gitlab-runner = {
  #   enable = true;
  #   # settings.concurrent = 16;
  #   services = {
  #     aperi-ci = {
  #       executor = "docker";
  #       # File should contain at least these two variables:
  #       # CI_SERVER_URL=https://gitlab.com
  #       # REGISTRATION_TOKEN=GR1348941RQ673odSZkfXu-y2eRBy
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
}
