{ config, pkgs, lib, inputs, ... }:

let
  inherit (import ./variables.nix) userName;
in
{
  imports = [
    ./hardware-configuration.nix
    ./users.nix
    # add other modules here (home-manager, overlays, etc.)
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Timezone & Locale
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

  # Enable sound (PipeWire)
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  hardware.graphics.enable = true;

  # Printing & Scanning
  services.printing.enable = false;
  services.avahi.enable = false;
  hardware.sane.enable = false;

  # Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Virtualization
  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  # Greetd (login manager)
  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        command = "Hyprland";
        user = userName;
      };
      default_session = {
      command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
        user = "greeter";
      };
    };
  };

  # MPD (music daemon)
  services.mpd = {
    enable = true;
    user = userName;
    musicDirectory = "/home/${userName}/Music";
  };

  # Polkit & keyring
  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.gdm-password.enableGnomeKeyring = true;
  services.gvfs.enable = true;

  # System packages
  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    vim
    kitty
    firefox
    home-manager
  ];

  programs.direnv.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable flakes and nix-command
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Default shell
  users.defaultUserShell = pkgs.zsh;

  # System state version (do not change lightly!)
  system.stateVersion = "25.05";
}
