{
  pkgs ? import <nixpkgs> { },
}:
let
  # fetch Nix expression -> results to a function
  # pass {} parameter since it defaults to nixpkgs -> you get the "Derivation" structure
  nvim-lsp = import (
    builtins.fetchurl {
        url = "https://github.com/nix-community/nixd/raw/refs/heads/main/nixd/docs/editors/nvim-lsp.nix";
    }
  ) {};
in
  pkgs.runCommand "nvim-lsp" {
    # add here the Derivation as a input dependency
    # to the shell creation process
    buildInputs = [
      pkgs.nerdfonts
      pkgs.nixd 
      pkgs.nodejs
      nvim-lsp 
    ];
  } ""
