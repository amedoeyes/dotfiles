{
  writeShellScriptBin,
  lib,
  cmus,
  ffmpeg,
  chafa,
}:
writeShellScriptBin "cmus-cover" ''
  function display_cover {
    ${lib.getExe ffmpeg} -loglevel quiet -i "$(${lib.getExe' cmus "cmus-remote"} -Q | grep 'file' | cut -d ' ' -f 2-)" -an -vcodec copy -f image2pipe - |
      ${lib.getExe chafa} -s "$(tput cols)"x"$(tput lines)" --align "center,center" --clear |
      tr -d '\n'
    tput civis
  }

  cleanup() {
    kill "$COPROC_PID" 2>/dev/null
    tput rmcup
    tput cnorm
    exit
  }

  need_redraw=1

  trap 'need_redraw=1' WINCH
  trap cleanup INT TERM EXIT

  coproc {
    exec dbus-monitor "type='signal',interface='org.freedesktop.DBus.Properties',member='PropertiesChanged'"
  }

  tput smcup

  while :; do
    if read -r -t 0.1 line <&"''${COPROC[0]}"; then
      if [[ $line == *Metadata* ]]; then
        need_redraw=1
      fi
    fi

    if ((need_redraw == 1)); then
      display_cover
      need_redraw=0
    fi
  done
''
