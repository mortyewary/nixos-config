{ inputs, pkgs, ... }:

let inherit (import ../nixos/variables.nix) gitUsername gitEmail;
in {
  nixpkgs.config.allowUnfree = true;
  imports = [
    ../modules/home-manager
    inputs.spicetify-nix.homeManagerModules.default
  ];

  home.username = "waylon";
  home.homeDirectory = "/home/waylon";
  home.stateVersion = "25.05";

  programs.git = {
    enable = true;
    userName = gitUsername;
    userEmail = gitEmail;
  };

  programs.spicetify = let
    spicePkgs =
      inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  in {
    enable = true;

    enabledExtensions = with spicePkgs.extensions; [
      adblock
      hidePodcasts
      shuffle # shuffle+ (special characters are sanitized out of extension names)
    ];
    enabledCustomApps = with spicePkgs.apps; [ newReleases ncsVisualizer ];
    enabledSnippets = with spicePkgs.snippets; [ rotatingCoverart pointer ];

    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";
  };
}
