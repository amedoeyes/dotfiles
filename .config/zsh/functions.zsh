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
	swaymsg -t get_tree | jq -r '.. | select(.pid? and .visible?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"' | slurp -b "#000000A0" -c "#A0A0A0FF" -s "#00000000" -B "#000000A0" -w 1 -o
}

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
