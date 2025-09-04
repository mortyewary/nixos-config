{ config, pkgs, lib, ... }:

{
  # MPD music server
  services.mpd = {
    enable = true;
    musicDirectory = "/home/waylon/Music";
    user = "waylon";
    extraConfig = ''
      audio_output {
        type "pipewire"
        name "PipeWire"
      }
    '';
  };

  # PipeWire audio
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = false;
  };

  # Greetd login manager
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command =
          "${pkgs.hyprland}/bin/hyprland --config /home/waylon/.config/hypr/hyprland.conf";
      };
    };
  };
}
