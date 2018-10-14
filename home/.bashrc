# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

umask 002
ulimit -c unlimited

export EDITOR=vi
export ALTERNATE_EDITOR=
export S="--stat=200,200"
export N=$HOME/git/termysequence
export B=$HOME/build
export DEBEMAIL='ewalsh@termysequence.com'
export DEBFULLNAME='Eamon Walsh'
unset MAILCHECK
unset command_not_found_handle

# Chdir aliases
alias cn='cd $HOME/git/termysequence'
alias c8='cd $HOME/git/termysequence/vendor/v8-linux'
alias ci='cd $HOME/git/termy-icon-theme'
alias cs='cd $HOME/git/termy-doc'
alias cw='cd $HOME/git/termy-website'
alias ck='cd $HOME/git/termy-packaging'
alias cb='cd $HOME/build'
alias cr='cd $HOME/release'
alias co='cd $HOME/.config/qtermyd'

# Aliases
alias less='less -SR'
alias grep='grep --color=auto'
alias ls='ls --color=auto --hyperlink=auto'
alias ll='ls -l --color=auto --hyperlink=auto'
alias l.='ls -d .* --color=auto --hyperlink-auto'

alias nethack='ssh nethack@nethack.alt.org'

alias j='journalctl --user --follow -o cat'
alias k='kill $(</tmp/termy-serverd1000/pid)'
alias M=m
alias p='pdflatex main.tex'
alias pt='perl ~/git/termysequence/test/client.pl'
alias sr='cb;test/slowreader'
alias rs='termy-serverd --nofork --nostdin'
alias rt='cd $HOME/build; make -j4; ctest -V'
alias vilog='vi $HOME/.config/QtProject/*log*'

alias pushweb='cw; cd _build/html; scp -r * termysequence.com:io/'
alias pushdoc='cs; cd _build/html; scp -r * termysequence.com:io/doc/'

alias rv='echo -ne "\033[?5h"' # Reverse video
alias nv='echo -ne "\033[?5l"'

# Git aliases
alias b='git branch -a'
alias C='git commit -C ORIG_HEAD'
alias c='git commit -c ORIG_HEAD'
alias d='git diff'
alias e='git reset --soft HEAD^'
alias f='git fetch'
alias g='cn;git grep -w '
alias l='git log --decorate=auto'
alias o='git log --oneline'
alias s='git status'
alias t='git diff --staged'
alias 1='git log --decorate=auto -n1 -p'

alias cnd='cn;d'
alias cnt='cn;t'
alias cnl='cn;l'
alias cns='cn;s'
