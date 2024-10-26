function spell() {
	echo "$1" | hunspell -a | grep "^&" | awk -F": " '{print $2}'
}

screenshot() {
	local directory="$HOME/pictures/screenshots/$(date +%Y)/$(date +%m)/$(date +%d)/"
	local -r filename="$(date +%H%M%S)"
	local format="png"
	local file="$directory/$filename.$format"
	if [[ ! -d $directory ]]; then
		mkdir -p "$directory"
	fi
	local -r geometry=$(select-geometry)
	if [[ -n "$geometry" ]]; then
		sleep 0.2
		grim -g "$geometry" "$file"
		wl-copy -t image/png <"$file"
	fi
}

function screenrecord() {
	local directory="$HOME/videos/screenrecords/$(date +%Y)/$(date +%m)/$(date +%d)/"
	local -r filename="$(date +%H%M%S)"
	local format=mp4
	local file="$directory/$filename.$format"
	if [ ! -d "$directory" ]; then
		mkdir -p "$directory"
	fi
	wf-recorder -f "$file" "$@"
}

select-geometry() {
	local -r monitors_geometry=$(hyprctl monitors -j | jq -r '.[] | "\(.x),\(.y) \(.width)x\(.height)"')
	local -r workspaces=$(hyprctl monitors -j | jq -r 'map(.activeWorkspace.id)')
	local -r windows=$(hyprctl clients -j | jq -r --argjson workspaces "$workspaces" 'map(select([.workspace.id] | inside($workspaces)))')
	local -r windows_geometry=$(echo "$windows" | jq -r '.[] | "\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')
	local -r selected=$(echo "$monitors_geometry\n$windows_geometry" | slurp -b "#000000A0" -c "#A0A0A0FF" -s "#00000000" -B "#000000A0" -w 1)
	if [[ -n "$selected" ]]; then
		printf "%s\n" "$selected"
	fi
}
