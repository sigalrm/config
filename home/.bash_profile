# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# User specific environment and startup programs

PATH=$HOME/.local/bin:$HOME/git/config/bin:$HOME/git/depot_tools:$PATH
export PATH

if [ -n "$DISPLAY" ]; then
    xrdb -merge ~/.Xdefaults
fi

if [ "$TERMYSEQUENCE" ]; then
    source /usr/share/termy-server/iterm2_shell_integration.bash
fi

if false; then
#if [ -x `which powerline-daemon` ]; then
    powerline-daemon -q
    POWERLINE_BASH_CONTINUATION=1
    POWERLINE_BASH_SELECT=1
    . /usr/share/powerline/bash/powerline.sh
fi
