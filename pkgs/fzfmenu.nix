{
  stdenv,
  writeShellScriptBin,
  lib,
  flock,
  fzf,
  fzfOptions,
  terminal,
  terminalBinary,
  terminalOptions,
}:
let
  concatOptions = lib.strings.concatStringsSep " ";
  flockBin = lib.getExe flock;
  fzfBin = lib.getExe fzf;
in
writeShellScriptBin "fzfmenu" ''
  exec 9>"/tmp/fzfmenu.lock"
  ${flockBin} -n 9 || exit
  ${terminal}/bin/${terminalBinary} ${concatOptions terminalOptions} ${stdenv.shell} -c "echo -ne '\\e[5 q' && ${fzfBin} ${concatOptions fzfOptions} $* </proc/$$/fd/0 >/proc/$$/fd/1"
''
