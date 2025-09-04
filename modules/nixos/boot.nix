{ config, pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_lqx;
  boot.initrd.luks.devices."luks-f1055ba0-2e73-4b72-9e71-f42f2405d5f1".device =
    "/dev/disk/by-uuid/f1055ba0-2e73-4b72-9e71-f42f2405d5f1";
}
