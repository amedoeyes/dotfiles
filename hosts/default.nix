{
  host,
  inputs,
  pkgs,
  lib,

  ...
}:
{
  imports = [ host.system ];

  nixpkgs.overlays = [
    (
      _: prev:
      import ../pkgs {
        inherit inputs;
        pkgs = prev;
      }
    )
  ];

  users.users = builtins.mapAttrs (_: user: user.user { inherit pkgs; }) host.profile.users;

  system.stateVersion = lib.mkDefault "25.11";
}
