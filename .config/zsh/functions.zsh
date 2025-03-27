autoload -Uz add-zsh-hook

function cht.sh {
	curl -s "cheat.sh/$1?qT"
}

function spell {
	echo $1 | hunspell -a | grep "^&" | awk -F": " '{print $2}'
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
