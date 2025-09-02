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

  # --- Hardware ---
  hardware.graphics.enable = true;
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  hardware.bluetooth.enable = true;

  # --- Networking ---
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 80 443 ];
  };
  # networking.wireless.enable = true;  # Uncomment if needed
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

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
    extraGroups = [ "docker" "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
      kdePackages.filelight
      # thunderbird
    ];
  };

  # --- Environment ---
  environment.systemPackages = with pkgs; [
    ranger
    btop
    p7zip
    vscode
    git
    gnumake
    cmake
    python3
    nodejs
    go
    rustc
    cargo
    kitty
    docker
    mangohud
    inputs.home-manager.packages.${pkgs.system}.default
    # Add more editors/tools as needed
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
  ];

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    GBM_BACKEND = "nvidia-drm";
  };

  # --- Desktop & UI ---
  programs.hyprland.enable = true;
  programs.thunar.enable = true;
  programs.git.enable = true;
  programs.zsh.enable = true;
  programs.gamescope.enable = true;
  programs.gamemode.enable = true;
  programs.steam.enable = true;
  programs.firefox.enable = false;

  # --- Services ---
  services.printing.enable = true;
  services.flatpak.enable = true;
  services.openssh.enable = true;
  services.blueman.enable = true;
  services.saned.enable = true; # For scanners

  # --- Audio ---
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # jack.enable = true;
    # media-session.enable = true;
  };

  # --- Display Manager ---
  services.greetd.enable = true;
  services.greetd.settings = {
    default_session = {
      command = "Hyprland";
      user = "waylon";
    };
  };

  # --- Portals (Wayland integration) ---
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
    config.common.default = "*";
  };

  # --- Power Management ---
  powerManagement.enable = true;

  # --- System ---
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = false;
  system.stateVersion = "25.05";
}
