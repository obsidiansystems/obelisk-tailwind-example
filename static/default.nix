{ pkgs ? (import ../.obelisk/impl {}).nixpkgs }:
let
  nixpkgs = import ./src/nixpkgs.nix {};

  # The frontend source files have to be passed in so that tailwind's purge option works
  # See https://tailwindcss.com/docs/optimizing-for-production#removing-unused-css
  frontendSrcFiles = ../frontend;

in pkgs.stdenv.mkDerivation {
  name = "static";
  src = ./src;
  buildInputs = [pkgs.nodejs nixpkgs.tailwindcss_4];
  installPhase = ''
    mkdir -p $out/css
    mkdir -p $out/images

    # We make the frontend haskell source files available here:
    # This corresponds to the path specified in tailwind.config.js
    ln -s ${frontendSrcFiles} frontend

    # Run the tailwindcss compiler:
    tailwindcss -i css/styles.css -o $out/styles.css

    # We can write other commands to produce more static files as well:
    cp -r images/* $out/images/
  '';
}
