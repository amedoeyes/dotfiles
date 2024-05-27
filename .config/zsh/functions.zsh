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

function recorder() {
	wf-recorder -f "$HOME/Videos/screenrecords/$(date +%Y%m%d_%H%M%S).mp4" "$@"
}
