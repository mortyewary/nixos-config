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
      environment.systemPackages = with openmw-nix.packages.waylon; [
        delta-plugin
        openmw-dev
        openmw-validator
        umo
        momw-configurator
        s3lightfixes
        groundcoverify
        plox
      ];
    };
  };
}