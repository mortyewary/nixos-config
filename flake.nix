{
  description = "Waylon's NixOS-Hyprland Flake Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    openmw-nix = {
      url = "git+https://codeberg.org/PopeRigby/openmw-nix.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    catppuccin.url = "github:catppuccin/nix/release-25.05";
  };

  outputs = { self, nixpkgs, catppuccin, nixpkgs-unstable, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";

      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "i686-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      unstable = nixpkgs-unstable.legacyPackages.${system};
      catppuccin-nix = catppuccin.legacyPackages.${system};

      host = "NixOS-Hyprland";
      username = "waylon";

    in {
      nixosConfigurations.${host} = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit system catppuccin inputs nixpkgs-unstable username host;
        };

        modules = [
          ./nixos/configuration.nix
          (import ./modules/nixos)
          inputs.home-manager.nixosModules.home-manager
        ];
      };

      homeConfigurations."waylon@NixOS-Hyprland" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = {
          inherit inputs self home-manager nixpkgs-unstable unstable catppuccin; 
        };

        modules = [
          ./home-manager/home.nix
          ./modules/home-manager
          ./modules/home-manager/packages.nix
        ];
      };

      packages = forAllSystems (system:
        import ./pkgs nixpkgs.legacyPackages.${system}
      );

      formatter = forAllSystems (system:
        nixpkgs.legacyPackages.${system}.alejandra
      );
    };
}
