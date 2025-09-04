{ pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;

    # Load JSON configs
    settings = builtins.fromJSON (builtins.readFile ./waybar/config.jsonc);

    # Load CSS, including theme via @import
    style = builtins.readFile ./waybar/style.css;
  };
}
