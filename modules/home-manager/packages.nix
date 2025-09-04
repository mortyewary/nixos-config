{ config, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    # Development / CLI tools
    unzip git cargo rustc nodejs python3 cmake gnumake nixfmt-classic aria2

    # Terminal utilities
    kitty ranger tmux btop ncdu fzf ripgrep bat fd fastfetch jq curl wget ncmpcpp

    # Ranger-related
    w3m ueberzug highlight atool mediainfo ffmpegthumbnailer imagemagick file exiftool

    # Wayland / Hyprland tools
    waybar wofi dunst libnotify hyprshot grim slurp grimblast hyprpaper xwayland wl-clipboard

    # Gaming
    steam gamescope gamemode protonup-qt unstable.heroic mangohud

    # Communication
    vesktop signal-desktop discord-canary

    # Extra utilities
    pavucontrol p7zip inputs.zen-browser.packages."x86_64-linux".twilight
    vscode xfce.xfconf
  ];
}
