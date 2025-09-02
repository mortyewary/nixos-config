{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [ "git" "z" ];
      theme = "powerlevel10k/powerlevel10k";
    };
    shellAliases = {
      ll = "ls -l";
      la = "ls -la";
    };
  };

  programs.oh-my-posh = {
    enable = true;
    settings = {
      theme = "paradox";
    };
  };

  home.packages = with pkgs; [
    zsh
    oh-my-posh
    (pkgs.zsh-powerlevel10k)
  ];
}