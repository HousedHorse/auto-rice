# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "[${BRANCH}${STAT}]"
	else
		echo ""
	fi
}

# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}

unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

#sqlite
alias sqlite='sqlite3'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export PATH=$PATH:/home/housedhorse/.vim/bundle/vim-live-latex-preview/bin:/home/housedhorse/.local/bin

# --My aliases--
# Aliases for makefile typos
alias aekm='make'
alias aemk='make'
alias akem='make'
alias akme='make'
alias amek='make'
alias amke='make'
alias eakm='make'
alias eamk='make'
alias ekam='make'
alias ekma='make'
alias emak='make'
alias emka='make'
alias kaem='make'
alias kame='make'
alias keam='make'
alias kema='make'
alias kmae='make'
alias kmea='make'
alias maek='make'
alias makee='make'
alias makke='make'
alias maake='make'
alias mmake='make'
alias meak='make'
alias meka='make'
alias mkae='make'
alias mkea='make'
# Alias for python3
alias python='python3'
alias pip='pip3'
# Aliases for vim
alias vim='nvim'
alias vi='vim'
alias v='vim'
alias vmi='vim'
alias mvi='vim'
alias ivm='vim'
alias imv='vim'
alias vimm='vim'
alias vii='vim'
alias vvi='vim'

alias fixnet='sudo /etc/init.d/network-manager restart'

alias cpu='top -b -n1 -c'

# disable ctrl s
stty -ixon

#save changed directory as last changed directory
function cd_
{
  cd "$@"
  echo $PWD > ~/.last_dir
}

alias cd='cd_'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# weather
alias weather='curl wttr.in/ottawa'

# SSH STUFF
alias rpi='sshpass -p "aegis112" ssh rpi'
alias hilltops='sshpass -p "!aegis112" ssh hilltops'
alias archvm='sshpass -p "aegis112" ssh archvm'

# make PDFs
alias makepdf='ppttopdf'
alias mpdf='makepdf'
alias mkpdf='makepdf'

# scrot for screenshots
alias scrot='scrot ~/pictures/screenshots/%m-%d_%H:%M:%S.png $ARGS'

# mpc-qt for videos
mpc-qt_() {
  mpc-qt "$1"&
}
alias mpc-qt='mpc-qt_'

# R convenience
alias r='R'
alias rscript='Rscript'

#mupdf
mupdf_() {
  mupdf "$1" > /dev/null 2> /dev/null&
}
alias mupdf='mupdf_'

# sudo stuff
alias sudo='sudo '

# change wallpaper
change-wallpaper() {
  rm ~/.wallpaper
  ln -s $(realpath "$1") ~/.wallpaper
}
alias cwp='change-wallpaper '

export EDITOR=nvim
export BROWER=firefox

# git completion
source ~/.scripts/git-completion.bash

# prompt and directory colors
LS_COLORS=$LS_COLORS:'ln=1;34:di=1;36:fi=37:' ; export LS_COLORS
export PS1="\[\e[1;34m\]\u@\h\[\e[36m\]:\[\e[0;36m\]\w\[\e[32m\]\`parse_git_branch\`\[\e[0m\]\\$ "

# default image viewer
alias feh="sxiv"
