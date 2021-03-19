# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/dno/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# editor
export EDITOR=vim

# prompt
PROMPT="[%n@%m %~]%# "

# alias
alias ls='ls --color=auto'
alias ll='ls -l'
alias view='vim -R'

# history-search
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end

