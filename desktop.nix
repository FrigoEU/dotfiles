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
