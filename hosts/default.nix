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
  nixpkgs.overlays = [
    (final: prev: import ../pkgs prev)

    (final: prev: {
      python313 = prev.python313.override {
        packageOverrides = final: prev: {
          lxml-html-clean = prev.lxml-html-clean.overridePythonAttrs (old: {
            doCheck = false;
          });
        };
      };
    })
  ];
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
