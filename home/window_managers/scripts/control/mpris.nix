{
  writeShellScriptBin,
  lib,
  wget,
  ffmpeg,
  libnotify,
  cmus,
  mprisctl,
}:
writeShellScriptBin "mpris" ''
  function get_art_path {
    local cache_dir player_dir art_url art_path song_path player artist album

    cache_dir="$XDG_CACHE_HOME/mpris"
    [ ! -d "$cache_dir" ] && mkdir -p "$cache_dir"

    player=$(${lib.getExe mprisctl} player)
    player_dir="$cache_dir/$player"

    art_url=$(${lib.getExe mprisctl} metadata mpris:artUrl)
    if [[ -n $art_url ]]; then
      case "$art_url" in
      file://*) echo "''${art_url#file://}" ;;
      https://*)
        [ ! -d "$player_dir" ] && mkdir -p "$player_dir"

        art_path="$player_dir/$(basename "$art_url")"
        [ ! -e "$art_path" ] && ${lib.getExe wget} -q "$art_url" -O "$art_path"

        echo "$art_path"
        ;;
      esac
    else
      # HACK: until cmus support mpris artUrl
      if [[ "$player" == "org.mpris.MediaPlayer2.cmus" ]]; then
        [ ! -d "$player_dir" ] && mkdir -p "$player_dir"

        artist=$(${lib.getExe' cmus "cmus-remote"} -Q | grep -w 'tag artist' | cut -d ' ' -f 3-)
        album=$(${lib.getExe' cmus "cmus-remote"} -Q | grep -w 'tag album' | cut -d ' ' -f 3-)
        art_path="$player_dir/$artist - $album.png"

        if [ ! -e "$art_path" ]; then
          song_path=$(${lib.getExe' cmus "cmus-remote"} -Q | grep 'file' | cut -d ' ' -f 2-)
          ${lib.getExe ffmpeg} -loglevel quiet -i "$song_path" -an -vcodec copy "$art_path"
        fi

        echo "$art_path"
      fi
    fi

  }

  function convert_time {
    local micro min sec

    micro="$1"
    min=$((micro / 60000000))
    sec=$((micro / 1000000 % 60))

    awk -v min="$min" -v sec="$sec" 'BEGIN { printf "%02d:%02d", min, sec }'
  }

  function notify {
    local artist album title art_path

    artist=$(${lib.getExe mprisctl} metadata xesam:artist)
    album=$(${lib.getExe mprisctl} metadata xesam:album)
    title=$(${lib.getExe mprisctl} metadata xesam:title)
    art_path=$(get_art_path)

    ${lib.getExe' libnotify "notify-send"} -a "mpris" "$title" "''${artist:+$artist}''${album:+\n$album}" -i "''${art_path:- }" -u low -t 2000
  }

  function notify_progress {
    local artist album title art_path duration position time progress

    artist=$(${lib.getExe mprisctl} metadata xesam:artist)
    album=$(${lib.getExe mprisctl} metadata xesam:album)
    title=$(${lib.getExe mprisctl} metadata xesam:title)
    status=$([ "$(${lib.getExe mprisctl} player-properties PlaybackStatus)" == "Playing" ] && printf "󰏤" || printf "󰐊")
    art_path=$(get_art_path)
    duration=$(${lib.getExe mprisctl} metadata mpris:length)
    position=$(${lib.getExe mprisctl} player-properties Position)
    time="$(convert_time "$position") / $(convert_time "$duration")"
    progress=$((position * 100 / duration))

    ${lib.getExe' libnotify "notify-send"} -a "mpris" "$title" "''${artist:+$artist}''${album:+\n$album}\n$status $time" -i "''${art_path:- }" -u low -t 2000 -h int:value:$progress
  }

  function notify_volume {
    local artist album title art_path volume  

    artist=$(${lib.getExe mprisctl} metadata xesam:artist)
    album=$(${lib.getExe mprisctl} metadata xesam:album)
    title=$(${lib.getExe mprisctl} metadata xesam:title)
    art_path=$(get_art_path)
    volume=$(${lib.getExe mprisctl} player-properties Volume | awk '{ print int($1 * 100) }')

    ${lib.getExe' libnotify "notify-send"} -a "control" "$title" "''${artist:+$artist}''${album:+\n$album}\n<b>Volume ''${volume}%</b>" -i "''${art_path:- }" -u low -t 2000 -h int:value:"$volume"
  }

  function increment_volume {
    ${lib.getExe mprisctl} set-volume 0.05+
    notify_volume
  }

  function decrement_volume {
    ${lib.getExe mprisctl} set-volume 0.05-
    notify_volume
  }

  function seek_backward {
    ${lib.getExe mprisctl} seek -- -5000000
    notify_progress
  }

  function seek_forward {
    ${lib.getExe mprisctl} seek 5000000
    notify_progress
  }

  function toggle {
    ${lib.getExe mprisctl} play-pause
  }

  function next_track {
    ${lib.getExe mprisctl} next
    notify
  }

  function previous_track {
    ${lib.getExe mprisctl} previous
    notify
  }

  function next_player {
    ${lib.getExe mprisctl} next-player
    notify
  }

  function previous_player {
    ${lib.getExe mprisctl} previous-player
    notify
  }

  case "$1" in
  increment-volume) increment_volume ;;
  decrement-volume) decrement_volume ;;
  seek-backward) seek_backward ;;
  seek-forward) seek_forward ;;
  toggle) toggle ;;
  next-track) next_track ;;
  previous-track) previous_track ;;
  next-player) next_player ;;
  previous-player) previous_player ;;
  notify) notify ;;
  notify-progress) notify_progress ;;
  esac
''
