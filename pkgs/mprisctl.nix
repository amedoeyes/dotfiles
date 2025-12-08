{ pkgs, ... }:
(builtins.getFlake "github:amedoeyes/mprisctl/b389f4d9c1af6bdda919fe1d9c6d990251661a85")
.packages.${pkgs.stdenv.hostPlatform.system}.default
