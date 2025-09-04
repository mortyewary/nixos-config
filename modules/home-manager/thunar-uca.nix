{ config, pkgs, lib, ... }:

let
  # Generate a stable unique-id if not given
  genId = action:
    action."unique-id" or (builtins.hashString "sha256" (action.name + action.command));

  # Helper: turn an action attrset into XML
  actionToAttrs = action: {
    action = {
      icon = action.icon or "";
      name = action.name;
      submenu = action.submenu or "";
      "unique-id" = genId action;
      command = action.command;
      description = action.description or "";
      range = action.range or "";
      patterns = action.patterns or "*";
      "startup-notify" = {};
      directories = {};
    };
  };
in {
  options.home.thunarUCA.actions = lib.mkOption {
    type = lib.types.listOf lib.types.attrs;
    default = [];
    description = "List of Thunar custom actions.";
    example = [
      {
        name = "Open Terminal Here";
        icon = "utilities-terminal";
        command = "kitty -d %f";
      }
    ];
  };

  config = lib.mkIf (config.home.thunarUCA.actions != []) {
    home.file.".config/Thunar/uca.xml".text =
      lib.generators.toXML {} {
        actions = map actionToAttrs config.home.thunarUCA.actions;
      };
  };
}
