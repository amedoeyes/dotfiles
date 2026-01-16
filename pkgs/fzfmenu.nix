{
  stdenv,
  writeShellScriptBin,
  lib,
  flock,
  fzf,
  terminalCmd ? "",
  fzfOptions ? [ ],
}:
writeShellScriptBin "fzfmenu" ''
  exec 9>"$XDG_RUNTIME_DIR/fzfmenu.lock"
  ${lib.getExe flock} -n 9 || exit
  ${terminalCmd} ${stdenv.shell} -c "echo -ne '\\e[5 q' && ${lib.getExe fzf} $FZF_DEFAULT_OPTS --margin 1 --separator='─' ${lib.strings.concatStringsSep " " fzfOptions} $* </proc/$$/fd/0 >/proc/$$/fd/1"
''
