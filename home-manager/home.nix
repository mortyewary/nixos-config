{ inputs, pkgs, unstable, ... }:

{
  # Import any required Home Manager modules (like spicetify)
  imports = [ inputs.spicetify-nix.homeManagerModules.default ];

  # Allow unfree packages
  nixpkgs = {
    overlays = [ ];
    config = { allowUnfree = true; };
  };

  # --- User configuration ---
  home.username = "waylon";
  home.homeDirectory = "/home/waylon";
  home.stateVersion = "25.05"; # ✅ Required by Home Manager

  # --- Packages ---
  home.packages = with pkgs; [

    # --- Development / CLI tools ---
    unzip # Unzip utility
    git # Version control
    cargo # Rust package manager
    rustc # Rust compiler
    nodejs # JavaScript runtime
    python3 # Python interpreter
    cmake # Build system generator
    gnumake # Build tool
    nixfmt-classic # Formatter for Nix expressions
    aria2 # Download utility

    # --- Terminal utilities ---
    kitty # Terminal emulator
    ranger # Terminal file manager
    tmux # Terminal multiplexer
    btop # System monitor
    ncdu # Disk usage analyzer
    fzf # Fuzzy finder
    ripgrep # Fast search
    bat # Colorized cat replacement
    fd # Fast file search
    fastfetch # System info
    jq # JSON processor
    curl # HTTP client
    wget # Download files
    ncmpcpp # Music player client for MPD

    # --- Ranger-specific / CLI utilities for previews and file handling ---
    w3m # Text-based web browser, also used to display images in terminal (for ranger image previews)
    ueberzug # Provides inline image previews in ranger and other terminal apps
    highlight # Syntax highlighting for code files in terminal previews
    atool # Archive utility, allows ranger to preview/extract various archive formats
    mediainfo # Shows detailed media information for audio/video files
    ffmpegthumbnailer # Generates video thumbnails for previews in ranger
    imagemagick # Image manipulation & thumbnail generation, used by ranger for previews
    file # Detects file type, essential for ranger’s file preview functionality
    exiftool # Reads/writes image metadata, useful for photographers and media management

    # --- Hyprland / Wayland tools ---
    waybar # Status bar for Wayland; displays modules like battery, network, CPU, date/time
    wofi # Application launcher for Wayland (similar to Rofi on X11)
    dunst # Lightweight notification daemon for desktop notifications
    libnotify # Library used by dunst and other apps to show notifications
    hyprshot # Screenshot tool integrated with Hyprland/Wayland
    grim # Wayland screenshot utility
    slurp # Select regions of the screen for screenshots (used with grim/hyprshot)
    grimblast # Advanced screenshot tool for Wayland with extra features
    hyprpaper # Wallpaper utility for Hyprland
    xwayland # X11 compatibility layer for running legacy X11 applications under Wayland
    wl-clipboard # Command-line clipboard utilities for Wayland (copy/paste between apps)

    # --- Gaming tools ---
    steam # Game distribution platform
    gamescope # Run games with scaling/capture
    gamemode # Optimize system while gaming
    protonup-qt # ProtonUp-Qt for managing Wine/Proton versions
    unstable.heroic # Heroic Games Launcher
    mangohud            # Performance overlay for games

    # --- Communication ---
    vesktop # Desktop client for Discord
    signal-desktop # Desktop client for Signal
    discord-canary # Unstable Discord client with latest features

    # --- Extra Utilities/GUI Utilities ---
    pavucontrol         # Audio control GUI
    p7zip               # Compression tool
    inputs.zen-browser.packages."x86_64-linux".twilight
    vscode # Code editor
  ];

  # --- Shell and productivity ---
  programs.direnv.enable = true; # Auto-load environment variables per directory
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true; # Colorful syntax highlighting
    shellAliases = {
      ll = "ls -l"; # Quick long-listing
      update = "sudo nixos-rebuild switch"; # Quick system update
    };
    history.size = 10000; # Increase Zsh history size
  };

  # --- Spicetify (Spotify customization) ---
  programs.spicetify = {
    enable = true;
    enabledExtensions =
      with inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system}.extensions; [
        adblock # Remove ads in Spotify
        hidePodcasts # Hide podcasts in UI
      ];
    enabledCustomApps =
      with inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system}.apps;
      [
        newReleases # Show new releases
      ];
    theme =
      inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system}.themes.catppuccin; # Catppuccin theme
    colorScheme = "mocha"; # Variant of the theme
  };

  # --- Systemd user services ---
  systemd.user.startServices = "sd-switch"; # Start custom user services
}
