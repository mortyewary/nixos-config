{ inputs, pkgs, ... }:

{
  # Import any home-manager or other modules here if needed
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
    # You can add more imports here if you want
  ];

  nixpkgs = {
    overlays = [
      # Add overlays if you have any, for example:
      # ./overlays/additions.nix
      # outputs.overlays.additions
    ];

    config = {
      allowUnfree = true;
    };
  };

  home.username = "waylon";
  home.homeDirectory = "/home/waylon";
  home.stateVersion = "25.05";  # ✅ required

    home.packages = with pkgs; [
      oh-my-zsh
      oh-my-posh
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.twilight
      vesktop
      steam
    ];

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


    systemd.user.startServices =  "sd-switch" ;
  }
