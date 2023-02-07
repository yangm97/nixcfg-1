{ pkgs, ... }:
{
  default = pkgs.mkShell {
    buildInputs = with pkgs; [
      nix
      nixos-rebuild
      git
      nixpkgs-fmt
      rnix-lsp
      fup-repl
    ];
  };
}
