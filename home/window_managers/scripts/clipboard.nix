{
  writeShellScriptBin,
  lib,
  cliphist,
  wl-clipboard,
  fzfmenu,
}:
writeShellScriptBin "clipboard" ''
  result=$(${lib.getExe cliphist} -preview-width 1024 list | ${lib.getExe fzfmenu} --with-nth=2..)
  [[ -n "$result" ]] && ${lib.getExe cliphist} decode "$result" | ${lib.getExe' wl-clipboard "wl-copy"}
''
