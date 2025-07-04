{
  writeShellScriptBin,
  lib,
  libnotify,
  brightnessctl,
}:
writeShellScriptBin "brightness" ''
  ICONS=("󰃚 " "󰃛 " "󰃜 " "󰃝 " "󰃞 " "󰃟 " "󰃠 ")

  function notify {
    local brightness icon_index

  	brightness="$1"
  	icon_index=$((brightness * (''${#ICONS[@]} - 1) / 100))
  	${lib.getExe' libnotify "notify-send"} -a "control" "''${ICONS[icon_index]} Brightness $brightness%" -u low -t 2000 -h int:value:"$brightness"
  }

  function increment {
    local brightness new_brightness

  	brightness=$(${lib.getExe brightnessctl} -m | awk -F, '{ print $4 }' | sed 's/%//')
  	new_brightness=$((brightness + 5))

  	((new_brightness > 100)) && new_brightness=100

  	${lib.getExe brightnessctl} -q s "''${new_brightness}%"

  	notify "$new_brightness"
  }

  function decrement {
    local brightness new_brightness

  	brightness=$(${lib.getExe brightnessctl} -m | awk -F, '{ print $4 }' | sed 's/%//')
  	new_brightness=$((brightness - 5))

  	((new_brightness < 0)) && new_brightness=0
  	
  	${lib.getExe brightnessctl} -q s "''${new_brightness}%"

  	notify "$new_brightness"
  }

  case "$1" in
  increment) increment ;;
  decrement) decrement ;;
  esac
''
