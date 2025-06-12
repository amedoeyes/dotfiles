{
  writeShellScriptBin,
  lib,
  coreutils,
  wget,
  gnugrep,
  gawk,
  ffmpeg,
  libnotify,
  cmus,
  mprisctl,
}:
let
  mkdirBin = lib.getExe' coreutils "mkdir";
  wgetBin = lib.getExe wget;
  grepBin = lib.getExe gnugrep;
  awkBin = lib.getExe gawk;
  ffmpegBin = lib.getExe ffmpeg;
  notifySendBin = lib.getExe' libnotify "notify-send";
  cmusRemoteBin = lib.getExe' cmus "cmus-remote";
  mprisctlBin = lib.getExe mprisctl;
in
writeShellScriptBin "mpris" ''
  function get_art_path {
    local cache_dir player_dir art_url art_path song_path player artist album

    cache_dir="$XDG_CACHE_HOME/mpris"
    [ ! -d "$cache_dir" ] && ${mkdirBin} -p "$cache_dir"

    player=$(${mprisctlBin} player)
    player_dir="$cache_dir/$player"

    art_url=$(${mprisctlBin} metadata mpris:artUrl)
    if [[ -n $art_url ]]; then
      case "$art_url" in
      file://*) echo "''${art_url#file://}" ;;
      https://*)
        [ ! -d "$player_dir" ] && ${mkdirBin} -p "$player_dir"

        art_path="$player_dir/$(basename "$art_url")"
        [ ! -e "$art_path" ] && ${wgetBin} -q "$art_url" -O "$art_path"

        echo "$art_path"
        ;;
      esac
    else
      # HACK: until cmus support mpris artUrl
      if [[ "$player" == "org.mpris.MediaPlayer2.cmus" ]]; then
        [ ! -d "$player_dir" ] && ${mkdirBin} -p "$player_dir"

        artist=$(${cmusRemoteBin} -Q | ${grepBin} -w 'tag artist' | cut -d ' ' -f 3-)
        album=$(${cmusRemoteBin} -Q | ${grepBin} -w 'tag album' | cut -d ' ' -f 3-)
        art_path="$player_dir/$artist - $album.png"

        if [ ! -e "$art_path" ]; then
          song_path=$(${cmusRemoteBin} -Q | ${grepBin} 'file' | cut -d ' ' -f 2-)
          ${ffmpegBin} -loglevel quiet -i "$song_path" -an -vcodec copy "$art_path"
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

    ${awkBin} -v min="$min" -v sec="$sec" 'BEGIN { printf "%02d:%02d", min, sec }'
  }

  function notify {
    local artist album title art_path

    artist=$(${mprisctlBin} metadata xesam:artist)
    album=$(${mprisctlBin} metadata xesam:album)
    title=$(${mprisctlBin} metadata xesam:title)
    art_path=$(get_art_path)

    ${notifySendBin} -a "mpris" "$title" "''${artist:+$artist}''${album:+\n$album}" -i "''${art_path:- }" -u low -t 2000
  }

  function notify_progress {
    local artist album title art_path duration position time progress

    artist=$(${mprisctlBin} metadata xesam:artist)
    album=$(${mprisctlBin} metadata xesam:album)
    title=$(${mprisctlBin} metadata xesam:title)
    art_path=$(get_art_path)
    duration=$(${mprisctlBin} metadata mpris:length)
    position=$(${mprisctlBin} player-properties Position)
    time="$(convert_time "$position") / $(convert_time "$duration")"
    progress=$((position * 100 / duration))

    ${notifySendBin} -a "mpris" "$title" "''${artist:+$artist}''${album:+\n$album}\n$time" -i "''${art_path:- }" -u low -t 2000 -h int:value:$progress
  }

  function notify_volume {
    local artist album title art_path volume  

    artist=$(${mprisctlBin} metadata xesam:artist)
    album=$(${mprisctlBin} metadata xesam:album)
    title=$(${mprisctlBin} metadata xesam:title)
    art_path=$(get_art_path)
    volume=$(${mprisctlBin} player-properties Volume | ${awkBin} '{ print int($1 * 100) }')

    ${notifySendBin} -a "control" "$title" "''${artist:+$artist}''${album:+\n$album}\n<b>Volume ''${volume}%</b>" -i "''${art_path:- }" -u low -t 2000 -h int:value:"$volume"
  }

  function increment_volume {
    ${mprisctlBin} set-volume 0.05+
    notify_volume
  }

  function decrement_volume {
    ${mprisctlBin} set-volume 0.05-
    notify_volume
  }

  function seek_backward {
    ${mprisctlBin} seek -- -5000000
    notify_progress
  }

  function seek_forward {
    ${mprisctlBin} seek 5000000
    notify_progress
  }

  function toggle {
    ${mprisctlBin} play-pause
  }

  function next_track {
    ${mprisctlBin} next
    notify
  }

  function previous_track {
    ${mprisctlBin} previous
    notify
  }

  function next_player {
    ${mprisctlBin} next-player
    notify
  }

  function previous_player {
    ${mprisctlBin} previous-player
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
