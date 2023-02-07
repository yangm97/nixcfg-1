# name: machineFile: { inputs, overlays, system }:
name: machineFile: { inputs, system, overlays ? null }:

let
  # inherit (inputs) self agenix home-manager nixpkgs nixos-wsl;
  inherit (inputs) self nixpkgs home-manager impermanence sops-nix;

in
nixpkgs.lib.nixosSystem {
  inherit system;
  modules = [
    home-manager.nixosModules.home-manager
    impermanence.nixosModule
    sops-nix.nixosModules.sops
    self.nixosModules.system
    # self.nixosModules.machine
    # self.nixosModules.common
    (import machineFile inputs)
    {
      # Hostname
      networking.hostName = name;

      # Let 'nixos-version --json' know about the Git revision
      # of this flake.
      system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;

      # Nix + nixpkgs
      nix.registry.nixpkgs.flake = nixpkgs; # Pin flake nixpkgs
      # nixpkgs.overlays = overlays;
    }
  ];
}
