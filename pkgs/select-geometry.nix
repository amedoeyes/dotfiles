{
  writeShellScriptBin,
  lib,
  jq,
  sway,
  slurp,
}:
let
  swaymsgBin = lib.getExe' sway "swaymsg";
  jqBin = lib.getExe jq;
  slurpBin = lib.getExe slurp;
in
writeShellScriptBin "select-geometry" ''
  ${swaymsgBin} -t get_tree |
  	${jqBin} -r '.. | select(.pid? and .visible?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"' |
  	${slurpBin} -b "#000000A0" -c "#A0A0A0FF" -s "#00000000" -B "#000000A0" -w 1 -o
''
