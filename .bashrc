# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
alias b='git branch -a'
alias l='git log'
alias d='git diff'
alias t='git diff --staged'
alias f='git fetch'
alias s='git status'
alias e='git reset --soft HEAD^'
alias c='git commit -c ORIG_HEAD'
alias C='git commit -C ORIG_HEAD'

alias m='make'
alias nethack='ssh nethack@nethack.alt.org'

alias less='less -SR'
alias grep='grep --color=auto'

if [ "$PS1" ]; then
	case $TERM in
	xterm*)
		export PROMPT_COMMAND='echo -ne "\033]0;${HOSTNAME%%.*}"; echo -ne "\007"'
		;;
	esac
fi

unset MAILCHECK

export EDITOR=vi
