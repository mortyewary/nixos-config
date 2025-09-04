# modules/nixos/default.nix

{
  imports = [
    ./environment.nix
    ./packages.nix
    ./nvidia-drivers.nix
  ];
}
