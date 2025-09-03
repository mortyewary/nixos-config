# NixOS system configuration for Waylon Neal
{ config, pkgs, inputs, unstable, ... }:

{
  # --- Imports ---
  imports = [ ./hardware-configuration.nix ];

  # --- Boot & Kernel ---
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_lqx;
  boot.initrd.luks.devices."luks-f1055ba0-2e73-4b72-9e71-f42f2405d5f1".device =
    "/dev/disk/by-uuid/f1055ba0-2e73-4b72-9e71-f42f2405d5f1";

  # --- GPU / NVIDIA ---
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # --- OpenRazer ---
  hardware.openrazer.enable = true;

  # --- Networking ---
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 80 443 ];

  # --- Locale & Time ---
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # --- User ---
  users.defaultUserShell = pkgs.zsh;
  users.users.waylon = {
    isNormalUser = true;
    description = "Waylon Neal";
    extraGroups = [ "docker" "openrazer" "networkmanager" "wheel" ];
    packages = with pkgs;
      [
        # User-level apps can go here or in home.nix
        # thunderbird
      ];
  };

  # --- System Packages ---
  environment.systemPackages = with pkgs; [
    # Essential system utilities
    openrazer-daemon # OpenRazer hardware daemon
    docker # Docker daemon
    inputs.home-manager.packages.${pkgs.system}.default # Home Manager packages
    # Note: ranger, git, vscode, and nodejs moved to Home Manager
  ];

  # --- Fonts ---
  fonts.enableDefaultPackages = true;
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    fira-code
    nerd-fonts.fira-code
  ];
  fonts.fontconfig.defaultFonts = {
    serif = [ "Noto Serif" "Noto Color Emoji" ];
    sansSerif = [ "Noto Sans" "Noto Color Emoji" ];
    monospace = [ "FiraCode Nerd Font" "Noto Color Emoji" ];
    emoji = [ "Noto Color Emoji" ];
  };

  # --- Environment Variables for Wayland / NVIDIA ---
  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    LIBVA_DRIVER_NAME = "nvidia";
    WLR_EGL_STREAMS = "1";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    GDK_BACKEND = "wayland";
  };

  # --- Desktop & UI ---
  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;
  programs.zsh.enable = true;
  programs.firefox.enable = false;

  # --- Services ---
  services.printing.enable = true;
  services.flatpak.enable = true;
  services.openssh.enable = true;
  services.blueman.enable = true;
  services.saned.enable = true; # Scanner support

  # --- Music Player Daemon (MPD) ---
  services.mpd = {
    enable = true;
    musicDirectory = "/path/to/music";
    extraConfig = ''
      # must specify one or more outputs in order to play audio!
      # (e.g. ALSA, PulseAudio, PipeWire), see next sections
    '';
  };

  # --- Audio ---
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # --- Display Manager ---
  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        command = "${pkgs.hyprland}/bin/hyprland";
        user = "waylon";
      };
      default_session = {
        command = "tuigreet --time --cmd ${pkgs.hyprland}/bin/hyprland";
        user = "waylon";
      };
    };
  };

  # --- Portals (Wayland integration) ---
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
    config.common.default = "*";
  };

  # --- Power Management ---
  powerManagement.enable = false;

  # --- Nix / System ---
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = false;
  system.stateVersion = "25.05";
}
