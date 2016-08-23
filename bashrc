# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export PATH=$PATH:$(ruby -e "print Gem.user_dir")/bin:~/.local/bin
export EDITOR=vim

alias ls='ls --color=auto'
alias ll='ls -l'
eval $(dircolors -b)
alias grep='grep --color=auto'
alias git='LANG=en_GB git'
alias gdb='gdb -q'
alias cgdb='cgdb -q'
alias octave='octave-cli -q'
alias ssh='TERM="xterm-256color" ssh'
alias pacaur='pacaur -a'

export LESS=-R
export LESS_TERMCAP_mb=$'\E[1;31m'
export LESS_TERMCAP_md=$'\E[1;36m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[1;32m'

alias gst='git status'
alias vimc='vim -c "call InitC()"'
alias vimb='vim -c "call InitBase()"'
alias vimp='vim -c "call InitPython()"'
alias vims='vim -c "call InitBash()"'
alias i='i3-msg'

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

genpasswd() {
	local l=$1
		[ "$l" == "" ] && l=16
		tr -dc A-Za-z0-9_ < /dev/urandom | head -c ${l} | xargs
}
