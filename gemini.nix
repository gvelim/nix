# This file can be imported by your flake.nix, which passes in `pkgs`.
# For standalone use, the following `let` block works.
let
  pkgs = import <nixpkgs> {
    config = { };
    # 1. Define gemini-cli as a package using an overlay
    overlays = [
      (final: prev: {
        gemini-cli = final.buildNpmPackage {
          pname = "gemini-cli";
          version = "0.4.0"; # Latest version as of now

          src = final.fetchFromGitHub {
            owner = "google-gemini";
            repo = "gemini-cli";
            rev = "v0.1.12";
            # Nix will tell you the correct hash.
            # Replace this placeholder with the hash from the error message.
            hash = "sha256-svX/oN05yBazMoXyDs/n1KW7kfxzdy495bMIf7qNMS0=";
          };

          # This hash also needs to be filled in based on the error message
          # from the first build attempt.
          npmDepsHash = "sha256-EVZ8A1dwVg5JYm+PncPUc9xayJov0KRCklH4wqNW3Tw=";

          # The `gemini-cli` needs tsc, which is a dev dependency.
          # We need to ensure it's available during the build.
          nativeBuildInputs = [ final.nodejs ];

          # Let npm run its default build steps.
          npmBuild = "npm run build";

          meta = with final.lib; {
            description = "Google Gemini CLI";
            homepage = "https://github.com/google-gemini/gemini-cli";
            license = licenses.asl20;
          };
        };
      })
    ];
  };
in
pkgs.mkShellNoCC {
  # 2. Add your new package to the list
  packages = with pkgs; [
    nodejs_20 # 3. Pinned Node.js version
    starship
    hstr
    gemini-cli # The CLI is now a first-class package
  ];

  GEMINI_API_KEY = builtins.getEnv "GEMINI_API_KEY";
  HSTR_CONFIG = "hicolor";

  shellHook = ''
    eval "$(starship init bash)"
    eval "$(hstr --show-bash-configuration)"
    bind '"\C-r": "\C-a hstr -- \C-j"'
    # 4. The npx call is no longer needed.
    # The `gemini` command is now directly available in your PATH.
  '';
}
