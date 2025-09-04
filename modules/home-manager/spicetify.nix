{ config, pkgs, inputs, ... }:

{
  programs.spicetify = {
    enable = true;
    enabledExtensions =
      with inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system}.extensions; [
        adblock hidePodcasts
      ];
    enabledCustomApps =
      with inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system}.apps; [
        newReleases
      ];
    theme =
      inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system}.themes.catppuccin;
    colorScheme = "mocha";
  };
}
