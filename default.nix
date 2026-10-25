{ system ? builtins.currentSystem
, obelisk ? import ./.obelisk/impl {
    inherit system;
  }
}:
obelisk.project (import ./project.nix)
