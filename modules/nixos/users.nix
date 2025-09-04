{ config, pkgs, ... }:

{
  users.defaultUserShell = pkgs.zsh;
  users.users.waylon = {
    isNormalUser = true;
    description = "Waylon Neal";
    extraGroups = [ "docker" "openrazer" "networkmanager" "wheel" ];
    packages = with pkgs; [ ];
  };
}
