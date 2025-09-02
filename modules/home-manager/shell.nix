{ config, pkgs, ... }:

{
  # Zsh setup
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    shellAliases = {
      ll = "ls -l";
      la = "ls -la";
      gs = "git status";
      v = "nvim";
    };

    initContent = ''
      # Load zsh-autosuggestions
      eval "$(direnv hook zsh)"
    '';
  };

  # Starship prompt
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[❯](bold red)";
      };
    };
  };

  # Direnv for environment management
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # Fuzzy finder
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  # Packages
  home.packages = with pkgs; [
    zsh
    zsh-autosuggestions
    zsh-syntax-highlighting
    starship
    direnv
    fzf
  ];
}
