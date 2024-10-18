with import <nixpkgs> {};
derivation {
  system = builtins.currentSystem;
  name = "simple";
  builder = "${bash}/bin/bash";
  args = [ "-c" "echo foo > $out" ];
  src = ./.;
}