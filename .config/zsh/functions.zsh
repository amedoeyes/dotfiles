function spell {
	echo $1 | hunspell -a | grep "^&" | awk -F": " '{print $2}'
}

function screenshot {
	local directory="$HOME/pictures/screenshots/$(date +%Y)/$(date +%m)/$(date +%d)/"
	local -r filename=$(date +%H%M%S)
	local format="png"
	local file="$directory/$filename.$format"
	[ ! -d $directory ] && mkdir -p $directory
	if [[ -n $1 && $1 == "-s" ]]; then
		local -r geometry=$(select-geometry)
		if [[ -n $geometry ]]; then
			sleep 0.2
			grim -g $geometry $file
			wl-copy -t image/png <$file
		fi
	else
		grim $file
	fi
}

function screenrecord {
	local directory="$HOME/videos/screenrecords/$(date +%Y)/$(date +%m)/$(date +%d)/"
	local -r filename=$(date +%H%M%S)
	local format="mp4"
	local file="$directory/$filename.$format"
	[ ! -d $directory ] && mkdir -p $directory
	wf-recorder -f $file $@
}

function select-geometry {
	swaymsg -t get_tree | jq -r '.. | select(.pid? and .visible?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"' | slurp -b "#000000A0" -c "#A0A0A0FF" -s "#00000000" -B "#000000A0" -w 1 -o
}

function vifm {
	local dst="$(command vifm --choose-dir - "$@")"
	[ -z $dst ] && return 1
	cd $dst
}

function osc7-pwd {
	emulate -L zsh 
	setopt extendedglob
	local LC_ALL=C
	printf '\e]7;file://%s%s\e\' $HOST ${PWD//(#m)([^@-Za-z&-;_~])/%${(l:2::0:)$(([##16]#MATCH))}}
}

function chpwd-osc7-pwd {
	(( ZSH_SUBSHELL )) || osc7-pwd
}
add-zsh-hook -Uz chpwd chpwd-osc7-pwd

function xterm_title_precmd {
	print -Pn -- '\e]2;%n@%m %~\a'
	[[ "$TERM" == 'screen'* ]] && print -Pn -- '\e_\005{2}%n\005{-}@\005{5}%m\005{-} \005{+b 4}%~\005{-}\e\\'
}
add-zsh-hook -Uz precmd xterm_title_precmd

function xterm_title_preexec {
	print -Pn -- '\e]2;%n@%m %~ %# ' && print -n -- "${(q)1}\a"
	[[ "$TERM" == 'screen'* ]] && { print -Pn -- '\e_\005{2}%n\005{-}@\005{5}%m\005{-} \005{+b 4}%~\005{-} %# ' && print -n -- "${(q)1}\e\\"; }
}
add-zsh-hook -Uz preexec xterm_title_preexec
