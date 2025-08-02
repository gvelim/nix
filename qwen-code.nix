{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
  fetchNpmDeps,
  nix-update-script,
}:

buildNpmPackage (finalAttrs: {
  pname = "qwen-code";
  version = "unstable-2025-08-02";

  src = fetchFromGitHub {
    owner = "gvelim";
    repo = "qwen-code";
    rev = "a0dbb40dae8c0c80b7f29a106ef08f30dc2a66e2";
    hash = "sha256-XWlEZicUjCpZVRfdgn+i3meZunxL/iWIlSCBYy3baiU=";
  };

  npmDeps = fetchNpmDeps {
    inherit (finalAttrs) src;
    hash = "sha256-VmyDSwbF84sDgDVAdEHbFg+lhav7b1Ww9/3nXLa2e1o=";
  };

  buildPhase = ''
    runHook preBuild

    npm run generate
    npm run bundle

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    # Create a subdirectory for the application files
    mkdir -p $out/lib/qwen-code
    cp -r bundle/* $out/lib/qwen-code/

    # Ensure the shebang is correct
    # substituteInPlace $out/lib/qwen-code/gemini.js --replace '/usr/bin/env node' "$(type -p node)"
    patchShebangs $out/lib/qwen-code

    # Create the bin directory and symlink the executable
    mkdir -p $out/bin
    ln -s $out/lib/qwen-code/gemini.js $out/bin/qwen-code

    runHook postInstall
  '';

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Qwen-code is a coding agent that lives in digital world";
    homepage = "https://github.com/QwenLM/qwen-code";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ gvelim ];
    mainProgram = "qwen-code";
    platforms = lib.platforms.all;
  };
})
