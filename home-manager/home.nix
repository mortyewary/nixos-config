{ inputs, pkgs, unstable, ... }:

{
  # Import any home-manager or other modules here if needed
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
    ./modules/home-manager/hyprland.nix
    ./modules/home-manager/waybar.nix
  ];

  nixpkgs = {
    overlays = [ ];
    config = { allowUnfree = true; };
  };

  home.username = "waylon";
  home.homeDirectory = "/home/waylon";
  home.stateVersion = "25.05"; # ✅ required

  # --- Development & Gaming tools ---
  home.packages = with pkgs; [
    steam
    protontricks
    nixfmt-classic
    vesktop
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.twilight
    unstable.heroic
    # Hyprland/Wayland tools:
    waybar # Status bar for Wayland
    wofi # App launcher for Wayland
    dunst # Notification daemon
    wl-clipboard # Clipboard utilities
    grim
    slurp # Screenshot tools
    hyprpaper # Wallpaper utility
    xwayland # For legacy X11 apps
    # Add more as needed
  ];

  # --- Shell and productivity ---
  programs.direnv.enable = true;
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch";
    };
    history.size = 10000;
  };

  # --- Spicetify ---
  programs.spicetify = {
    enable = true;
    enabledExtensions =
      with inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system}.extensions; [
        adblock
        hidePodcasts
      ];
    enabledCustomApps =
      with inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system}.apps;
      [ newReleases ];
    theme =
      inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system}.themes.catppuccin;
    colorScheme = "mocha";
  };

  # --- Systemd user services ---
  systemd.user.startServices = "sd-switch";
}
