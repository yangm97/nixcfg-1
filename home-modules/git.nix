{ gitignore, ... }:
{ config, pkgs, lib, ... }:

{
  programs.git =
    let
      gi = gitignore.outPath;
      ignores = lib.lists.flatten (
        map
          (x: (lib.strings.splitString "\n"
            (lib.strings.fileContents x)))
          [
            (gi + "/Global/Linux.gitignore")
            (gi + "/Global/macOS.gitignore")
            (gi + "/Global/Emacs.gitignore")
            (gi + "/Global/Vim.gitignore")
          ]);
    in
    {
      inherit ignores;
      enable = true;
      lfs.enable = true;
      extraConfig = {
        init = {
          defaultBranch = "master";
        };
      };
    };
}
