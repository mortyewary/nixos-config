{ inputs, pkgs, unstable, ... }:

{
  # Import any home-manager or other modules here if needed
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];

  nixpkgs = {
    overlays = [ ];
    config = {
      allowUnfree = true;
    };
  };

  home.username = "waylon";
  home.homeDirectory = "/home/waylon";
  home.stateVersion = "25.05";  # ✅ required

  # Set your login shell here
  home.shell = pkgs.zsh;

  home.packages = with pkgs; [
    
    # packages
    vscode
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.twilight
    vesktop
    steam
    protontricks

    # unstable packages
    unstable.heroic
  ];

  # enable useful programs for home-manager config
  programs.direnv.enable = true;

  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch";
    };

    history.size = 10000;
  };

  programs.spicetify = {
    enable = true;

    enabledExtensions = with inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system}.extensions; [
      adblock
      hidePodcasts
    ];

    enabledCustomApps = with inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system}.apps; [
      newReleases
    ];

    theme = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system}.themes.catppuccin;
    colorScheme = "mocha";
  };

  systemd.user.startServices = "sd-switch";
}
