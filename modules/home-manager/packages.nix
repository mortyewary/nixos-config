{ config, pkgs, lib, inputs, ... }:

let
  # Import nixpkgs-unstable for specific packages
  unstable = import inputs.nixpkgs-unstable {
    inherit (pkgs) system;
  };
in
{
  home.packages = with pkgs; [
    # --- Development / CLI tools ---
    unzip git cargo rustc nodejs python3 cmake gnumake nixfmt-classic aria2

    # --- Terminal utilities ---
    kitty ranger tmux btop ncdu fzf ripgrep bat fd fastfetch jq curl wget ncmpcpp

    # --- Ranger-related ---
    w3m ueberzug highlight atool mediainfo ffmpegthumbnailer imagemagick file exiftool

    # --- Wayland / Hyprland tools ---
    wofi dunst libnotify hyprshot grim slurp grimblast hyprpaper wl-clipboard

    # --- Gaming ---
    steam gamescope gamemode protonup-qt openmw
    unstable.heroic     # from nixpkgs-unstable
    unstable.mangohud   # from nixpkgs-unstable
    xorg.xeyes          # just for testing XWayland
  

    # --- Communication ---
    vesktop signal-desktop discord-canary

    # --- Extra utilities ---
    pavucontrol p7zip inputs.zen-browser.packages."x86_64-linux".twilight
    vscode xfce.xfconf
  ];
}
