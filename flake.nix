{
  description = "André's system configurations";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/release-22.11";
  inputs.nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

  inputs.darwin.url = "github:lnl7/nix-darwin";
  inputs.darwin.inputs.nixpkgs.follows = "nixpkgs";

  inputs.home-manager.url = "github:nix-community/home-manager/release-22.11";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";

  inputs.flake-utils.url = "github:gytis-ivaskevicius/flake-utils-plus";

  inputs.gitignore.url = github:github/gitignore;
  inputs.gitignore.flake = false;

  inputs.nix-index-database.url = "github:Mic92/nix-index-database";
  inputs.nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

  outputs = { self, flake-utils, ... }@inputs:
    flake-utils.lib.mkFlake {
      inherit self inputs;

      channelsConfig.allowUnfree = true;

      lib = import ./lib inputs;
      homeConfigurations = import ./home-configurations inputs;
      homeModules = import ./home-modules inputs;
      darwinConfigurations = import ./darwin-configurations inputs;
      darwinModules = import ./darwin-modules inputs;
      outputsBuilder = channels:
        let pkgs = channels.nixpkgs-unstable; in
        {
          devShells = import ./dev-shells { inherit pkgs; };
          # packages = import ./packages;
        };
    };
}
