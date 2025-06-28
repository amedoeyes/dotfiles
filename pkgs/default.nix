pkgs: {
  fzfmenu = pkgs.callPackage ./fzfmenu.nix { };
  mprisctl = pkgs.callPackage ./mprisctl.nix { };
  select-geometry = pkgs.callPackage ./select-geometry.nix { };
}
