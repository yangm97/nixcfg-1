{self, home-manager, ...}:
{ config, pkgs, ... }:

{
  imports = [
    home-manager.darwinModules.home-manager
    self.darwinModules.users.andrecardoso
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
    # users.defaultUserShell = pkgs.zsh;
    programs.zsh.enable = true;

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
