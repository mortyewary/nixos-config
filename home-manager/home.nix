{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
    # You can import your own or other modules here
    # outputs.homeManagerModules.example
    # inputs.nix-colors.homeManagerModules.default
    # ./nvim.nix
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
      # Example of inline overlay:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];

    config = {
      allowUnfree = true;
    };
  };

  home = {
    username = "waylon";
    homeDirectory = "/home/waylon";
    stateVersion = "25.05";
  };

  home.packages = with pkgs; [
    oh-my-zsh
    oh-my-posh
    inputs.zen-browser.packages.${system}.twilight
    vesktop
    steam
  ];

  programs = {
    # Zsh configuration
    zsh = {
      enable = true;
      enableCompletions = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        ll = "ls -l";
        update = "sudo nixos-rebuild switch";
      };

      history.size = 10000;
    };

    # Spicetify configuration
    spicetify = {
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

    # Git configuration
    git = {
      enable = true;
      userName  = "mortyewary";
      userEmail = "waylondn@proton.me";
    };

    # Home Manager itself
    home-manager.enable = true;
  };

  # Automatically reload systemd user services on config change
  systemd.user.startServices = "sd-switch";
}
