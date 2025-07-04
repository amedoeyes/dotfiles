{
  writeShellScriptBin,
  lib,
  jq,
  sway,
  slurp,
}:
writeShellScriptBin "select-geometry" ''
  ${lib.getExe' sway "swaymsg"} -t get_tree |
  	${lib.getExe jq} -r '.. | select(.pid? and .visible?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"' |
  	${lib.getExe slurp} -b "#000000A0" -c "#A0A0A0FF" -s "#00000000" -B "#000000A0" -w 1 -o
''
