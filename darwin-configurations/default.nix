{ darwin, ... }@inputs:

rec {
  andrembp = darwin.lib.darwinSystem {
    system = "aarch64-darwin";
    modules = [ (import ./andrembp inputs) ];
  };
}
