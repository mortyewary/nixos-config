{ config, pkgs, lib, ... }:

let
  cfg = config.home.file."/home/waylon/.config/Thunar/uca.xml";
in
{
  options.home.thunarUCA = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable installation of a custom Thunar uca.xml file per-user.";
    };
  };

  config = lib.mkIf (config.home.thunarUCA.enable) {
    home.file."/home/waylon/.config/Thunar/uca.xml".text = ''
      <?xml version="1.0" encoding="UTF-8"?>
      <actions>clear
      <action>
        <icon>utilities-terminal</icon>
        <name>Open Terminal Here</name>
        <submenu></submenu>
        <unique-id>1756789989517654-1</unique-id>
        <command>kitty -d %f</command>
        <description>Example for a custom action</description>
        <range></range>
        <patterns>*</patterns>
        <startup-notify/>
        <directories/>
      </action>
      </actions>
    '';
  };
}
