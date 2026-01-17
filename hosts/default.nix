{
  name,
  users,
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
{
  imports = [ ./${name}.nix ];

  nixpkgs.overlays = [
    (
      final: prev:
      import ../pkgs {
        inherit inputs;
        pkgs = prev;
      }
    )
  ];

  users.users = lib.mapAttrs (
    username: user:
    user.config {
      inherit pkgs;
      inherit lib;
      inherit config;
    }
  ) users;

  system.stateVersion = lib.mkDefault "25.11";
}
