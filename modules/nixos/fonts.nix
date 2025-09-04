{ config, pkgs, ... }:

{
  fonts.enableDefaultPackages = true;
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    fira-code
    nerd-fonts.fira-code
  ];
  fonts.fontconfig.defaultFonts = {
    serif = [ "Noto Serif" "Noto Color Emoji" ];
    sansSerif = [ "Noto Sans" "Noto Color Emoji" ];
    monospace = [ "FiraCode Nerd Font" "Noto Color Emoji" ];
    emoji = [ "Noto Color Emoji" ];
  };
}
