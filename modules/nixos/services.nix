{ config, pkgs, lib, ... }:

{
  # --- Keyring / Polkit ---
  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;

  # --- PipeWire ---
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = false;
  };

  # --- MPD ---
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

  # --- Greetd ---
  services.greetd = {
    enable = true;
    settings = {
      # Auto login directly to Hyprland
      initial_session = {
        command = "${pkgs.hyprland}/bin/hyprland --config /home/waylon/.config/hypr/hyprland.conf";
        user = "waylon";
      };

      # If you log out, greetd falls back to a greeter
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --remember --cmd Hyprland";
      };
    };
  };
}
