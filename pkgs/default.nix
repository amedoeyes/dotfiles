pkgs: {
  cmus-cover = pkgs.callPackage ./cmus-cover.nix { };
  fzfmenu = pkgs.callPackage ./fzfmenu.nix { };
  mprisctl = pkgs.callPackage ./mprisctl.nix { };
  screenrecord = pkgs.callPackage ./screenrecord.nix { };
  screenshot = pkgs.callPackage ./screenshot.nix { };
  select-geometry = pkgs.callPackage ./select-geometry.nix { };
}
