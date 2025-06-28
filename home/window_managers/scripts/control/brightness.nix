{
  writeShellScriptBin,
  lib,
  gawk,
  gnused,
  libnotify,
  brightnessctl,
}:
let
  awkBin = lib.getExe gawk;
  sedBin = lib.getExe gnused;
  notifySendBin = lib.getExe' libnotify "notify-send";
  brightnessctlBin = lib.getExe brightnessctl;
in
writeShellScriptBin "brightness" ''
  ICONS=("󰃚 " "󰃛 " "󰃜 " "󰃝 " "󰃞 " "󰃟 " "󰃠 ")

  function notify {
    local brightness icon_index

  	brightness="$1"
  	icon_index=$((brightness * (''${#ICONS[@]} - 1) / 100))
  	${notifySendBin} -a "control" "''${ICONS[icon_index]} Brightness $brightness%" -u low -t 2000 -h int:value:"$brightness"
  }

  function increment {
    local brightness new_brightness

  	brightness=$(${brightnessctlBin} -m | ${awkBin} -F, '{ print $4 }' | ${sedBin} 's/%//')
  	new_brightness=$((brightness + 5))

  	((new_brightness > 100)) && new_brightness=100

  	${brightnessctlBin} -q s "''${new_brightness}%"

  	notify "$new_brightness"
  }

  function decrement {
    local brightness new_brightness

  	brightness=$(${brightnessctlBin} -m | ${awkBin} -F, '{ print $4 }' | ${sedBin} 's/%//')
  	new_brightness=$((brightness - 5))

  	((new_brightness < 0)) && new_brightness=0
  	
  	${brightnessctlBin} -q s "''${new_brightness}%"

  	notify "$new_brightness"
  }

  case "$1" in
  increment) increment ;;
  decrement) decrement ;;
  esac
''
