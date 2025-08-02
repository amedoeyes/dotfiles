{
  writeShellScriptBin,
  lib,
  wf-recorder,
}:
writeShellScriptBin "screenrecord" ''
  file="$XDG_VIDEOS_DIR/screenrecords/$(date +%Y/%m/%d/%H%M%S).mp4"
  mkdir -p "$(dirname $file)" 
  ${lib.getExe wf-recorder} -f "$file" "$@"
''
