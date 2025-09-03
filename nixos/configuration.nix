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

  # --- GPU (NVIDIA) ---
  # Enable OpenGL
  hardware.graphics = { enable = true; };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {

    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    open = false;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # --- OpenRazer ---
  hardware.openrazer.enable = true;

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
    extraGroups = [ "docker" "openrazer" "networkmanager" "wheel" ];
    packages = with pkgs;
      [
        # thunderbird
      ];
  };

  # --- Environment ---
  environment.systemPackages = with pkgs; [
    openrazer-daemon
    ncmpcpp
    ranger
    btop
    p7zip
    fastfetch
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
    pavucontrol
    mangohud
    inputs.home-manager.packages.${pkgs.system}.default
    # Add more editors/tools as needed
  ];

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      fira-code
      nerd-fonts.fira-code
    ];
    fontconfig = {
      defaultFonts = {
        serif = [ "Noto Serif" "Noto Color Emoji" ];
        sansSerif = [ "Noto Sans" "Noto Color Emoji" ];
        monospace = [ "FiraCode Nerd Font" "Noto Color Emoji" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };

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

  # --- mpd ---
  services.mpd = {
    enable = true;
    musicDirectory = "/home/waylon/Music"; # don’t use $HOME, expand it
    user = "waylon";
    extraConfig = ''
      audio_output {
        type "pipewire"
        name "Pipewire"
      }
      # must specify one or more outputs in order to play audio!
      # (e.g. ALSA, PulseAudio, PipeWire), see next sections
    '';
  };

  # --- System ---
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = false;
  system.stateVersion = "25.05";
}
