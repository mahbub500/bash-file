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
#force_color_prompt=yes

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

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
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
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

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
inwp() { lh && vhc "$@" && cd "$@" && systemctl reload apache2 && wpcd &&
 chw && wpcc --dbname="$@" && 
 wpdc && wpci --title="$@" --url="$@" && wpit &&
 wptt && wpup && wpip && wpcm && wpam && wpic && wpdt && 
 wp menu item add-custom menu Admin "$@/wp-admin" --allow-root && wppl && chw; }

 
rmwp() { lh && cd "$@" && wp db drop --allow-root && vhd "$@" && lh && cl && ls; }

cpb() {

    read -r -p 'Type (1: Plugin / 2: Client): ' type
    read -r -p 'Name: ' name
    read -r -p 'Slug: ' slug
    read -r -p 'Package: ' package
    read -r -p 'Prefix: ' prefix
    read -r -p 'Constant: ' constant
    read -r -p 'Description: ' description

    if [ "$type" == 1 ]; then
    git clone https://sadekur@bitbucket.org/codexpertio/cx-plugin.git "$slug"; #clone boilerplate for Plugin
    fi

    if [ "$type" == 2 ]; then
    git clone -b client https://sadekur@bitbucket.org/codexpertio/cx-plugin.git "$slug"; #clone boilerplate Client
    fi

    cd "$slug"; # enter into the dir
    mv "cx-plugin.php" "$slug.php";

    if [ "$name" != "" ]; then
      find ./ -type f -readable -writable -exec sed -i "s/CX Plugin/$name/g" {} \; # replace name
    fi

    if [ "$slug" != "" ]; then
      find ./ -type f -readable -writable -exec sed -i "s/cx-plugin/$slug/g" {} \; # replace slug and domain
    fi

    if [ "$package" != "" ]; then
      find ./ -type f -readable -writable -exec sed -i "s/CX_Plugin/$package/g" {} \; # replace namespace
    fi

    if [ "$prefix" != "" ]; then
      find ./ -type f -readable -writable -exec sed -i "s/cx_plugin/$prefix/g" {} \; # replace prefix
    fi

    if [ "$constant" != "" ]; then
      find ./ -type f -readable -writable -exec sed -i "s/CXP/$constant/g" {} \; # replace constant
    fi

    if [ "$description" != "" ]; then
      find ./ -type f -readable -writable -exec sed -i "s/Just another plugin by Codexpert/$description/g" {} \; # replace description
    fi
    
    composer install; # update composer element
    rm -r .git; # remove .git dir
    gi; #init git again
    ga;
    gc -m "init";
}
sr() {
    find ./ -type f -readable -writable -exec sed -i "s/$1/$2/g" {} \;
}
cpp() {
    read -r -p 'Plugin Slug:' slug # Read Plugin Name
    git clone "https://sadekur@bitbucket.org/codexpertio/$slug.git"; #Clone Plugin
    cd "$slug"; #Enter the plugin directory
    comu; #Composer Update
}

# Show git branch name
force_color_prompt=yes
color_prompt=yes
parse_git_branch() {
 git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
if [ "$color_prompt" = yes ]; then
 PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;31m\]$(parse_git_branch)\[\033[00m\]\$ '
else
 PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w$(parse_git_branch)\$ '
fi
unset color_prompt force_color_prompt
export PATH=$PATH:/usr/local/mysql/bin

#cpb (){
    # Name: abc
    # Slug: abc-abc
    # Package: Abc_Abc
    # Prefix: ab
    # Constant: ABC_ABC
    # Description: some description
#}

