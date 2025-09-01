# modules/home-manager/git.nix
{
  programs.git = {
    enable = true;
    userName = "waylon";
    userEmail = "waylondn@proton.me";
  };
}
