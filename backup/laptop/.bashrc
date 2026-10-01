# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='\[\e[49;91;1m\]\u@\h \W \$\[\e[49;39;1;3m\] '

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

clear
fastfetch
