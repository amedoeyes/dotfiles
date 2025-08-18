{
  stdenv,
  writeShellScriptBin,
  lib,
  flock,
  fzf,
  terminalCmd ? "",
  fzfOptions ? [ ],
}:
let
  concatOptions = lib.strings.concatStringsSep " ";
in
writeShellScriptBin "fzfmenu" ''
  exec 9>"$XDG_RUNTIME_DIR/fzfmenu.lock"
  ${lib.getExe flock} -n 9 || exit
  ${terminalCmd} ${stdenv.shell} -c "echo -ne '\\e[5 q' && ${lib.getExe fzf} ${concatOptions fzfOptions} $* </proc/$$/fd/0 >/proc/$$/fd/1"
''
