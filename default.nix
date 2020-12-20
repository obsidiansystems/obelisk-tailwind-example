{ system ? builtins.currentSystem
, obelisk ? import ./.obelisk/impl {
    inherit system;
    iosSdkVersion = "13.2";
  }
}:
with obelisk;
project ./. ({ pkgs, ... }: {
  staticFiles = import ./static { inherit pkgs; };
  android.applicationId = "systems.obsidian.obelisk.examples.tailwind";
  android.displayName = "Obelisk + Tailwind CSS";
  ios.bundleIdentifier = "systems.obsidian.obelisk.examples.tailwind";
  ios.bundleName = "Obelisk + Tailwind CSS";
})
