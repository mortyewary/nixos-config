{ config, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    openrazer-daemon
    docker
    inputs.home-manager.packages.${pkgs.system}.default
  ];
}
