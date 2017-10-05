# .bashrc

source ~/.shellrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Source all completions
if [ -d ~/.bash_completions ]; then
	for F in $(find ~/.bash_completions -type f); do
		. "$F"
	done
fi

# PROMPT #######################################################
PS1='$(
if [ `id -u` -eq "0" ]; then
	echo -n "\[\e[1;31m\]\u@\h:\[\e[1;34m\]\W\[\e[1;31m\]\$\[\e[0m\] "
else
	echo -n "\[\e[1;32m\]\u@\h:\[\e[1;34m\]\W\[\e[1;32m\]\$\[\e[0m\] "
fi)'

PROMPT_COMMAND='
EC=$?
if [[ $EC < 0 ]]; then
	echo -e "\e[1;31m"EXIT: $EC"\e[0m"
elif [[ $EC > 0 ]]; then
	echo -e "\e[1;33m"EXIT: $EC"\e[0m"
fi'

function settitle {
	echo -ne "\033]0;`whoami`@`hostname`:`pwd`\007"
}
case "$TERM" in
	xterm*|*rxvt*)
		trap 'settitle' DEBUG
		;;
esac

# Completions ##################################################

_gitbmerge() {
	local cur prev
	_init_completion || return
	[ $COMP_CWORD -gt 1 ] &&  return # Complete only single dependency
	COMPREPLY=()
	local GDIR="$(pwd)"
	while [ ! -d "$GDIR/.git"  ]; do
		[ -z "$GDIR" ] && return
		GDIR="${GDIR%/*}"
	done
	GDIR="$GDIR/.git"
	[ -f "$GDIR" ] && GDIR="$(cat "$GDIR")" # This just points to some other directory
	[ -d "$GDIR/refs/heads" ] || return # No completion if there is no local branch
	local ops=""
	for B in "$GDIR"/refs/heads/*; do
		# TODO skip branch on HEAD
		ops="$ops ${B#$GDIR/refs/heads/}"
	done
	COMPREPLY+=($(compgen -W "${ops}" -- ${cur}))
}
complete -F _gitbmerge gitbmerge
