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
  	echo -en "\e[?25l"
  }

  display_cover

  dbus-monitor "type='signal',interface='org.freedesktop.DBus.Properties',member='PropertiesChanged'" |
  	while read -r line; do
  		if echo "$line" | grep -q "Metadata"; then
  			display_cover
  		fi
  	done
''
