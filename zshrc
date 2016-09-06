zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' max-errors 3
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.cache/zsh
zstyle :compinstall filename '/home/kkoci/.zshrc'
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==32=33}:${(s.:.)LS_COLORS}")'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

autoload -Uz compinit && compinit
autoload -Uz colors && colors

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt extendedglob
setopt hist_ignore_dups
setopt hist_expire_dups_first
setopt extended_history
setopt inc_append_history
setopt promptsubst
setopt hist_ignore_dups
unsetopt nomatch
bindkey -e

# Delete key workaround
bindkey    "^[[3~"          delete-char
bindkey    "^[3;5~"         delete-char

# PROMPT #######################################################
annoyme_check() {
	if ls ~/.annoyme/*.pid 2>/dev/null >/dev/null; then
		echo "%{$fg_bold[red]%}!"
	fi
}
if [ $UID -eq 0 ]; then NCOLOR="red"; else NCOLOR="green"; fi
PROMPT="%(?..%{$fg_bold[yellow]%}EXIT: %?
)\$(annoyme_check)%{$fg_bold[$NCOLOR]%}%n@%m:%{$fg_bold[blue]%}%1~%{$fg_bold[$NCOLOR]%}%(!.#.$)%{$reset_color%} "

if [ -e ~/.local/git-prompt.sh ]; then
	source ~/.local/git-prompt.sh
	export GIT_PS1_SHOWDIRTYSTATE=y
	export GIT_PS1_SHOWUNTRACKEDFILES=y
	export GIT_PS1_SHOWUPSTREAM="auto"
	export GIT_PS1_STATESEPARATOR=""
	export GIT_PS1_SHOWUPSTREAM=y
	export GIT_PS1_DESCRIBE_STYLE="branch"
	RPROMPT=$RPROMPT'$(__git_ps1 "%s")'
fi

################################################################
case "$TERM" in
	xterm*|*rxvt*)
		precmd() {
			print -Pn "\e]0;%n@%m:%~  %(1j,%j job%(2j|s|) ,)\a"
		}
		preexec() {
			print -Pn "\e]0;%n@%m:%~ !$1\a"
		}
		;;
esac

source ~/.shellrc
