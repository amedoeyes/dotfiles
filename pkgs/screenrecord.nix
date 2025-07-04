{
  writeShellScriptBin,
  lib,
  wf-recorder,
}:
writeShellScriptBin "screenrecord" ''
  file="$XDG_VIDEOS_DIR/screenshots/$(date +%Y/%m/%d/%H%M%S).png" 
  mkdir -p "$(dirname $file)" 
  ${lib.getExe wf-recorder} -f "$FILE" "$@"
''
