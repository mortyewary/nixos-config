{ config, pkgs, ... }:

{
  # User-level systemd services
  systemd.user.startServices = "sd-switch";
}
