pkgs: {
  launcher = pkgs.callPackage ./launcher.nix { };
  clipboard = pkgs.callPackage ./clipboard.nix { };
  control = {
    mpris = pkgs.callPackage ./control/mpris.nix { };
    audio = pkgs.callPackage ./control/audio.nix { };
    brightness = pkgs.callPackage ./control/brightness.nix { };
  };
}
