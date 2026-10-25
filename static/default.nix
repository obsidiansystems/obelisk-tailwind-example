{ pkgs ? (import ./src/nixpkgs.nix) {} }:
let
  tailwindPkgs = import ./src/nixpkgs.nix {};
in

# Static assets derivation.
# Add build steps here (e.g. postcss, tailwind, sass).
pkgs.stdenv.mkDerivation {
  name = "static";
  src = ./src;
  buildInputs = [pkgs.nodejs tailwindPkgs.tailwindcss_4];
  installPhase = ''
    mkdir -p $out/css
    mkdir -p $out/images

    # We make the frontend haskell source files available here:
    # This corresponds to the path specified in tailwind.config.js
    ln -s ${../frontend} frontend

    # Run the tailwindcss compiler:
    tailwindcss -i css/styles.css -o $out/styles.css

    # We can write other commands to produce more static files as well:
    cp -r images/* $out/images/
  '';
}
