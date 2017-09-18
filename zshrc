source ~/.shellrc

[[ -o interactive ]] || return # skip on initialization if not interactive

zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' max-errors 3
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.cache/zsh
zstyle :compinstall filename '/home/kkoci/.zshrc'
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==32=33}:${(s.:.)LS_COLORS}")'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fpath=(~/.zsh_completions $fpath)

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

autoload -U select-word-style
select-word-style bash

# Delete key workaround
bindkey    "^[[3~"          delete-char
bindkey    "^[3;5~"         delete-char

# PROMPT #######################################################
annoyme_check() {
	which annoyme >/dev/null 2>&1 && ls ~/.annoyme/*.pid 2>/dev/null >&2 && \
		echo "%{$fg_bold[red]%}!"
}

[ $UID -eq 0 ] && NCOLOR="red" || NCOLOR="green"
PROMPT="%(?..%{$fg_bold[yellow]%}EXIT: %?
)\$(annoyme_check)%{$fg_bold[$NCOLOR]%}%n@%m:%{$fg_bold[blue]%}%1~%{$fg_bold[$NCOLOR]%}%(!.#.$)%{$reset_color%} "
unset NCOLOR

if [ -e ~/.local/git-prompt.sh ]; then
	source ~/.local/git-prompt.sh
	export GIT_PS1_SHOWDIRTYSTATE=y
	export GIT_PS1_SHOWUNTRACKEDFILES=y
	export GIT_PS1_SHOWUPSTREAM="auto"
	export GIT_PS1_STATESEPARATOR=""
	export GIT_PS1_SHOWUPSTREAM=y
	export GIT_PS1_DESCRIBE_STYLE="branch"
	RPROMPT='$(__git_ps1 "%s")'
fi
# Long running bell ############################################
# Inspired by: https://gist.github.com/jpouellet/5278239
zmodload zsh/datetime # load $EPOCHSECONDS builtin
autoload -Uz add-zsh-hook
lrbell_duration=15
lrbell_timestamp=$EPOCHSECONDS
lrbell_window_id=0x0

lrbell_active_window_id() {
	xprop -root 32x '\t$0' _NET_ACTIVE_WINDOW | cut -f 2
}

lrbell_begin() {
	lrbell_timestamp=$EPOCHSECONDS
	lrbell_message="`pwd`: $1"
	if [ -n "$DISPLAY" ]; then
		lrbell_window_id=$(lrbell_active_window_id)
	fi
}
lrbell_end() {
	if (( $EPOCHSECONDS - $lrbell_timestamp < $lrbell_duration )); then
		return
	fi

	print -n '\a'
	if [ -n "$DISPLAY" ] && [ -n "$lrbell_window_id" ]; then # notify only if running in X
		if [ "$(lrbell_active_window_id)" != "$lrbell_window_id" ]; then # And active window isn't current one
			notify-send "Command finished" "$lrbell_message"
		fi
	fi
}

add-zsh-hook preexec lrbell_begin
add-zsh-hook precmd lrbell_end
# Completions ##################################################

_gitbmerge() {
	(( CURRENT > 2)) &&  return # Complete only single dependency
	local GDIR="$(pwd)"
	while [ ! -d "$GDIR/.git"  ]; do
		[ -z "$GDIR" ] && return
		GDIR="${GDIR%/*}"
	done
	GDIR="$GDIR/.git"
	[ -f "$GDIR" ] && GDIR="$(cat "$GDIR")" # This just points to some other directory
	[ -d "$GDIR/refs/heads" ] || return # No completion if there is no local branch
	local branches=()
	for B in "$GDIR"/refs/heads/*; do
		# TODO skip branch on HEAD
		branches+=("${B#$GDIR/refs/heads/}")
	done
	_describe -t branches 'gitbmerge' branches
}
compdef _gitbmerge gitbmerge

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
