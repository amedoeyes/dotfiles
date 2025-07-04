{
  writeShellScriptBin,
  lib,
  grim,
  wl-clipboard,
}:
writeShellScriptBin "screenshot" ''
  file="$XDG_PICTURES_DIR/screenshots/$(date +%Y/%m/%d/%H%M%S).png" 
  mkdir -p "$(dirname $file)" 
  ${lib.getExe grim} "$@" "$file"
  ${lib.getExe' wl-clipboard "wl-copy"} -t image/png <"$file"
''
