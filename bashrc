# .bashrc

source ~/.shellrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

PS1='$(
if [ `id -u` -eq "0" ]; then
	echo -n "\[\e[1;31m\]\u@\h:\[\e[1;34m\]\W\[\e[1;31m\]\$\[\e[0m\] "
else
	if ls ~/.annoyme/*.pid 2>/dev/null >/dev/null; then
		ANNOYME_PS="\[\e[1;31m\]!\[\e[0m\]"
	fi
	echo -n "$ANNOYME_PS\[\e[1;32m\]\u@\h:\[\e[1;34m\]\W\[\e[1;32m\]\$\[\e[0m\] "
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

