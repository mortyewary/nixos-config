{
  imports = [
    ./thunar-uca.nix
  ];

  home.thunarUCA.actions = [
    {
      name = "Open Terminal Here";
      icon = "utilities-terminal";
      command = "kitty -d %f";
    }
    {
      name = "Open with VSCode";
      icon = "code";
      command = "code %f";
    }
  ];
}
