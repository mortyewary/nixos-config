{ pkgs, ... }:

let
  inherit (import ./variables.nix) userName;
in
{
  users = {
    mutableUsers = true;
    users.${userName} = {
      homeMode = "755";
      isNormalUser = true;
      description = userName;
      extraGroups = [
        "networkmanager"
        "wheel"
        "libvirtd"
        "scanner"
        "lp"
        "video"
        "input"
        "audio"
        "docker"
        "openrazer"
        "sudo"
      ];

      # User-specific packages
      packages = with pkgs; [
        fastfetch
        fzf
        lsd
        zsh
        zsh-autosuggestions
        zsh-syntax-highlighting
        oh-my-zsh
        krabby
      ];
    };

    defaultUserShell = pkgs.zsh;
  };

  environment.shells = with pkgs; [ zsh ];
  environment.systemPackages = with pkgs; [ lsd fzf ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    ohMyZsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "agnoster";
    };

    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    promptInit = ''
      fastfetch -c ~/.config/fastfetch/config.conf;

      # Pokémon colorscripts (krabby package)
      krabby random --no-mega --no-gmax --no-regional --no-title -s;

      # Pretty ls with lsd
      alias ls='lsd'
      alias l='ls -l'
      alias la='ls -a'
      alias lla='ls -la'
      alias lt='ls --tree'

      source <(fzf --zsh)
      HISTFILE=~/.zsh_history
      HISTSIZE=10000
      SAVEHIST=10000
      setopt appendhistory
    '';
  };
}
