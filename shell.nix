{ pkgs ? import <nixpkgs> { }
}:
let
  # fetch Nix expression -> results to a function
  # pass {} parameter since it defaults to nixpkgs -> you get the "Derivation" structure
  nvim-lsp = pkgs.callPackage
    (builtins.fetchurl {
      url = "https://github.com/nix-community/nixd/raw/refs/heads/main/nixd/docs/editors/nvim-lsp.nix";
    })
    { };
  qwen-code = pkgs.callPackage ./qwen-code.nix { };
in
pkgs.mkShell {
  # add here the Derivation as a input dependency
  # to the shell creation process
  buildInputs =
    with pkgs;
    [
      nixd
      nixpkgs-fmt
      nil
      nodejs
    ]
    ++ [
      nvim-lsp
      qwen-code
    ];
}
