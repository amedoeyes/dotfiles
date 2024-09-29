function spell() {
	echo "$1" | hunspell -a | grep "^&" | awk -F": " '{print $2}'
}

function ya() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

function screenrecord() {
	directory="$HOME/videos/screenrecords/$(date +%Y)/$(date +%m)/$(date +%d)/"
	filename="$(date +%H%M%S).mp4"
	if [ ! -d "$directory" ]; then
		mkdir -p "$directory"
	fi
	wf-recorder -f "$directory/$filename" "$@"
}
