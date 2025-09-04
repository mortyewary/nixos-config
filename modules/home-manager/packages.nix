{ config, pkgs, lib, inputs, ... }:

{
  home.packages = with pkgs; [
    # --- Development / CLI tools ---
    unzip git cargo rustc nodejs python3 cmake gnumake nixfmt-classic aria2

    # --- Terminal utilities ---
    tmux btop ncdu fzf ripgrep bat fd jq curl wget ncmpcpp

    # --- Ranger-related ---
    w3m ueberzug highlight atool mediainfo ffmpegthumbnailer imagemagick file exiftool

    # --- Gaming ---
    gamescope gamemode protonup-qt openmw
    heroic     # from nixpkgs-unstable
    mangohud   # from nixpkgs-unstable
    xorg.xeyes          # just for testing XWayland
  

    # --- Communication ---
    vesktop signal-desktop discord-canary

    # --- Extra utilities ---
    inputs.zen-browser.packages."x86_64-linux".twilight
    vscode xfce.xfconf
  ];
}
