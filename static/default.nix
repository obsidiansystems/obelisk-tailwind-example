{ pkgs }:
let
  frontendSrcFiles = ../frontend;
in
  pkgs.stdenv.mkDerivation {
    name = "static";
    src = ./src;
    buildInputs = [pkgs.haskellPackages.tailwind];
    installPhase = ''
      mkdir -p $out/images

      tailwind-run '${frontendSrcFiles}/**/*.hs' --output $out/styles.css

      # We can write other commands to produce more static files as well:
      cp -r images/* $out/images/
    '';
  }
