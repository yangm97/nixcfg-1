{ pkgs, ... }:
{
  default = pkgs.mkShell {
    buildInputs = with pkgs; [
      gptfdisk
      nix
      nixos-rebuild
      git
      nixpkgs-fmt
      rnix-lsp
      age
      sops
      (writeScriptBin "lsiommu" ''
        shopt -s nullglob
          for g in $(find /sys/kernel/iommu_groups/* -maxdepth 0 -type d | sort -V); do
          echo "IOMMU Group ''${g##*/}:"
          for d in $g/devices/*; do
            echo -e "\t$(${pciutils}/bin/lspci -nns ''${d##*/})"
          done;
        done;
      '')
      (writeScriptBin "nix2yaml" ''
        echo "# AUTOMATICALLY GENERATED WITH:"
        echo "# nix2yaml $*"
        ${nix}/bin/nix eval --json -f "$@" | ${yq-go}/bin/yq e -P -
      '')
      step-cli
      fup-repl
    ];
  };
}
