{ self, ... }:
{ config, pkgs, lib, ... }:

{
  imports = [
    self.homeModules.git
  ];

  home.stateVersion = "22.11";

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    pkgs.curl
    pkgs.wget
    pkgs.pkg-config
    pkgs.harfbuzz
    pkgs.gnupg
    pkgs.gopass
    pkgs.kubectl
    pkgs.kustomize
    pkgs.terraform
    pkgs.cocoapods
    # pkgs.watchman
  ];

  programs.neovim.enable = true;
  # programs.neovim.defaultEditor = true;

  # zsh
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    defaultKeymap = "vicmd";

    dirHashes = {
      dev = "$HOME/Dev";
      myio = "$HOME/Dev/myio";
      hathor = "$HOME/Dev/hathor";
    };
  };

  programs.bash.enable = true;

  # prezto s2
  programs.zsh.prezto = {
    enable = true;
    pmodules = [
      # Default modules
      "environment"
      "terminal"
      "editor"
      "history"
      "directory"
      "spectrum"
      "utility"
      "completion"
      "prompt"

      # extra
      "history-substring-search"
      "syntax-highlighting"
      "tmux"
    ];
    tmux.autoStartRemote = true;
    tmux.itermIntegration = true;
  };

  # tmux
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = true;
    shortcut = "a";
    keyMode = "vi";
    terminal = "screen-256color";
    extraConfig = ''
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R
    '';
    plugins = with pkgs; [
      tmuxPlugins.sensible
      tmuxPlugins.resurrect
      tmuxPlugins.continuum
    ];
  };

  programs.git = {
    enable = true;
    userEmail = "andre.abadesso@gmail.com";
    userName = "André Abadesso";
    signing.key = "580C90EDA4105A7A";
    signing.signByDefault = true;
  };

  # TODO: export MCFLY_RESULTS=50
  programs.mcfly = {
    enable = true;
    enableFuzzySearch = true;
    enableZshIntegration = true;
  };

  programs.htop = {
    enable = true;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
