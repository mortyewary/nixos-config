{ config, pkgs, lib, ... }:

let
  # Generate a stable unique-id if not given
  genId = action:
    action."unique-id" or (builtins.substring 0 16 (builtins.hashString "sha256" (action.name + action.command)));

  # Convert one action to XML
  actionToXml = action: ''
    <action>
      <icon>${action.icon or ""}</icon>
      <name>${action.name}</name>
      <submenu>${action.submenu or ""}</submenu>
      <unique-id>${genId action}</unique-id>
      <command>${action.command}</command>
      <description>${action.description or ""}</description>
      <range>${action.range or ""}</range>
      <patterns>${action.patterns or "*"}</patterns>
      <startup-notify/>
      <directories/>
    </action>
  '';

  # Join all actions
  xmlContent = actions: ''
    <?xml version="1.0" encoding="UTF-8"?>
    <actions>
    ${lib.concatStringsSep "\n" (map actionToXml actions)}
    </actions>
  '';
in {
  options.home.thunarUCA.actions = lib.mkOption {
    type = lib.types.listOf lib.types.attrs;
    default = [];
    description = "List of Thunar custom actions.";
  };

  config = lib.mkIf (config.home.thunarUCA.actions != []) {
    home.file.".config/Thunar/uca.xml".text = xmlContent config.home.thunarUCA.actions;
  };
}
