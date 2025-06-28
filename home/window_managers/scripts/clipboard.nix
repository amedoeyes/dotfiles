{
  writeShellScriptBin,
  lib,
  cliphist,
  wl-clipboard,
  fzfmenu,
}:
let
  cliphistBin = lib.getExe cliphist;
  wlCopyBin = lib.getExe' wl-clipboard "wl-copy";
  fzfmenuBin = lib.getExe fzfmenu;
in
writeShellScriptBin "clipboard" ''
  result=$(${cliphistBin} -preview-width 1024 list | ${fzfmenuBin} --with-nth=2..)
  [[ -n "$result" ]] && ${cliphistBin} decode "$result" | ${wlCopyBin}
''
