{ config, pkgs, lib, ... }:
{
  imports = [ ./classy.nix ];

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
  # Save VRAM across suspend (nvidia-suspend/resume services). Without this,
  # KWin crashes on resume from deep sleep and takes every app down with it.
  hardware.nvidia.powerManagement.enable = true;
  hardware.bluetooth.enable = true;

  # Suspend (deep/S3) after 30 min idle. Background jobs block this with a
  # sleep inhibitor, see classy.nix.
  home-manager.users.simon.programs.plasma.powerdevil.AC.autoSuspend = {
    action = "sleep";
    idleTimeout = 1800;
  };

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

  # The Komplete Audio 1's own ALSA hardware "Playback Volume" control is
  # separate from PipeWire's software volume and defaults to ~-35dB on Linux
  # (Windows' driver sets it near 0dB), making output very quiet even at
  # 100% system volume. Force it to max whenever the interface is plugged in.
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="sound", KERNEL=="controlC*", ATTRS{idVendor}=="17cc", ATTRS{idProduct}=="1830", RUN+="${pkgs.bash}/bin/bash -c '${pkgs.alsa-utils}/bin/amixer -c K1 sset \"Komplete Audio 1 \" 127,127'"
  '';

  # The Komplete Audio 1 (bus-powered, on the xHCI controller 0000:10:00.4,
  # which has nothing else on it) sometimes doesn't come back after a cold
  # boot or a resume from deep suspend: the port never even sees a connect.
  # If it's missing, power-cycle its port, then fall back to rebinding the
  # whole controller, which is what re-plugging does by hand.
  systemd.services.komplete-audio-revive = {
    description = "Re-enumerate Komplete Audio 1 if it went missing";
    wantedBy = [ "multi-user.target" "suspend.target" ];
    after = [ "multi-user.target" "suspend.target" ];
    serviceConfig.Type = "oneshot";
    path = [ pkgs.coreutils pkgs.gnugrep ];
    script = ''
      present() { grep -qx 17cc /sys/bus/usb/devices/*/idVendor 2>/dev/null; }
      sleep 5
      present && exit 0
      echo "Komplete Audio 1 missing, power-cycling usb5-port2"
      port=/sys/bus/usb/devices/5-0:1.0/usb5-port2/disable
      if [ -e $port ]; then
        echo 1 > $port; sleep 2; echo 0 > $port; sleep 5
        present && { echo "back after port power-cycle"; exit 0; }
      fi
      echo "still missing, rebinding xHCI controller 0000:10:00.4"
      echo 0000:10:00.4 > /sys/bus/pci/drivers/xhci_hcd/unbind
      sleep 2
      echo 0000:10:00.4 > /sys/bus/pci/drivers/xhci_hcd/bind
      sleep 5
      present && echo "back after controller rebind" || echo "still missing, re-plug by hand"
    '';
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
