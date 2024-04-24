source /usr/share/zsh/scripts/zplug/init.zsh

zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "jeffreytse/zsh-vi-mode"
zplug "junegunn/fzf", use:"shell/*.zsh"

zplug load
