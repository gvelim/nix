{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils } : 
    flake-utils.lib.eachDefaultSystem (system :
      let 
        pkgs = nixpkgs.legacyPackages.${system};
        name = "simple";
        src = ./.;
      in {
        packages.default = derivation {
            inherit system name src;
            builder = with pkgs; "${bash}/bin/bash";
            args = [ "-c" "echo foo > $out" ];
          };
      }
    );
}
