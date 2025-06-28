{
  writeShellScriptBin,
  lib,
  gawk,
  libnotify,
  wireplumber,
}:
let
  awkBin = lib.getExe gawk;
  notifySendBin = lib.getExe' libnotify "notify-send";
  wpctlBin = lib.getExe' wireplumber "wpctl";
in
writeShellScriptBin "audio" ''
  SOURCE_ICONS=(" " " ")
  SINK_ICONS=(" " " " " " " ")

  function notify {
    local device volume muted icon

    device="$1"
    volume=$(${wpctlBin} get-volume "$1")
    muted=$(echo "$volume" | ${awkBin} '{ print $3 }')
    volume=$(echo "$volume" | ${awkBin} '{ print $2*100 }')
    icon=""

    if [[ $device == "@DEFAULT_SOURCE@" ]]; then
      if [[ $muted ]]; then
        icon=''${SOURCE_ICONS[0]}
      else
        icon=''${SOURCE_ICONS[1]}
      fi
    elif [[ $device == "@DEFAULT_SINK@" ]]; then
      if [[ $muted ]]; then
        icon=''${SINK_ICONS[0]}
      else
        if ((volume <= 33)); then
          icon=''${SINK_ICONS[1]}
        elif ((volume <= 66)); then
          icon=''${SINK_ICONS[2]}
        else
          icon=''${SINK_ICONS[3]}
        fi
      fi
    fi

    ${notifySendBin} -a "control" "$icon Volume $volume%" -u low -t 2000 -h int:value:"$volume"
  }

  function increment {
    local current_volume new_volume

    current_volume=$(${wpctlBin} get-volume "$1" | ${awkBin} '{ print $2*100 }')
    new_volume=$((current_volume + 5))
    ${wpctlBin} set-volume "$1" "$new_volume%"

    notify "$1"
  }

  function decrement {
    local current_volume new_volume

    current_volume=$(${wpctlBin} get-volume "$1" | ${awkBin} '{ print $2*100 }')
    new_volume=$((current_volume - 5))
    ${wpctlBin} set-volume "$1" "$new_volume%"

    notify "$1"
  }

  function toggle {
    ${wpctlBin} set-mute "$1" toggle

    notify "$1"
  }

  case "$1" in
  increment-sink) increment "@DEFAULT_SINK@" ;;
  decrement-sink) decrement "@DEFAULT_SINK@" ;;
  toggle-sink) toggle "@DEFAULT_SINK@" ;;
  increment-source) increment "@DEFAULT_SOURCE@" ;;
  decrement-source) decrement "@DEFAULT_SOURCE@" ;;
  toggle-source) toggle "@DEFAULT_SOURCE@" ;;
  esac
''
