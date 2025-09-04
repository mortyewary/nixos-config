{
  description = "Waylon's NixOS-Hyprland Flake Configuration";

  inputs = {
    # Nixpkgs
    #nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home Manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Custom packages
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    openmw-nix = {
      url = "git+https://codeberg.org/PopeRigby/openmw-nix.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

  };

  outputs = { self, nixpkgs, spicetify-nix, openmw-nix
    , home-manager, ... }@inputs:
    let
      systems = [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      host = "NixOS-Hyprland";
      username = "waylon";
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };

      forAllSystems = nixpkgs.lib.genAttrs systems;
    in {
      # Custom packages per system
      packages =
        forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});

      # Formatter for Nix files
      formatter =
        forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

      # Overlays
      overlays = import ./overlays { inherit inputs; };

      # NixOS modules
      nixosModules = import ./modules/nixos;

      # Home Manager modules
      homeManagerModules = import ./modules/home-manager;

      # NixOS configuration entrypoint
      nixosConfigurations = {
        "${host}" = nixpkgs.lib.nixosSystem rec {

          specialArgs = {
            inherit system inputs username host;
          };

          modules = [
            ./nixos/configuration.nix
            (import ./modules/nixos) # import all NixOS modules in one line
          ];
        };
      };

      # Home Manager configuration entrypoint
      homeConfigurations = {
        "${username}@${host}" = home-manager.lib.homeManagerConfiguration {
          pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;

          extraSpecialArgs = {
            inherit inputs self home-manager username;
          };

          modules = [
            ./home-manager/home.nix
            ./modules/home-manager # other HM modules
          ];
        };
      };
    };
}
