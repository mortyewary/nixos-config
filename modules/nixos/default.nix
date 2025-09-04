# modules/nixos/default.nix

{
  imports = [
    ./audio.nix
    ./environment.nix
    ./packages.nix
    ./services.nix
    ./nvidia-drivers.nix
  ];
}
