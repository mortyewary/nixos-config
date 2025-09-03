{ config, lib, ... }:

let
  inherit (lib) mkOption types;
in {
  options.colorScheme = mkOption {
    type = types.attrsOf (types.attrsOf types.str);
    default = {
      colors = {
        base00 = "1a1b26";
        base01 = "1f2335";
        base02 = "2f3549";
        base03 = "414868";
        base04 = "565f89";
        base05 = "a9b1d6";
        base06 = "c0caf5";
        base07 = "f4f4f5";
        base08 = "f7768e";
        base09 = "ff9e64";
        base0A = "e0af68";
        base0B = "9ece6a";
        base0C = "2ac3de";
        base0D = "7aa2f7";
        base0E = "bb9af7";
        base0F = "c0caf5";
      };
    };
    description = "Custom color scheme used for theming.";
  };
}
