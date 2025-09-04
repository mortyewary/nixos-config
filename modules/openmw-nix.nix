{
  inputs = {
    openmw-nix = {
      url = "git+https://codeberg.org/PopeRigby/openmw-nix.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{
    self,
    nixpkgs,
    openmw-nix,
    ...
  }: {
    nixosConfiguration.nixos = nixpkgs.lib.nixosSystem {
      home.packages = with openmw-nix.packages.x86_64-linux; [
        delta-plugin
        openmw-dev
        openmw-validator
        plox
      ];
    };
  };
}
