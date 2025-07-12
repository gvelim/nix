let
  pkgs = import <nixpkgs> {
    config = { };
    overlays = [ ];
  };
in
pkgs.mkShellNoCC {
  packages = with pkgs; [
    nodejs_latest
    starship
    hstr
  ];
  HSTR_CONFIG = "hicolor";
  shellHook = ''
    eval "$(starship init bash)"
    eval "$(hstr --show-bash-configuration)"
    bind '"\C-r": "\C-a hstr -- \C-j"'
    npx https://github.com/google-gemini/gemini-cli
  '';
}
