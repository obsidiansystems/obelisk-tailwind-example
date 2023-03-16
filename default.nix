{ system ? builtins.currentSystem
, obelisk ? import ./.obelisk/impl {
    inherit system;
    iosSdkVersion = "13.2";
  }
}:
let
  pkgs = import (builtins.fetchGit {
    name = "nixos-22.11";
    url = "https://github.com/nixos/nixpkgs/";
    ref = "refs/heads/nixos-22.11";
  }) {};
in
  with obelisk;
  project ./. ({ ... }: {
    staticFiles = import ./static { inherit pkgs; };
    android.applicationId = "systems.obsidian.obelisk.examples.tailwind";
    android.displayName = "Obelisk + Tailwind CSS";
    ios.bundleIdentifier = "systems.obsidian.obelisk.examples.tailwind";
    ios.bundleName = "Obelisk + Tailwind CSS";
  })
