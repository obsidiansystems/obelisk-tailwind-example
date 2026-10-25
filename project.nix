{ pkgs, obeliskLib, nix-haskell-compilers, ... }:
{
  imports = [
    (import "${nix-haskell-compilers}/ghc-wasm-meta" {
      flavour = "9.12";
      drivers = [ "nixpkgs" ];
    })
  ];

  name = "obelisk-tailwind-example";
  src = ./.;
  inherit (obeliskLib) source-repository-packages;

  obelisk.static.path = import ./static { inherit pkgs; };
  obelisk.config.path = ./config;

  shell = {
    crossPlatforms = ps: [ ps.wasi32 ];
    withHoogle = true;
  };
}
