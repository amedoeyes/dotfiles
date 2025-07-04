{
  pkgs,
  lib,
  config,
  name,
  users,
  ...
}:
{
  imports = [ ./${name}.nix ];
  nixpkgs.overlays = [ (final: prev: import ../pkgs prev) ];
  users.users = lib.mapAttrs (
    username: user:
    user.config {
      inherit pkgs;
      inherit lib;
      inherit config;
    }
  ) users;
  system.stateVersion = "25.05";
}
