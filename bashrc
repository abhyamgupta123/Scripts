#.bashrc
export EDITOR=vim

# History support
export HISTCONTROL=ignoredups:erasedups
export HISTSIZE=100000
export HISTFILESIZE=1000000
#shopt -s histappend 
#export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
export SCRIPTHOME=$HOME/Scripts
if [ "$(uname)" == "Darwin" ]; then
    alias ls="gls --color=auto -ltr"
else
    alias ls='ls --color=auto'
    alias ll='ls -alF -ltr'
    alias la='ls -A -ltr'
    alias l='ls -CF -ltr'
fi
alias rm='rm -i'
alias sh='bash'
alias src='source ~/.bashrc'
alias copy='rsync -azv --progress -C'
alias i='sudo -E emerge -avuD '
alias netcat='nc.openbsd'
alias ii='sudo apt-get -c ~/.aptconf install'
alias ss='sudo -E emerge --search'
alias uu='sudo -E emerge -avuND @world'
alias cpptags='ctags h-c++-kinds=+p --fields=+iaS --extra=+q'
alias pandoc='pandoc --data-dir=$HOME/Scripts/pandoc --latex-engine=lualatex'
alias lynx='lynx --cfg=$HOME/Scripts/lynx.cfg'
alias sudo='sudo -E'
alias t='$SCRIPTHOME/todo.sh -d $SCRIPTHOME/todo.cfg'
alias note='terminal_velocity -x md ~/Work/notes'
alias pylint='pylint -E'
alias vi='vim'
alias pdflatex="pdflatex -shell-escape"
alias lualatex="lualatex -shell-escape"
#alias ghci='stack ghci'
# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f $HOME/.termcap ]; then
    TERMCAP=~/.termcap
    export TERMCAP
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
export PATH=~/Scripts/:$HOME/.mutt:$HOME:~/Scripts/data_over_git_ssh:$PATH

# My pandoc filters.
export PATH=$PATH:~/Scripts/pandoc

PROXYFILE=$HOME/Scripts/proxy
if [ -f $PROXYFILE ]; then
    source $PROXYFILE;
fi

# read history for each terminal
#export PROMPT_COMMAND="history -n; history -a"
source ~/Scripts/profile
export PATH=$PATH:~/.mutt:$HOME/.local/bin
export LYNX_CFG=~/Scripts/lynx.cfg

if [ -f ~/Scripts/dilawar_cd.sh ]; then 
    source ~/Scripts/dilawar_cd.sh
fi

if [ -f $SCRIPTHOME/notes.sh ]; then
    source $SCRIPTHOME/notes.sh
fi

# some more ls aliases
alias rm='rm -i'
alias sh='bash'
alias src='source ~/.bashrc'
alias gist='gist -c'
alias rsync='rsync --progress'
alias i='sudo emerge -avu --autounmask-write'
alias netcat='nc.openbsd'
alias ii='sudo apt-get -c ~/.aptconf install'
alias s='apt-cache search'
alias u='sudo apt-get upgrade'
alias cpptags='ctags --c++-kinds=+p --fields=+iaS --extra=+q'
alias pandoc='pandoc --data-dir=$HOME/Scripts/pandoc'
alias lynx='lynx --cfg=$HOME/Scripts/lynx.cfg'
alias c='dilawar_cd'
alias antlr4='java -jar /opt/antlr/antlr-4.0-complete.jar'
alias antrlworks='/opt/antlr/antlrworks2/bin/antlrworks2'
alias gcal='gcalcli --calendar="dilawar"'
alias tmux='tmux -f $SCRIPTHOME/tmux/tmux.conf'
alias move='mv -v -u -n'
# Notify when done.
alias lwd='$HOME/Scripts/notify_when_done.sh'

export GOPATH=$HOME/go
if [ -f /etc/profile.d/bash-completion.sh ]; then
    source /etc/profile.d/bash-completion.sh 
fi
export SSHPASS=jH7qMYpF

export PATH="$PATH:/home_local/dilawars/sbw-2.10.0/bin/"
export PATH=$PATH:$HOME/.cabal/bin
export PYTHONPATH="$HOME/Work/GITHUB/DILAWAR/moose-core/_build/python"
#export PYTHONPATH="$HOME/Work/GITHUB/DILAWAR/ngspyce/"
#export PYTHONPATH="$PYTHONPATH:$HOME/Work/GITHUB/DILAWAR/yacml"
export HOMEBREW_GITHUB_API_TOCKEN=8e08eccfe2ad9a8526ccf8992b4c68252fe390eb
#export PATH=/opt/texlive/2016/bin/x86_64-linux/:$PATH
#export TEXMF=/usr/share/texmf

# added by travis gem
[ -f /home1/dilawars/.travis/travis.sh ] && source /home1/dilawars/.travis/travis.sh

export JAVA_FLAGS="-Dhttp.proxyHost=proxy.ncbs.res.in -Dhttp.proxyPort=3128"
alias java='java ${JAVA_FLAGS}'

# Make sure that java launches with awesome windowmanager
export AWT_TOOLKIT=MToolkit
export PYTHONSTARTUP=$SCRIPTHOME/python_startup.py


# User scripts
# source bash-preexec.sh 
# Now for very command prefix is with alert command so that I can get notified.
source alert.sh
#xrdb ~/Scripts/Xresources
unset SSH_ASKPASS
eval "$(pandoc --bash-completion)"

# Lualatex 
export CLUAINPUTS=$HOME/.luarocks/share/lua/5.2:$CLUAINPUTS
LUA_PATH=/usr/share/lua/5.2/?.lua;/usr/share/lua/5.2/?/init.lua;/usr/lib64/lua/5.2/?.lua;/usr/lib64/lua/5.2/?/init.lua;./?.lua;/home1/dilawars/.luarocks/share/lua//?.lua
